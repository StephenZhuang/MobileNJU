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
#import "RDVTabBarController.h"
#import "QCSlideViewController.h"
#import "ShoppingVC.h"
#import "ScheduleVC.h"
#import "ProcedureDetailVC.h"
#import "ZsndNews.pb.h"
#define NEWSCOUNT 4
@interface MainMenuViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIPageControl *pageController;
@property (weak, nonatomic) IBOutlet UIScrollView *pageScroller;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic)UIView* headerView;
@property (nonatomic)BOOL changeHeader;
@property (weak, nonatomic) IBOutlet UIView *tableHeadView;
@property (strong,nonatomic)UIImageView* newImage;
@property (strong,nonatomic)UIImageView* touchButton;
@property (strong,nonatomic)UIImageView* cloudBack;
@property (strong,nonatomic)NSArray* focusList;

@property (strong,nonatomic)NSArray* newsImgList;
@property (strong,nonatomic)NSString* tempUrl;
@property (strong,nonatomic)NSMutableArray* newsList;
@property (strong,nonatomic)NSArray* allNews;
@property (strong,nonatomic)NSMutableArray* UIImageViewList;
@property (nonatomic)int complete;
@property (nonatomic,strong)NSMutableDictionary* stateDic;
@property (nonatomic)int prepare;
@property (nonatomic)BOOL firstOpen;
@property (nonatomic,strong)HomeCell* treeholeCell;
@end

@implementation MainMenuViewController
static NSArray* functionNames;
static NSArray* buttonImages;
static NSArray* descriptions;

#pragma mark ViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getCall:) name:@"getCall" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goToChat:) name:@"getPushInfo" object:nil];
    [self initNewScroller];
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImage:)];
    [self.pageScroller addGestureRecognizer:singleTap];
    self.changeHeader = NO;
    [self.tableView setAllowsSelection:NO];
    self.newsImgList = [ToolUtils getImgList];
    self.complete=0;
    self.prepare = 0;
    if (self.newsImgList!=nil) {
        [self prepareForNews];
    }
    self.firstOpen  = YES;
    [self.pageScroller setBackgroundColor:[UIColor whiteColor]];
    functionNames = [ToolUtils getFunctionName];
    buttonImages= [ToolUtils getButtonImage];
    descriptions = [ToolUtils getFunctionDetails];
    
}
- (void)viewDidAppear:(BOOL)animated
{
    if (self.firstOpen) {
        [self loadTableData];
        [self loadIndex];
        self.firstOpen = NO;
    }
    if ([ToolUtils shouldShowNews]) {
        UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"News" bundle:nil];
        UINavigationController* unc = (UINavigationController*)[secondStoryBoard instantiateViewControllerWithIdentifier:@"newsList"]; //test2为viewcontroller的StoryboardId
        NewsListTVC* newsList = (NewsListTVC*)[unc.childViewControllers firstObject];
        newsList.jump = YES;
        MNews_Builder* focus = [[MNews_Builder alloc]init];
        NSDictionary* pushNews = [ToolUtils shouldShowNews];
        focus.title = [pushNews objectForKey:@"title"];
        focus.source = [pushNews objectForKey:@"source"];
        focus.img = [pushNews objectForKey:@"img"];
        focus.url = [pushNews objectForKey:@"url"];
        [newsList setCurrentUrl:focus.url];
        [newsList setCurrentNew:focus.build];
//        [newsList setCurrentImg:[self.photoList objectAtIndex:self.pageController.currentPage]];
        [self presentViewController:unc animated:YES completion:^{
            [ToolUtils setShowNews:nil];
        }];
    } else if ([ToolUtils showActivity])
    {
        [self.rdv_tabBarController setSelectedIndex:2];
    } else if ([ToolUtils showRss])
    {
        [self.rdv_tabBarController setSelectedIndex:1];
    } else if ([ToolUtils showTreeHole])
    {
        [self gotoTreeHole];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.rdv_tabBarController setTabBarHidden:NO animated:YES];
}
- (void)loadIndex
{
    if (!self.offline) {
        [[ApisFactory getApiMIndex]load:self selecter:@selector(disposeMessage:) version:[NSString stringWithFormat:@"%d",2]];
    } else {
        [self loadTableData];
    }
}

