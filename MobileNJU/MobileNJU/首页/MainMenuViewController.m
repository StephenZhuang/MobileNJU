//
//  MainMenuViewController.m
//  ZSDX2.0
//
//  Created by luck-mac on 14-5-8.
//  Copyright (c) 2014年 zsdx. All rights reserved.
//

#import "MainMenuViewController.h"
#import "HomeCell.h"
#import "SelfInfoVC.h"
#import "NewsListTVC.h"
@interface MainMenuViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIPageControl *pageController;
@property (weak, nonatomic) IBOutlet UIScrollView *pageScroller;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic)UIView* headerView;
@property (nonatomic)BOOL changeHeader;
@property (weak, nonatomic) IBOutlet UIView *tableHeadView;
@property (strong,nonatomic)UIImageView* newImage;
@property (strong,nonatomic)UIImageView* touchButton;
@property (weak, nonatomic) IBOutlet UIButton *homeBarButton;
@property (strong,nonatomic)UIImageView* cloudBack;
@end

@implementation MainMenuViewController
static NSArray* buttonImages;
static NSArray* descriptions;
#pragma mark ViewController


- (void)viewDidLoad
{
    
    [super viewDidLoad];
    //    [self.navigationController setDelegate:self];
    [self initNewScroller];
    [self prepareForNews];
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImage:)];
    [self.pageScroller addGestureRecognizer:singleTap];
    buttonImages= [[NSArray alloc]initWithObjects:@"百合十大",@"图书馆",@"南呱",@"树洞",@"一卡通",@"课程表",@"失物招领",@"空教室",@"部门电话",@"绩点",@"校车",@"打卡",@"流程", nil];
    descriptions = [[NSArray alloc]initWithObjects:@"每天十条",@"查书/借阅情况",@"陌生人的心声",@"吐槽你的心声",@"余额及消费",@"课程一览无遗",@"捡到？丢了？",@"找没课的自习室",@"电话查询",@"不断飙升的绩点",@"校车地点/时刻表",@"打卡次数查询",@"全部在这里", nil];
    self.changeHeader = NO;
    [self.homeBarButton setSelected:YES];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark segue
#warning 此处可以根据currentPage来判断点击了哪个图片
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"news"]) {
        UINavigationController* destinationVC = (UINavigationController*)segue.destinationViewController
        ;
        [destinationVC setTitle:@"啦啦啦啊啦"];
    }
}

#pragma mark 监听

/*
 个人 跳到self的storyboard
 */
- (IBAction)self:(id)sender {
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"Self" bundle:nil];
    SelfInfoVC* selfVC = (SelfInfoVC*)[secondStoryBoard instantiateViewControllerWithIdentifier:@"self"]; //test2为viewcontroller的StoryboardId
    [self.navigationController pushViewController:selfVC animated:YES];
}
- (IBAction)subscribe:(id)sender {
        UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"News" bundle:nil];
        SelfInfoVC* selfVC = (SelfInfoVC*)[secondStoryBoard instantiateViewControllerWithIdentifier:@"subscribe"]; //test2为viewcontroller的StoryboardId
        [self.navigationController pushViewController:selfVC animated:YES];
}
- (IBAction)activity:(id)sender {
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"News" bundle:nil];
    SelfInfoVC* selfVC = (SelfInfoVC*)[secondStoryBoard instantiateViewControllerWithIdentifier:@"activity"]; //test2为viewcontroller的StoryboardId
    [self.navigationController pushViewController:selfVC animated:YES];
}


#pragma mark tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [buttonImages count]+3;
    //此处+3 只是为下方预留空间
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    // set header view colour
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 100)];
    
    [self.headerView setBackgroundColor:[UIColor clearColor]];
    

    
    UIImage* background = [UIImage imageNamed:@"云"];
    self.cloudBack = [[UIImageView alloc]initWithFrame:CGRectMake(0,-5.0, self.tableView.bounds.size.width, 50)];
    [self.cloudBack setImage:background];
    [self.headerView addSubview:self.cloudBack];

    UIImage* touch = [UIImage imageNamed:@"触控区"];
    self.touchButton = [[UIImageView alloc]initWithFrame:CGRectMake(132.5, 30, 55, 55)];
    [self.touchButton setImage:touch];
    [self.headerView addSubview:self.touchButton];
    return self.headerView;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 53;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 80;
}


