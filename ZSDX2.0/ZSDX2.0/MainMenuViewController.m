//
//  MainMenuViewController.m
//  ZSDX2.0
//
//  Created by luck-mac on 14-5-8.
//  Copyright (c) 2014年 zsdx. All rights reserved.
//

#import "MainMenuViewController.h"
#import "HomeCell.h"
@interface MainMenuViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *menuView;
@property (weak, nonatomic) IBOutlet UIImageView *touchCircle;
@property (nonatomic)CGPoint leftCenter;
@property (nonatomic)CGPoint rightCenter;
@property (weak, nonatomic) IBOutlet UIPageControl *pageController;
@property (weak, nonatomic) IBOutlet UIScrollView *pageScroller;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation MainMenuViewController

static NSArray* buttonImages;


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [buttonImages count]+1;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCell *homeCell = (HomeCell *)cell;
    [homeCell setBackgroundColor:[UIColor clearColor]];
    if (indexPath.row % 2 == 1) {
        [self performBounceRightAnimationOnView:homeCell.menuButton duration:0.5 delay:0.2];
    } else {
        [self performBounceLeftAnimationOnView:homeCell.menuButton duration:0.5 delay:0.2];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCell *cell = nil;
    
    if (indexPath.row % 2 == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"LeftCell"];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"RightCell"];
    }
    if (indexPath.row<=[buttonImages count]-1) {
        UIImage* image = [UIImage imageNamed:[buttonImages objectAtIndex:indexPath.row]];
        [cell.menuButton setImage:image forState:UIControlStateNormal];
        [cell.menuButton setDesitination:[buttonImages objectAtIndex:indexPath.row]];
        [cell.menuButton addTarget:self action:@selector(
                                                         goToDetail
                                                :) forControlEvents:UIControlEventTouchUpInside];

    } else {
        [cell.menuButton setImage:nil forState:UIControlStateNormal];
    }
   return cell;
}

-(void)goToDetail:(id)sender{
    MenuButton* menuButton = (MenuButton*)sender;
    [self performSegueWithIdentifier:menuButton.desitination  sender:nil];
}

- (void)performBounceLeftAnimationOnView:(UIView *)view duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay {
    // Start
    view.transform = CGAffineTransformMakeTranslation(300, 0);
    [UIView animateKeyframesWithDuration:duration/4 delay:delay options:0 animations:^{
        // End
        view.transform = CGAffineTransformMakeTranslation(-10, 0);
    } completion:^(BOOL finished) {
        [UIView animateKeyframesWithDuration:duration/4 delay:0 options:0 animations:^{
            // End
            view.transform = CGAffineTransformMakeTranslation(5, 0);
        } completion:^(BOOL finished) {
            [UIView animateKeyframesWithDuration:duration/4 delay:0 options:0 animations:^{
                // End
                view.transform = CGAffineTransformMakeTranslation(-2, 0);
            } completion:^(BOOL finished) {
                [UIView animateKeyframesWithDuration:duration/4 delay:0 options:0 animations:^{
                    // End
                    view.transform = CGAffineTransformMakeTranslation(0, 0);
                } completion:^(BOOL finished) {
                    
                }];
            }];
        }];
    }];
}

- (void)performBounceRightAnimationOnView:(UIView *)view duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay {
    // Start
    view.transform = CGAffineTransformMakeTranslation(-300, 0);
    [UIView animateKeyframesWithDuration:duration/4 delay:delay options:0 animations:^{
        // End
        view.transform = CGAffineTransformMakeTranslation(10, 0);
    } completion:^(BOOL finished) {
        [UIView animateKeyframesWithDuration:duration/4 delay:0 options:0 animations:^{
            // End
            view.transform = CGAffineTransformMakeTranslation(-5, 0);
        } completion:^(BOOL finished) {
            [UIView animateKeyframesWithDuration:duration/4 delay:0 options:0 animations:^{
                // End
                view.transform = CGAffineTransformMakeTranslation(2, 0);
            } completion:^(BOOL finished) {
                [UIView animateKeyframesWithDuration:duration/4 delay:0 options:0 animations:^{
                    // End
                    view.transform = CGAffineTransformMakeTranslation(0, 0);
                } completion:^(BOOL finished) {
                    
                }];
            }];
        }];
    }];
}





/*
 storyBoard加的
 得先remove再add才能移动
 不知如何解决
 */




/*飞入动画*/



/*
 手势响应 
 menuView的中心高度有限制
 存在magic Number;
 */
- (void)moveMenu:(UIPanGestureRecognizer *)recognizer
{
    
    CGPoint point = [recognizer locationInView:self.view];
    CGFloat windowHeight = self.view.window.bounds.size.height;
    CGFloat minCenterHeight = windowHeight==480?270:293;
    CGFloat shift = windowHeight==480?175:215;
    CGFloat initCenterHeight = windowHeight==480?405:445;
    point.y = point.y+shift;
    if (point.y>=minCenterHeight&&point.y<=initCenterHeight){
        point.x = self.menuView.center.x;
        [self.menuView setCenter:point];
    }
}


#warning 此处需要改
/*
 加载图片，此处暂时拿3张现成的
 */