- (void)disposeMessage:(Son*)son
{
    if ([son getError]==0) {
        if ([[son getMethod] isEqualToString:@"MNewsList"]) {
            self.newsList = [[NSMutableArray alloc]init];
            //获得返回类
            MNewsList_Builder *newsList = (MNewsList_Builder *)[son getBuild];
            self.allNews = newsList.newsList;
            
        } else if ([[son getMethod] isEqualToString:@"MIndexNew"]) {
            [[[ApisFactory getApiMNewsList]setPage:1 pageCount:10]load:self selecter:@selector(disposeMessage:)];
            MIndex_Builder* index = (MIndex_Builder*)[son getBuild];
            NSMutableArray* image = [[NSMutableArray alloc]init];
            NSMutableArray* names = [[NSMutableArray alloc]init];
            NSMutableArray* details = [[NSMutableArray alloc]init];
            for (MMdoule* model in index.moduleList) {
                [names addObject:model.name];
                [image addObject:model.img];
                [details addObject:model.desc];
                if ([model.desc hasSuffix:@"html"]) {
                    self.tempUrl = model.desc;
                }
            }
            if (functionNames==nil) {
                functionNames=names;
                buttonImages=image;
                descriptions=details;
                [self loadImages];
            } else {
    
                functionNames=names;
                buttonImages=image;
                descriptions=details;
                [self loadImages];
            }
            [ToolUtils setFunctionDetails:descriptions];
            [ToolUtils setFunctionNames:functionNames];
            [ToolUtils setButtonImage:buttonImages];
            self.focusList = index.focusList;
            NSMutableArray* imgList = [[NSMutableArray alloc] init];
            for (MFocus *focus in index.focusList) {
                [imgList addObject:focus.img];
            }
            [ToolUtils setImgList:imgList];
//            if (isLoad) {
//                [self loadTableData];
////                [self.tableView reloadData];
//            }
            [self loadTableData];
            [self.tableView reloadData];
            
            
            
            if (self.newsImgList.count==0) {
                self.newsImgList = imgList;
                [self prepareForNews];
            } else if (self.complete==4){
                self.newsImgList = imgList;
//                [self.photoList removeAllObjects];
                for (int i = 1; i<=NEWSCOUNT; i++) {
                    [self loadNewsCache:i];
                }

            }
        }
    } else {
        [super disposMessage:son];
    }
    
}
#warning 这里需要加上从服务器载下来的临时功能
- (void)loadTableData
{
    functionNames = [ToolUtils getFunctionName];
    buttonImages= [ToolUtils getButtonImage];
    descriptions = [ToolUtils getFunctionDetails];
    if (functionNames!=nil) {
        if (self.stateDic==nil) {
            self.stateDic = [[NSMutableDictionary alloc]init];
        }
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
            self.prepare++;
            if (self.imageArrays.count==buttonImages.count&&self.prepare==buttonImages.count*2) {
                [self.tableView reloadData];
            }
        }];
        UIImageView* imageSelected = [[UIImageView alloc]init];
        imageSelected.frame = frame;
        [imageSelected setImageWithURL:[ToolUtils getImageUrlWtihString:[imageUrls lastObject]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            self.prepare++;
            if (self.imageArrays.count==buttonImages.count&&self.prepare==buttonImages.count*2) {
                [self.tableView reloadData];
                
            }
        }];
        [self.imageArrays addObject:image];
        [self.imageArraysSelected addObject:imageSelected];
    }
