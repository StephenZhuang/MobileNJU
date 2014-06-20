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
#import "TreeHoleListViewController.h"
#import "NanguaViewController.h"
#import "ChatViewController.h"
#import "ZsndIndex.pb.h"
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
@property (strong,nonatomic)MUnread_Builder* unread;
@property (strong,nonatomic)NSArray* focusList;
@property (weak, nonatomic) IBOutlet UIButton *subscribeButton;
@property (weak, nonatomic) IBOutlet UIButton *activityButton;
@end

@implementation MainMenuViewController
static NSArray* buttonImages;
static NSArray* descriptions;
#pragma mark ViewController


- (void)viewDidLoad
{
    
    [super viewDidLoad];
    //    [self.navigationController setDelegate:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getCall:) name:@"getCall" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goToChat:) name:@"getPushInfo" object:nil];
    [self initNewScroller];
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImage:)];
    [self.pageScroller addGestureRecognizer:singleTap];
    self.changeHeader = NO;
    [self.homeBarButton setSelected:YES];
    [self.tableView setAllowsSelection:NO];
    [self loadIndex];
}
-(void)viewWillAppear:(BOOL)animated
{
//    [self.tableView reloadData];
//    [self addUnreadMsg];
    [[ApisFactory getApiMUnreadModule]load:self selecter:@selector(disposeMessage:)];

}
- (void)loadIndex
{
    [[ApisFactory getApiMIndex]load:self selecter:@selector(disposeMessage:)];
}




