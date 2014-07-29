//
//  QCSlideViewController.m
//  QCSliderTableView
//
//  Created by “ 邵鹏 on 14-4-16.
//  Copyright (c) 2014年 Scasy. All rights reserved.
//

#import "QCSlideViewController.h"

@interface QCSlideViewController ()

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
    
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Add"
                                                                    style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    self.slideSwitchView.tabItemNormalColor = [QCSlideSwitchView colorFromHexRGB:@"868686"];
    self.slideSwitchView.tabItemSelectedColor = [QCSlideSwitchView colorFromHexRGB:@"bb0b15"];
    self.slideSwitchView.shadowImage = [[UIImage imageNamed:@"red_line_and_shadow.png"]
                                        stretchableImageWithLeftCapWidth:59.0f topCapHeight:0.0f];
   
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

    
    
//    UIButton *rightSideButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [rightSideButton setImage:[UIImage imageNamed:@"icon_rightarrow.png"] forState:UIControlStateNormal];
//    [rightSideButton setImage:[UIImage imageNamed:@"icon_rightarrow.png"]  forState:UIControlStateHighlighted];
//    rightSideButton.frame = CGRectMake(0, 0, 20.0f, 44.0f);
//    rightSideButton.userInteractionEnabled = NO;
//    self.slideSwitchView.rigthSideButton = rightSideButton;
    
    [self.slideSwitchView buildUI];
}

#pragma mark - 滑动tab视图代理方法


- (NSUInteger)numberOfTab:(QCSlideSwitchView *)view
{
    // you can set the best you can do it ;
    return 6;
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