//    [self.tableView reloadData];
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
    } else if ([[segue identifier]isEqualToString:@"临时功能"])
    {
        ProcedureDetailVC* nextVC = (ProcedureDetailVC*)[segue destinationViewController];
        nextVC.url = [[NSURL alloc]initWithString:[NSString stringWithFormat:@"http://s1.smartjiangsu.com:89/%@",self.tempUrl]];

    }
    if ([[segue identifier] isEqual:@"课程表"]) {
        ScheduleVC* vc = (ScheduleVC*)[segue destinationViewController];
        vc.offline = self.offline;
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
    if (indexPath.row % 2 == 0) {
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
        [cell.menuButton setDesitination:[descriptions objectAtIndex:indexPath.row]];
        [cell.menuTitle setText:[functionNames objectAtIndex:indexPath.row]];
        [cell setUserInteractionEnabled:YES];
//        [cell.menuSubTitle setText:[descriptions objectAtIndex:indexPath.row]];
        [cell.menuButton addTarget:self action:@selector(
                                                         goToDetail
                                                :) forControlEvents:UIControlEventTouchUpInside];
        if (self.unread.module2>0&&[[functionNames objectAtIndex:indexPath.row]isEqualToString:@"树洞"]) {
            [cell addUnread];
            self.treeholeCell = cell;
        } else {
            [cell.redCircle setHidden:YES];
        }
        [cell setUserInteractionEnabled:YES];

    } else {
        [cell.menuButton setImage:nil forState:UIControlStateNormal];
        [cell.menuTitle setText:@""];
        [cell.menuSubTitle setText:@""];
        [cell.redCircle setHidden:YES];
        [cell setUserInteractionEnabled:NO];
    }
    
   

   return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [((HomeCell*)cell).redCircle setHidden:YES];
    if (indexPath.row<=[buttonImages count]-1)
    {
        if (self.unread.module2>0&&[[functionNames objectAtIndex:indexPath.row]isEqualToString:@"树洞"]) {
            [(HomeCell*)cell addUnread];
        } else {
            [((HomeCell*)cell).redCircle setHidden:YES];
        }
    }
    NSString* str = [NSString stringWithFormat:@"%d",indexPath.row];
    if ([self.stateDic objectForKey:str]==nil) {
        HomeCell* homecell = (HomeCell*)cell;
        [self.stateDic setObject:@"ok" forKey:str];
        if (indexPath.row%2==0) {
            homecell.menuView.transform = CGAffineTransformMakeTranslation(-300, 0);
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                homecell.menuView.transform = CGAffineTransformMakeTranslation(0, 0);
            } completion:^(BOOL finished) {
                
            }];
        } else {
            homecell.menuView.transform = CGAffineTransformMakeTranslation(300, 0);
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                homecell.menuView.transform = CGAffineTransformMakeTranslation(0, 0);
            } completion:^(BOOL finished) {
                
            }];
        }
    }
    
    
   

}


#pragma mark 各个按钮监听
-(void)goToDetail:(id)sender{
    MenuButton* menuButton = (MenuButton*)sender;
    
    if ([ToolUtils getLoginId].length==0) {
        NSString* menu = menuButton.desitination;
        if ([menu isEqualToString:@"树洞"]|| [menu isEqualToString:@"跳蚤市场"]) {
            [self gotoLogin];
            return;
        }
    }
    if ([menuButton.desitination isEqualToString:@"树洞"]) {
        [self.rdv_tabBarController setTabBarHidden:YES animated:NO];
        
        self.unread=nil;
        [self.treeholeCell.redCircle setHidden:YES];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"TreeHole" bundle:nil];
        TreeHoleListViewController *vc = [storyboard instantiateInitialViewController];
        [self.navigationController pushViewController:vc animated:YES];
        
    } else if ([menuButton.desitination isEqualToString:@"南呱"]) {
        [self.rdv_tabBarController setTabBarHidden:YES animated:NO];

        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Nangua" bundle:nil];
        NanguaViewController *vc = [storyboard instantiateInitialViewController];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([menuButton.desitination isEqualToString:@"跳蚤市场"])
    {
        [self.rdv_tabBarController setTabBarHidden:YES animated:NO];

        [self goToShop];
    } else if ([menuButton.desitination hasSuffix:@"html"]){
        [self.rdv_tabBarController setTabBarHidden:YES animated:NO];

        [self performSegueWithIdentifier:@"临时功能"  sender:menuButton.desitination];

    }
    else {
        [self.rdv_tabBarController setTabBarHidden:YES animated:NO];
            NSLog(@"%@ destination",menuButton.desitination);
        [self performSegueWithIdentifier:menuButton.desitination  sender:nil];
    }
}