- (void)disposeMessage:(Son*)son
{
    if ([son getError]==0) {
        NSLog(@"son method %@",[son getMethod]);
        if ([[son getMethod] isEqualToString:@"MIndex"]) {
            MIndex_Builder* index = (MIndex_Builder*)[son getBuild];
//            NSMutableArray* image = [[NSMutableArray alloc]init];
//
//            for (MMdoule* model in index.moduleList) {
//                NSLog(@"model %@ %@",model.name,model.desc);
//                [array addObject:model.name];
//            }
            self.focusList = index.focusList;
           
            
            [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(loadTableData) userInfo:nil repeats:NO];
            [self addUnreadMsg];
            [self prepareForNews];

        } else if ([[son getMethod]isEqualToString:@"MUnreadModule"])
        {
            self.unread = (MUnread_Builder*)[son getBuild];
            [self addUnreadMsg];
        }
    }
}
- (void)loadTableData
{
    buttonImages= [[NSArray alloc]initWithObjects:@"百合十大",@"图书馆",@"南呱",@"树洞",@"一卡通",@"课程表",@"失物招领",@"空教室",@"部门电话",@"绩点",@"校车",@"打卡",@"流程", nil];
    descriptions = [[NSArray alloc]initWithObjects:@"每天十条",@"查书/借阅情况",@"陌生人的心声",@"吐槽你的心声",@"余额及消费",@"课程一览无遗",@"捡到？丢了？",@"找没课的自习室",@"电话查询",@"不断飙升的绩点",@"校车地点/时刻表",@"打卡次数查询",@"全部在这里", nil];
    [self.tableView reloadData];
}
- (void)addUnreadMsg
{
    if (self.unread!=nil&&buttonImages.count>0) {
        NSLog(@"不为nil");
        if (self.unread.module1>0) {
            NSIndexPath* index = [NSIndexPath indexPathForRow:[buttonImages indexOfObject:@"南呱"] inSection:0];
            HomeCell* cell = (HomeCell*)[self.tableView cellForRowAtIndexPath:index];
            [cell.menuButton setImage: [UIImage imageNamed:@"南呱消息"] forState:UIControlStateNormal];
            [cell.menuButton setImage:[UIImage imageNamed:@"南呱消息选中"]  forState:UIControlStateHighlighted];
            [cell.menuButton setImage:[UIImage imageNamed:@"南呱消息选中"] forState:UIControlStateSelected];
        } else {
            NSIndexPath* index = [NSIndexPath indexPathForRow:[buttonImages indexOfObject:@"南呱"] inSection:0];
            HomeCell* cell = (HomeCell*)[self.tableView cellForRowAtIndexPath:index];
            [cell.menuButton setImage: [UIImage imageNamed:@"南呱"] forState:UIControlStateNormal];
            [cell.menuButton setImage:[UIImage imageNamed:@"南呱选中"]  forState:UIControlStateHighlighted];
            [cell.menuButton setImage:[UIImage imageNamed:@"南呱选中"] forState:UIControlStateSelected];
        }
        if (self.unread.module2>0) {

            NSIndexPath* index = [NSIndexPath indexPathForRow:[buttonImages indexOfObject:@"树洞"] inSection:0];
            HomeCell* cell = (HomeCell*)[self.tableView cellForRowAtIndexPath:index];
            [cell.menuButton setImage: [UIImage imageNamed:@"树洞消息"] forState:UIControlStateNormal];
            [cell.menuButton setImage:[UIImage imageNamed:@"树洞消息选中"]  forState:UIControlStateHighlighted];
            [cell.menuButton setImage:[UIImage imageNamed:@"树洞消息选中"] forState:UIControlStateSelected];
        } else {
            NSIndexPath* index = [NSIndexPath indexPathForRow:[buttonImages indexOfObject:@"树洞"] inSection:0];
            HomeCell* cell = (HomeCell*)[self.tableView cellForRowAtIndexPath:index];
            [cell.menuButton setImage: [UIImage imageNamed:@"树洞"] forState:UIControlStateNormal];
            [cell.menuButton setImage:[UIImage imageNamed:@"树洞选中"]  forState:UIControlStateHighlighted];
            [cell.menuButton setImage:[UIImage imageNamed:@"树洞选中"] forState:UIControlStateSelected];
        }
        if (self.unread.module3>0) {
            [self.subscribeButton setImage: [UIImage imageNamed:@"订阅消息"] forState:UIControlStateNormal];
            [self.subscribeButton setImage:[UIImage imageNamed:@"订阅消息选中"]  forState:UIControlStateHighlighted];
            [self.subscribeButton setImage:[UIImage imageNamed:@"订阅消息选中"] forState:UIControlStateSelected];
        } else {
            [self.subscribeButton setImage: [UIImage imageNamed:@"订阅"] forState:UIControlStateNormal];
            [self.subscribeButton setImage:[UIImage imageNamed:@"订阅选中"]  forState:UIControlStateHighlighted];
            [self.subscribeButton setImage:[UIImage imageNamed:@"订阅选中"] forState:UIControlStateSelected];
        }
        if (self.unread.module4>0) {

            [self.activityButton setImage: [UIImage imageNamed:@"活动消息"] forState:UIControlStateNormal];
            [self.activityButton setImage:[UIImage imageNamed:@"活动消息选中"]  forState:UIControlStateHighlighted];
            [self.activityButton setImage:[UIImage imageNamed:@"活动消息选中"] forState:UIControlStateSelected];
        } else {
            [self.activityButton setImage: [UIImage imageNamed:@"活动"] forState:UIControlStateNormal];
            [self.activityButton setImage:[UIImage imageNamed:@"活动选中"]  forState:UIControlStateHighlighted];
            [self.activityButton setImage:[UIImage imageNamed:@"活动选中"] forState:UIControlStateSelected];
        }
        

    }
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
    self.cloudBack = [[UIImageView alloc]initWithFrame:CGRectMake(0,-5.0, self.tableView.bounds.size.width, 87)];
    [self.cloudBack setImage:background];
    [self.headerView addSubview:self.cloudBack];

    UIImage* touch = [UIImage imageNamed:@"触控区"];
    self.touchButton = [[UIImageView alloc]initWithFrame:CGRectMake(132.5, 30, 55, 55)];
    [self.touchButton setImage:touch];
    [self.headerView addSubview:self.touchButton];
    return self.headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
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
   [UIView animateWithDuration:duration/4 delay:delay options:UIViewAnimationOptionCurveEaseIn animations:^{
        view.transform = CGAffineTransformMakeTranslation(-10, 0);
   } completion:^(BOOL finished) {
       [UIView animateWithDuration:duration/4 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
           view.transform = CGAffineTransformMakeTranslation(5, 0);
       } completion:^(BOOL finished) {
           [UIView animateWithDuration:duration/4 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                view.transform = CGAffineTransformMakeTranslation(-2, 0);
           } completion:^(BOOL finished) {
               [UIView animateWithDuration:duration/4 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
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
    [UIView animateWithDuration:duration/4 delay:delay options:UIViewAnimationOptionCurveEaseIn animations:^{
        view.transform = CGAffineTransformMakeTranslation(10, 0);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:duration/4 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            view.transform = CGAffineTransformMakeTranslation(-5, 0);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:duration/4 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                view.transform = CGAffineTransformMakeTranslation(2, 0);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:duration/4 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
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
    if ([menuButton.desitination isEqualToString:@"树洞"]) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"TreeHole" bundle:nil];
        TreeHoleListViewController *vc = [storyboard instantiateInitialViewController];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([menuButton.desitination isEqualToString:@"南呱"]) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Nangua" bundle:nil];
        NanguaViewController *vc = [storyboard instantiateInitialViewController];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        [self performSegueWithIdentifier:menuButton.desitination  sender:nil];
    }
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
    MFocus* focus = [self.focusList objectAtIndex:site-1];
    [imageView setImageWithURL:[ToolUtils getImageUrlWtihString:focus.img width:320 height:217]];
}


//加载新的cache (在此之前需要访问服务器 看是否需要下载新的图片
- (void)loadNewsCache:(NSInteger)site
{
//    NSArray* tempPhoto = [[NSArray alloc]initWithObjects:@"news",@"news2",@"news3", nil];
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
        
        
        NSInteger page = self.pageController.currentPage;
        MFocus* focus = [self.focusList objectAtIndex:page];
        CGRect frame;
        frame.origin.x = 0;
        frame.size = self.pageScroller.frame.size;
        frame.origin.y = self.headerView.frame.size.height-frame.size.height-40;
        _newImage = [[UIImageView alloc]initWithFrame:frame];
        [_newImage setImageWithURL:[ToolUtils getImageUrlWtihString:focus.img width:320 height:217]];

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
    UINavigationController* unc = (UINavigationController*)[secondStoryBoard instantiateViewControllerWithIdentifier:@"newsList"]; //test2为viewcontroller的StoryboardId
    NewsListTVC* newsList = (NewsListTVC*)[unc.childViewControllers firstObject];
    newsList.jump = YES;
    [self presentViewController:unc animated:YES completion:^{
        
    }];
}

#pragma - mark callview
- (void)getCall:(NSNotification *)notification
{
    if (![[self.navigationController.viewControllers lastObject] isKindOfClass:NSClassFromString(@"ChatViewController")]) {
        [self showCallView:notification.userInfo];
    }
}

- (void)cancelCall
{
    [[ApisFactory getApiMChatCallBack] load:self selecter:@selector(disposMessage:) id:self.callView.targetid type:0];
    [self dismissCallView];
}

- (void)confirmCall
{
    [[ApisFactory getApiMChatCallBack] load:self selecter:@selector(disposMessage:) id:self.callView.targetid type:1];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Nangua" bundle:nil];
    ChatViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"ChatViewController"];
    vc.targetid = self.callView.targetid;
    [self.navigationController pushViewController:vc animated:YES];
    [self dismissCallView];
}

- (void)showCallView:(NSDictionary *)userInfo
{
    [self addMask];
    if (!self.callView) {
        self.callView = [[[NSBundle mainBundle] loadNibNamed:@"CallView" owner:self options:nil] firstObject];
    }
    self.callView.transform = CGAffineTransformIdentity;
    [self.callView setTargetid:[userInfo objectForKey:@"id"]];
    [self.callView.cancelButton addTarget:self action:@selector(cancelCall) forControlEvents:UIControlEventTouchUpInside];
    [self.callView.confirmButton addTarget:self action:@selector(confirmCall) forControlEvents:UIControlEventTouchUpInside];

    self.callView.center = [UIApplication sharedApplication].keyWindow.center;
    [self show];
    [[UIApplication sharedApplication].keyWindow addSubview:self.callView];
}

- (void)dismissCallView
{
    [self removeMask];
    [self hide];
}

- (void)addMask
{
    if (!self.maskView) {
        self.maskView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    }
    [self.maskView setBackgroundColor:[UIColor blackColor]];
    [self.maskView setAlpha:0.5];
    [[UIApplication sharedApplication].keyWindow addSubview:self.maskView];
}

- (void)removeMask
{
    [self.maskView removeFromSuperview];
}

- (void)show
{
//    self.editView.center = CGPointMake(self.view.center.x, 150);
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.4;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.2f, @0.5f, @0.75f, @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [self.callView.layer addAnimation:popAnimation forKey:nil];
}

- (void)hide
{
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.callView.transform = CGAffineTransformMakeScale(1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.callView.transform = CGAffineTransformMakeScale(0, 0);
        } completion:^(BOOL finished) {
            [self.callView removeFromSuperview];
        }];
    }];
}

- (void)goToChat:(NSNotification *)notification
{
    NSString *type = notification.object;
    if (type.integerValue == 1) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Nangua" bundle:nil];
        ChatViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"ChatViewController"];
        vc.targetid = [notification.userInfo objectForKey:@"target"];
        [self.navigationController pushViewController:vc animated:YES];
        [self dismissCallView];
    }
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
