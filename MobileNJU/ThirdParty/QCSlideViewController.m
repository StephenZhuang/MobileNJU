//
//  QCSlideViewController.m
//  QCSliderTableView
//
//  Created by “ 邵鹏 on 14-4-16.
//  Copyright (c) 2014年 Scasy. All rights reserved.
//

#import "QCSlideViewController.h"
#import "AddShopVC.h"
#import "ApiMMarketType.h"
#import "ZsndMarket.pb.h"
#import "ShoppingVC.h"
#import "RDVTabBarController.h"
#import "VerifyVC.h"

@interface QCSlideViewController ()
@property (nonatomic,strong)NSArray* titleArray;
@property (nonatomic,strong)NSArray* typeList;

@end

@implementation QCSlideViewController
@synthesize viewControllers;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [self.rdv_tabBarController setTabBarHidden:YES];
    int location = self.slideSwitchView.rootScrollView.contentOffset.x/320;
    ShoppingVC* vc = [self.viewControllers objectAtIndex:location];
    [vc startRefresh];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.title = @"跳蚤";
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 20)];
    
    [button setImage:[UIImage imageNamed:@"10-1跳蚤市场-添加"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(addNew) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    self.slideSwitchView.tabItemNormalColor = [QCSlideSwitchView colorFromHexRGB:@"868686"];
    self.slideSwitchView.tabItemSelectedColor = [QCSlideSwitchView colorFromHexRGB:@"bb0b15"];
    self.slideSwitchView.shadowImage = [[UIImage imageNamed:@"red_line_and_shadow.png"]
                                        stretchableImageWithLeftCapWidth:59.0f topCapHeight:0.0f];
   
    ApiMMarketType* api = [[ApiMMarketType alloc]init];
    [self waiting:@"正在加载中"];
    [api load:self selecter:@selector(disposMessage:)];
    
    
}
- (void)loadType
{
    NSMutableArray *controllerArray = [[NSMutableArray alloc]init];
    
    for (NSString* title in self.titleArray)
    {
        UIStoryboard *firstStoryBoard = [UIStoryboard storyboardWithName:@"shop" bundle:nil];
        ShoppingVC* vc = (ShoppingVC*)[firstStoryBoard instantiateViewControllerWithIdentifier:@"shop"]; //test2为viewcontroller的StoryboardId
        [vc setMyDelegate:self];
        [controllerArray addObject:vc];
        vc.title = title;
    }
    self.viewControllers = controllerArray;
    [self.slideSwitchView buildUI];
    
}

- (void)disposMessage:(Son *)son
{
    [self.loginIndicator removeFromSuperview];
    if ([son getError]==0) {
        if ([[son getMethod] isEqualToString:@"MMarketType"])  {
            NSMutableArray* types = [[NSMutableArray alloc]init];
            MMarketTypeList_Builder* typeList = (MMarketTypeList_Builder*)[son getBuild];
            self.typeList = typeList.marketList;
            for (MMarketType* type in typeList.marketList) {
                [types addObject:type.title];
            }
            self.titleArray = types;
            [self loadType];
        }
    }else {
        [super disposMessage:son];
    }

}
- (void)addNew
{
    if ([ToolUtils getIsVeryfy]==0) {
        [ToolUtils showMessage:@"请先验证身份"];
        UIStoryboard *firstStoryBoard = [UIStoryboard storyboardWithName:@"Self" bundle:nil];
        VerifyVC* vc = (VerifyVC*)[firstStoryBoard instantiateViewControllerWithIdentifier:@"verify"]; //test2为viewcontroller的StoryboardId
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:vc action:@selector(cancelVerify)];
        [item setTintColor:[UIColor whiteColor]];
        vc.navigationItem.rightBarButtonItem = item;
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        [self presentViewController:nav animated:YES completion:nil];
    } else {
        UIStoryboard *firstStoryBoard = [UIStoryboard storyboardWithName:@"shop" bundle:nil];
        AddShopVC* vc = (AddShopVC*)[firstStoryBoard instantiateViewControllerWithIdentifier:@"add"];
        vc.typeList = self.typeList;
        vc.lastVC = self;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

#pragma mark - 滑动tab视图代理方法


- (NSUInteger)numberOfTab:(QCSlideSwitchView *)view
{
    // you can set the best you can do it ;
    return self.titleArray.count;
}

- (UIViewController *)slideSwitchView:(QCSlideSwitchView *)view viewOfTab:(NSUInteger)number
{
    return [self.viewControllers objectAtIndex:number];
}


- (void)slideSwitchView:(QCSlideSwitchView *)view didselectTab:(NSUInteger)number
{
    ShoppingVC *vc = [self.viewControllers objectAtIndex:number];
    MMarketType* type = [self.typeList objectAtIndex:number];
    [vc setType:type.id];
    [vc startRefresh];
}

#pragma mark - 内存报警

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -shoppingVCDelegate
- (void)moveToDetail:(UIViewController *)vc
{
    
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier]isEqualToString:@"add"]) {
        AddShopVC* add = (AddShopVC*)[segue destinationViewController];
    }
}
- (void)showView:(UIViewController *)vc
{
    [self presentViewController:vc animated:YES completion:nil];
}
@end