- (void) gotoLogin
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您必须登录才能使用该功能" delegate:self.rdv_tabBarController cancelButtonTitle:@"继续使用" otherButtonTitles:@"登录", nil];
//    alert.delegate = self;
    [alert show];
}





- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    if (buttonIndex==1) {
//        [self.rdv_tabBarController dismissViewControllerAnimated:YES completion:nil];
//    }
}

- (void)goToShop
{
    
    QCSlideViewController *slideSwitchVC = [[QCSlideViewController alloc] init];
    
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:slideSwitchVC];
    [self.navigationController pushViewController:slideSwitchVC animated:YES];
    
}
#pragma mark 新闻区

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
    UIImageView *imageView = [self.UIImageViewList objectAtIndex:site-1];;
    if (self.focusList.count>=site) {
        MFocus* focus = [self.focusList objectAtIndex:site-1];
        [imageView setImageWithURL:[ToolUtils getImageUrlWtihString:focus.img width:640 height:400]
                        placeholderImage:[UIImage imageNamed:@"640乘400"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            if (image!=nil) {
                [self.photoList setObject:image atIndexedSubscript:site-1];
            }
        }];
    } else {
        [imageView setImageWithURL:[ToolUtils getImageUrlWtihString:[self.newsImgList objectAtIndex:site-1]width:640 height:400]   placeholderImage:[UIImage imageNamed:@"640乘400"]  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            self.complete++;
            if (image!=nil) {
                [self.photoList setObject:image atIndexedSubscript:site-1];
            }
        }];
    }
}


//加载新的cache (在此之前需要访问服务器 看是否需要下载新的图片
- (void)loadNewsCache:(NSInteger)site
{
    [self reloadNews:site];
}


//加载图片至scrollerView
- (void)loadNews
{
    NSInteger pageCount = NEWSCOUNT;
    self.pageController.currentPage = 0;
    self.pageController.numberOfPages = pageCount;
    CGSize pageScrollViewSize = self.pageScroller.frame.size;
    self.pageScroller.contentSize = CGSizeMake(pageScrollViewSize.width * self.photoList.count, pageScrollViewSize.height);
    self.UIImageViewList = [[NSMutableArray alloc]init];
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
        [self.UIImageViewList addObject:pageView];
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
        if (focus==nil) {
            [_newImage setImageWithURL:[ToolUtils getImageUrlWtihString:[self.newsImgList objectAtIndex:page]   width:640 height:400]];
        } else {
            [_newImage setImageWithURL:[ToolUtils getImageUrlWtihString:focus.img width:640 height:400]];
        }
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
    for (int i = 0; i<NEWSCOUNT; i++) {
        [self.photoList addObject:[self getEmptyUIImage]];
    }
    [self loadNews];
    for (int i = 1; i<=NEWSCOUNT; i++) {
        [self loadNewsCache:i];
    }
    [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(timerChangePic) userInfo:nil repeats:YES];

}

-(void) onClickImage:(id) sender{
    if (self.allNews==nil) {
        if ([ToolUtils isLogin]){
            [ToolUtils showMessage:@"新闻列表未获取，请稍等片刻"];
        } else {
            [ToolUtils showMessage:@"网络未连接，请检查网络情况"];

        }
        return;
    }
    [self.newsList removeAllObjects];
    for (MFocus *focus in self.focusList) {
        for (MNews* news in self.allNews) {
            if ([news.url isEqualToString:focus.id]) {
                [self.newsList addObject:news];
                break;
            }
        }
    }
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"News" bundle:nil];
    UINavigationController* unc = (UINavigationController*)[secondStoryBoard instantiateViewControllerWithIdentifier:@"newsList"]; //test2为viewcontroller的StoryboardId
    NewsListTVC* newsList = (NewsListTVC*)[unc.childViewControllers firstObject];
    newsList.jump = YES;
    if (self.newsList!=nil) {
        MNews* focus = [self.newsList objectAtIndex:self.pageController.currentPage];
        MNews_Builder* news_builders = [[MNews_Builder alloc]init];
        news_builders = [news_builders mergeFrom:focus];
        [newsList setCurrentNew:news_builders];
        [newsList setCurrentUrl:focus.url];
        [newsList setCurrentImg:[self.photoList objectAtIndex:self.pageController.currentPage]];
    }
    [self presentViewController:unc animated:YES completion:^{
        
    }];
}