/*
 进入屏幕后开启动画
 */
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCell *homeCell = (HomeCell *)cell;
    [homeCell setBackgroundColor:[UIColor clearColor]];
    if (indexPath.row % 2 == 1) {
        [self performBounceRightAnimationOnView:homeCell.menuView duration:1.0 delay:0.3f];
    } else {
        [self performBounceLeftAnimationOnView:homeCell.menuView duration:1.0 delay:0.3f];
    }
}


/*
 根据奇偶 对应左右
 */
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
        UIImage* imageSelected = [UIImage imageNamed:[NSString stringWithFormat:@"%@选中",[buttonImages objectAtIndex:indexPath.row]]];
        [cell.menuButton setImage:image forState:UIControlStateNormal];
        [cell.menuButton setImage:imageSelected forState:UIControlStateHighlighted];
         [cell.menuButton setImage:imageSelected forState:UIControlStateSelected];
        [cell.menuButton setDesitination:[buttonImages objectAtIndex:indexPath.row]];
        [cell.menuTitle setText:[buttonImages objectAtIndex:indexPath.row]];
        [cell.menuSubTitle setText:[descriptions objectAtIndex:indexPath.row]];
        [cell.menuButton addTarget:self action:@selector(
                                                         goToDetail
                                                :) forControlEvents:UIControlEventTouchUpInside];

    } else {
        [cell.menuButton setImage:nil forState:UIControlStateNormal];
        [cell.menuTitle setText:@""];
        [cell.menuSubTitle setText:@""];
    }
   return cell;
}


#pragma mark 动画
- (void)performBounceLeftAnimationOnView:(UIView *)view duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay {
    [view setHidden:NO];
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
    [view setHidden:NO];
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


#pragma mark 各个按钮监听
-(void)goToDetail:(id)sender{
    MenuButton* menuButton = (MenuButton*)sender;
    [self performSegueWithIdentifier:menuButton.desitination  sender:nil];
}


#pragma mark 新闻区

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
- (UIImageView *)newImage{
    if (!_newImage) {
        int page = self.pageController.currentPage;
        _newImage = [[UIImageView alloc]initWithImage:[self.photoList objectAtIndex:page]];
        CGRect frame;
        frame.origin.x = 0;
        frame.size = self.pageScroller.frame.size;
        frame.origin.y = self.headerView.frame.size.height-frame.size.height-40;
        _newImage.frame = frame;

    }
    return _newImage;
}
-(void)changeSectionHeader:(BOOL)shoudChange
{
    if (self.changeHeader==shoudChange) {
        return;
    } else {
        self.changeHeader = shoudChange;
        if (shoudChange) {
            [self.pageScroller setHidden:YES];
            [self.headerView addSubview:self.newImage];
            [self.headerView bringSubviewToFront:self.cloudBack];
            [self.headerView bringSubviewToFront:self.touchButton];
                  } else {
                      [self.pageScroller setHidden:NO];
                      [self.newImage removeFromSuperview];
                      self.newImage = nil;
                      
        }
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView==self.pageScroller) {
        int index=scrollView.contentOffset.x/scrollView.frame.size.width;
        self.pageController.currentPage=index;
    } else if (scrollView==self.tableView){

        if (scrollView.contentOffset.y>=155.0) {
            [self changeSectionHeader:YES];
        } else {
            [self changeSectionHeader:NO];
        }
    }
}



-(void)pageChange:(UIPageControl *)sender{
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

-(void) onClickImage:(id) sender{
  
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"News" bundle:nil];
    NewsListTVC* newsVC = (NewsListTVC*)[secondStoryBoard instantiateViewControllerWithIdentifier:@"newsList"]; //test2为viewcontroller的StoryboardId
    [self presentViewController:newsVC animated:YES completion:^{
        
    }];
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
