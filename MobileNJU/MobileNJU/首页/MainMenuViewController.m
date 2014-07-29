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
#import "MyNavigationController.h"
@interface MainMenuViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIPageControl *pageController;
@property (weak, nonatomic) IBOutlet UIScrollView *pageScroller;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic)UIView* headerView;
@property (nonatomic)BOOL changeHeader;
@property (weak, nonatomic) IBOutlet UIView *tableHeadView;
@property (strong,nonatomic)UIImageView* newImage;
@property (strong,nonatomic)UIImageView* touchButton;
@property (strong,nonatomic)UIImageView* cloudBack;
@property (strong,nonatomic)MUnread_Builder* unread;
@property (strong,nonatomic)NSArray* focusList;
@property (strong,nonatomic)NSMutableArray* imageArrays;
@property (strong,nonatomic)NSMutableArray* imageArraysSelected;

@end

@implementation MainMenuViewController
static NSArray* functionNames;
static NSArray* buttonImages;
static NSArray* descriptions;

#pragma mark ViewController
- (void)viewDidLoad
{
    
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getCall:) name:@"getCall" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goToChat:) name:@"getPushInfo" object:nil];
    [self initNewScroller];
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImage:)];
    [self.pageScroller addGestureRecognizer:singleTap];
    self.changeHeader = NO;
    [self.tableView setAllowsSelection:NO];
    [self loadIndex];
    [self loadTableData];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    MyNavigationController *nav = (MyNavigationController*)self.navigationController;
    [nav hideTabBar:NO];
}
- (void)loadIndex
{
    [[ApisFactory getApiMIndex]load:self selecter:@selector(disposeMessage:)];
}

- (void)disposeMessage:(Son*)son
{
    if ([son getError]==0) {
        if ([[son getMethod] isEqualToString:@"MIndex"]) {
            MIndex_Builder* index = (MIndex_Builder*)[son getBuild];
            NSMutableArray* image = [[NSMutableArray alloc]init];
            NSMutableArray* names = [[NSMutableArray alloc]init];
            NSMutableArray* details = [[NSMutableArray alloc]init];
            for (MMdoule* model in index.moduleList) {
                [names addObject:model.name];
                [image addObject:model.img];
                [details addObject:model.desc];
            }
            if (functionNames==nil) {
                functionNames=names;
                buttonImages=image;
                descriptions=details;
                [self loadImages];
            } else {
                if (![ToolUtils compareArray:functionNames newArray:names]) {
                    functionNames=names;
                    buttonImages=image;
                    descriptions=details;
                    [self loadImages];
                }
            }
            [ToolUtils setFunctionDetails:descriptions];
            [ToolUtils setFunctionNames:functionNames];
            [ToolUtils setButtonImage:buttonImages];
            self.focusList = index.focusList;
            [self addUnreadMsg];
            [self prepareForNews];
        } else if ([[son getMethod]isEqualToString:@"MUnreadModule"])
        {
            self.unread = (MUnread_Builder*)[son getBuild];
            [self addUnreadMsg];
        }
    }
}
#warning 这里需要加上从服务器载下来的临时功能
- (void)loadTableData
{
    
    functionNames = [ToolUtils getFunctionName];
    buttonImages= [ToolUtils getButtonImage];
    descriptions = [ToolUtils getFunctionDetails];
    if (functionNames!=nil) {
        [self loadImages];
    }
}
-(void)loadImages
{
    self.imageArrays = [[NSMutableArray alloc]init];
    self.imageArraysSelected = [[NSMutableArray alloc]init];
    for (NSString* imageUrl in buttonImages) {
        CGRect frame = CGRectMake(0, 0, 52, 52);
        NSArray* imageUrls = [imageUrl componentsSeparatedByString:@","];;
        UIImageView* image = [[UIImageView alloc]init];
        image.frame = frame;
        [image setImageWithURL:[ToolUtils getImageUrlWtihString:[imageUrls firstObject]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            if (self.imageArrays.count==buttonImages.count) {
                [self.tableView reloadData];

            }
        }];
        UIImageView* imageSelected = [[UIImageView alloc]init];
        imageSelected.frame = frame;
        [imageSelected setImageWithURL:[ToolUtils getImageUrlWtihString:[imageUrls lastObject]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            if (self.imageArrays.count==buttonImages.count) {
                [self.tableView reloadData];
            }
        }];
        [self.imageArrays addObject:image];
        [self.imageArraysSelected addObject:imageSelected];
    }
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
//            [self.subscribeButton setImage: [UIImage imageNamed:@"订阅消息"] forState:UIControlStateNormal];
//            [self.subscribeButton setImage:[UIImage imageNamed:@"订阅消息选中"]  forState:UIControlStateHighlighted];
//            [self.subscribeButton setImage:[UIImage imageNamed:@"订阅消息选中"] forState:UIControlStateSelected];
        } else {
//            [self.subscribeButton setImage: [UIImage imageNamed:@"订阅"] forState:UIControlStateNormal];
//            [self.subscribeButton setImage:[UIImage imageNamed:@"订阅选中"]  forState:UIControlStateHighlighted];
//            [self.subscribeButton setImage:[UIImage imageNamed:@"订阅选中"] forState:UIControlStateSelected];
        }
        if (self.unread.module4>0) {

//            [self.activityButton setImage: [UIImage imageNamed:@"活动消息"] forState:UIControlStateNormal];
//            [self.activityButton setImage:[UIImage imageNamed:@"活动消息选中"]  forState:UIControlStateHighlighted];
//            [self.activityButton setImage:[UIImage imageNamed:@"活动消息选中"] forState:UIControlStateSelected];
        } else {
//            [self.activityButton setImage: [UIImage imageNamed:@"活动"] forState:UIControlStateNormal];
//            [self.activityButton setImage:[UIImage imageNamed:@"活动选中"]  forState:UIControlStateHighlighted];
//            [self.activityButton setImage:[UIImage imageNamed:@"活动选中"] forState:UIControlStateSelected];
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




#pragma mark tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [buttonImages count]+3;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    // set header view colour
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 100)];
    [self.headerView setBackgroundColor:[UIColor clearColor]];
    UIImage* background = [UIImage imageNamed:@"云"];
    self.cloudBack = [[UIImageView alloc]initWithFrame:CGRectMake(0,40, self.tableView.bounds.size.width, 30)];
    [self.cloudBack setImage:background];
    [self.headerView addSubview:self.cloudBack];

    UIImage* touch = [UIImage imageNamed:@"触控区"];
    self.touchButton = [[UIImageView alloc]initWithFrame:CGRectMake(132.5, 15, 55, 75)];
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
        UIImageView* image = [self.imageArrays objectAtIndex:indexPath.row];
        UIImageView* imageSelected = [self.imageArraysSelected objectAtIndex:indexPath.row];
        [cell.menuButton setImage:image.image forState:UIControlStateNormal];
        [cell.menuButton setImage:imageSelected.image forState:UIControlStateHighlighted];
         [cell.menuButton setImage:imageSelected.image forState:UIControlStateSelected];
        [cell.menuButton setDesitination:[functionNames objectAtIndex:indexPath.row]];
        [cell.menuTitle setText:[functionNames objectAtIndex:indexPath.row]];
//        [cell.menuSubTitle setText:[descriptions objectAtIndex:indexPath.row]];
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


#pragma mark 各个按钮监听
-(void)goToDetail:(id)sender{
    MyNavigationController* nav = (MyNavigationController*)self.navigationController;
    [nav hideTabBar:YES];
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

/*
 加载图片 */
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


@end