#pragma - mark callview
//- (void)getCall:(NSNotification *)notification
//{
//    if (![[self.navigationController.viewControllers lastObject] isKindOfClass:NSClassFromString(@"ChatViewController")]) {
//        [self showCallView:notification.userInfo];
//    }
//}

//- (void)cancelCall
//{
//    [[ApisFactory getApiMChatCallBack] load:self selecter:@selector(disposMessage:) id:self.callView.targetid type:0];
//    [self dismissCallView];
//}
//
//- (void)confirmCall
//{
//    [[ApisFactory getApiMChatCallBack] load:self selecter:@selector(disposMessage:) id:self.callView.targetid type:1];
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Nangua" bundle:nil];
//    ChatViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"ChatViewController"];
//    vc.targetid = self.callView.targetid;
//    [self.navigationController pushViewController:vc animated:YES];
//    [self dismissCallView];
//}

//- (void)showCallView:(NSDictionary *)userInfo
//{
//    [self addMask];
//    if (!self.callView) {
//        self.callView = [[[NSBundle mainBundle] loadNibNamed:@"CallView" owner:self options:nil] firstObject];
//    }
//    self.callView.transform = CGAffineTransformIdentity;
//    [self.callView setTargetid:[userInfo objectForKey:@"id"]];
//    [self.callView.cancelButton addTarget:self action:@selector(cancelCall) forControlEvents:UIControlEventTouchUpInside];
//    [self.callView.confirmButton addTarget:self action:@selector(confirmCall) forControlEvents:UIControlEventTouchUpInside];
//
//    self.callView.center = [UIApplication sharedApplication].keyWindow.center;
//    [self show];
//    [[UIApplication sharedApplication].keyWindow addSubview:self.callView];
//}
//
//- (void)dismissCallView
//{
//    [self removeMask];
//    [self hide];
//}

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

//- (void)show
//{
////    self.editView.center = CGPointMake(self.view.center.x, 150);
//    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
//    popAnimation.duration = 0.4;
//    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
//                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
//                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
//                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
//    popAnimation.keyTimes = @[@0.2f, @0.5f, @0.75f, @1.0f];
//    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
//                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
//                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
//    [self.callView.layer addAnimation:popAnimation forKey:nil];
//}
//
//- (void)hide
//{
//    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
//        self.callView.transform = CGAffineTransformMakeScale(1.1, 1.1);
//    } completion:^(BOOL finished) {
//        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
//            self.callView.transform = CGAffineTransformMakeScale(0, 0);
//        } completion:^(BOOL finished) {
//            [self.callView removeFromSuperview];
//        }];
//    }];
//}
//
//
- (void)goToChat:(NSNotification *)notification
{
    NSString *type = notification.object;
    if (type.integerValue == 1) {
        UIViewController *vc = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        RDVTabBarController *tabbar = (RDVTabBarController *)vc.presentedViewController;
        UINavigationController *nav = (UINavigationController *)[tabbar selectedViewController];
        if ([nav isEqual:self.navigationController]) {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Nangua" bundle:nil];
            ChatViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"ChatViewController"];
            vc.targetid = [notification.userInfo objectForKey:@"target"];
            vc.topicid = [notification.userInfo objectForKey:@"topicid"];
            [self.navigationController pushViewController:vc animated:YES];
            //        [self dismissCallView];
        }
    }
    else if (type.integerValue ==2 ){
        [super goToChat:notification];
    } else if (type.integerValue ==3) {
        [self.rdv_tabBarController setSelectedIndex:1];
    } else if (type.integerValue ==4) {
        [self.rdv_tabBarController setSelectedIndex:2];
    } else if (type.integerValue ==5) {
        [self gotoTreeHole];
    }
}

- (void) gotoTreeHole
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"TreeHole" bundle:nil];
    TreeHoleListViewController *vc = [storyboard instantiateInitialViewController];
    [self.rdv_tabBarController setTabBarHidden:YES];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