-(void)loadPhotos
{
    for (int i = 1; i < 3 ; i ++){
        [self loadNewsCache:i];
    }
}

-(UIImage *)getEmptyUIImage
{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.pageScroller.frame.size.width,
                                                      self.pageScroller.frame.size.height), NO, 0.0);
    UIImage *blank = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return blank;
}


//重新加载图片
- (void)reloadNews:(NSInteger)site
{
    UIImageView *imageView = [[self.pageScroller subviews] objectAtIndex:site+1];
    [imageView setImage:[self.photoList objectAtIndex:site-1]];
}

//保存图片在catch
- (void)saveNewsCache:(NSInteger)site image:(UIImage*)image
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *newsPic = [NSString stringWithFormat:@"news_%d.jpg", (int)site];
    NSString *imgPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:newsPic];
    [UIImagePNGRepresentation(image) writeToFile:imgPath atomically:YES];
}

//加载新的cache (在此之前需要访问服务器 看是否需要下载新的图片
- (void)loadNewsCache:(NSInteger)site
{
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
//    NSString *newsPic = [NSString stringWithFormat:@"news_%d.jpg", (int)site];
//    NSString *imgPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:newsPic];
//    NSLog(@"%@",imgPath);
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    BOOL exist = [fileManager fileExistsAtPath:imgPath];
//    if (exist)
//    {
//        NSLog(@"exist");
//        NSData *data=[NSData dataWithContentsOfFile:imgPath];
//        UIImage *img=[UIImage imageWithData:data];
//        [self.photoList replaceObjectAtIndex:site-1 withObject:img];
//        [self reloadNews:site];
//    }
    NSArray* tempPhoto = [[NSArray alloc]initWithObjects:@"news",@"news2",@"news3", nil];
    UIImage* img = [UIImage imageNamed:[tempPhoto objectAtIndex:site-1]];
    [self.photoList replaceObjectAtIndex:site-1 withObject:img];
    [self reloadNews:site];
}


//加载图片至scrollerView
- (void)loadNews
{
    NSInteger pageCount = [self.photoList count];
    self.pageController.currentPage = 0;
    self.pageController.numberOfPages = pageCount;
    CGSize pageScrollViewSize = self.pageScroller.frame.size;
    self.pageScroller.contentSize = CGSizeMake(pageScrollViewSize.width * self.photoList.count, pageScrollViewSize.height);
    for (NSInteger i = 0; i<pageCount; i++)
    {
        CGRect frame;
        frame.origin.x = self.pageScroller.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = self.pageScroller.frame.size;
        UIImageView *pageView = [[UIImageView alloc] initWithImage:[self.photoList objectAtIndex:i]];
        pageView.frame = frame;
        pageView.contentMode = UIViewContentModeScaleAspectFit;
        [pageView setClipsToBounds:YES];
        [self.pageScroller addSubview:pageView];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int index=scrollView.contentOffset.x/scrollView.frame.size.width;
    self.pageController.currentPage=index;
}



-(void)pageChange:(UIPageControl *)sender{
    NSLog(@"%f",self.pageScroller.bounds.size.height);
    CGFloat offset= self.pageController.currentPage*320;
    [self.pageScroller setContentOffset:CGPointMake(offset, 0) animated:YES];
}


- (void)initNewScroller
{
    self.pageScroller.delegate = self;
    self.pageScroller.pagingEnabled=YES;
    [self.pageController addTarget:self action:@selector(pageChange:)
                  forControlEvents:UIControlEventTouchUpInside];
}
- (void)prepareForAnimation
{
    
    // 手势监听
    UIPanGestureRecognizer *pan=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(moveMenu:)];
    [self.touchCircle addGestureRecognizer:pan];
    [self.touchCircle setUserInteractionEnabled:YES];
}


-(void) timerChangePic
{
    if (self.pageController.currentPage == self.pageController.numberOfPages-1)
    {
        [self.pageController setCurrentPage:0];
    }
    else
    {
        [self.pageController setCurrentPage:self.pageController.currentPage+1];
    }
    [self.pageScroller setContentOffset:CGPointMake(320*self.pageController.currentPage, 0) animated:YES];
}

- (void)prepareForNews
{
    self.photoList = [[NSMutableArray alloc]init];
    for (int i = 0; i<3; i++) {
        [self.photoList addObject:[self getEmptyUIImage]];
    }
    [self loadNews];
    for (int i = 1; i<=3; i++) {
        [self loadNewsCache:i];
    }
    [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(timerChangePic) userInfo:nil repeats:YES];

}

-(void) onClickImage{
    [self performSegueWithIdentifier:@"news" sender:nil];
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    [self initNewScroller];
    [self prepareForAnimation];
    [self prepareForNews];
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImage)];
    [self.pageScroller addGestureRecognizer:singleTap];
    buttonImages= [[NSArray alloc]initWithObjects:@"bbs",@"library",@"chat",@"hole",@"ecard",@"classroom",@"lose",@"schedule",@"phone",@"bus",@"procedure",@"exercise", nil];
        // Do any additional setup after loading the view.

}



/*
 appear的时候开始动画
 */
- (void)viewDidAppear:(BOOL)animated
{
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
