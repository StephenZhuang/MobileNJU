//
//  QCSlideViewController.m
//  QCSliderTableView
//
//  Created by “ 邵鹏 on 14-4-16.
//  Copyright (c) 2014年 Scasy. All rights reserved.
//

#import "QCSlideViewController.h"
#import "AddShopVC.h"
#import "ZsndMarket.pb.h"

@interface QCSlideViewController ()
@property (nonatomic,strong)NSArray* titleArray;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.title = @"跳蚤";
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    
    [button setImage:[UIImage imageNamed:@"10-1跳蚤市场-添加"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(addNew) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    
    self.slideSwitchView.tabItemNormalColor = [QCSlideSwitchView colorFromHexRGB:@"868686"];
    self.slideSwitchView.tabItemSelectedColor = [QCSlideSwitchView colorFromHexRGB:@"bb0b15"];
    self.slideSwitchView.shadowImage = [[UIImage imageNamed:@"red_line_and_shadow.png"]
                                        stretchableImageWithLeftCapWidth:59.0f topCapHeight:0.0f];
   
    
    
    
    
    [[ApisFactory getApiMMarketType]load:self selecter:@selector(disposMessage:)];
    
    
    NSArray *titleArray = [NSArray arrayWithObjects:@"热门",@"电子产品",@"生活用品",@"书籍",@"衣服",nil];
    
    NSMutableArray *controllerArray = [[NSMutableArray alloc]init];
    
    for (NSString* title in titleArray)
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
    if ([son getError]==0) {
        if ([[son getMethod] isEqualToString:@"MMarketType"])  {
            NSMutableArray* types = [[NSMutableArray alloc]init];
            MMarketTypeList_Builder* typeList = (MMarketTypeList_Builder*)[son getBuild];
            for (MMarketType* type in typeList.marketList) {
                NSLog(@"%@",type.id);
            }
        }
    }
}
- (void)addNew
{
    UIStoryboard *firstStoryBoard = [UIStoryboard storyboardWithName:@"shop" bundle:nil];
    AddShopVC* vc = (AddShopVC*)[firstStoryBoard instantiateViewControllerWithIdentifier:@"add"];
    [self.navigationController pushViewController:vc animated:YES];
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
}

#pragma mark - 内存报警

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -shoppingVCDelegate
- (void)moveToDetail:(ShoppingDetailVC *)vc
{
    [self.navigationController pushViewController:vc animated:YES];
}
@end
