//
//  CustomTabBar.m
//  CustomTabBar
//
//  Created by ChanBin on 14-3-7.
//  Copyright (c) 2014年 ChanBin. All rights reserved.
//

#import "CustomTabBar.h"
#import "MainMenuViewController.h"
#import "SelfInfoVC.h"
#import "SubscribeVC.h"
#import "ActivityCell.h"
#import "ActivityVC.h"
#import "myNavigationControllerDelegate.h"
#import "MyNavigationController.h"
@interface CustomTabBar ()<myNavigationControllerDelegate>

@end

@implementation CustomTabBar

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _cbCurView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height)];
        _cbTarBar = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-49, 320, 49)];
        _cbViewControllers = [[NSArray alloc] init];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.view addSubview:_cbCurView];
    [self.view addSubview:_cbTarBar];
    
    
    UIStoryboard *firstStoryBoard = [UIStoryboard storyboardWithName:@"Home" bundle:nil];
    MainMenuViewController* mainMenuVC = (MainMenuViewController*)[firstStoryBoard instantiateViewControllerWithIdentifier:@"home"]; //test2为viewcontroller的StoryboardId
    MyNavigationController *nav1 = [[MyNavigationController alloc] initWithRootViewController:mainMenuVC];
    [nav1 setMyDelegate:self];
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"Self" bundle:nil];
    SelfInfoVC* selfVC = (SelfInfoVC*)[secondStoryBoard instantiateViewControllerWithIdentifier:@"self"]; //test2为viewcontroller的StoryboardId
    MyNavigationController *nav4 = [[MyNavigationController alloc] initWithRootViewController:selfVC];
    [nav4 setMyDelegate:self];
    
    UIStoryboard *thirdStoryBoard = [UIStoryboard storyboardWithName:@"News" bundle:nil];
    SubscribeVC* subVC = (SubscribeVC*)[thirdStoryBoard instantiateViewControllerWithIdentifier:@"subscribe"]; //test2为viewcontroller的StoryboardId
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:subVC];
    
    
    
    ActivityVC* activityVC = (ActivityVC*)[thirdStoryBoard instantiateViewControllerWithIdentifier:@"activity"]; //test2为viewcontroller的StoryboardId
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:activityVC];
    
    
    
    self.cbViewControllers = @[nav1,nav2,nav3,nav4];
     [_cbCurView addSubview:nav1.view];
    //设置TabBar的button按钮
    
    
    NSArray* buttonImages = @[@"首页",@"订阅",@"活动",@"个人"];
    NSArray* buttonImagesSelected=@[@"首页选中",@"订阅选中",@"活动选中",@"个人选中"];

    for (int i = 0; i < _cbViewControllers.count; i++) {
        UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
        b.frame= CGRectMake(320/_cbViewControllers.count*i, 0, 320/_cbViewControllers.count, 49);
        b.tag = 100 + i;
        [b setImage:[UIImage imageNamed:[buttonImages objectAtIndex:i]] forState:UIControlStateNormal];
        [b setImage:[UIImage imageNamed:[buttonImagesSelected objectAtIndex:i]] forState:UIControlStateHighlighted];
        [b setImage:[UIImage imageNamed:[buttonImagesSelected objectAtIndex:i]] forState:UIControlStateSelected];
        if (0 == i) {
            [b setSelected:YES];
        }
        [b setBackgroundColor:[UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1]];
        
        [b addTarget:self action:@selector(changeNav:) forControlEvents:UIControlEventTouchUpInside];
        [_cbTarBar addSubview:b];
    }
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 1)];
    [line setBackgroundColor:[UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1]];
    [_cbTarBar addSubview:line];
}



int preTag = 100;
- (void)changeNav:(UIButton *)b
{
    UIButton * preBtn = (UIButton *)[self.view viewWithTag:preTag];
//    [preBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [b setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [preBtn setSelected:NO];
    [b setSelected:YES];
    preTag = b.tag;
    UINavigationController *nav = self.cbViewControllers[b.tag-100];
    for (UIView *obj in _cbCurView.subviews)
    {
        [obj removeFromSuperview];
    }
    [_cbCurView addSubview:nav.view];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)logOut
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)hideTabBar:(BOOL)hide
{
    [_cbTarBar setHidden:hide];
}

@end
