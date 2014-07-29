//
//  WelcomeViewController.m
//  ZSDX2.0
//
//  Created by luck-mac on 14-5-7.
//  Copyright (c) 2014年 zsdx. All rights reserved.
//

#import "WelcomeViewController.h"

#import "ToolUtils.h"
#import "ZsndUser.pb.h"
#import "ZsndSystem.pb.h"
#import "CustomTabBar.h"
#import "MainMenuViewController.h"
#import "SelfInfoVC.h"
#import "SubscribeVC.h"
#import "ActivityCell.h"
#import "ActivityVC.h"
#import "RDVTabBarController.h"
#import "RDVTabBarItem.h"
@interface WelcomeViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *loginView;
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UIImageView *indicateView;
@property (nonatomic)NSInteger page;
@property(nonatomic)BOOL firstOpen;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@end

@implementation WelcomeViewController


#pragma mark UIViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.firstOpen = YES;
    //  [self setNavigationBarStyle];
    [self setDelegate];
    //中间缺少加载过程
    self.page = 1;
    //加载动画
    [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(timeChangeIndicate) userInfo:nil repeats:YES];

    
    
    //api调用方式 可以点进去查看，也可按option + 左键查看 ， 回调函数统一写作disposMessage ， 如下
    [[ApisFactory getApiMGetWelcomePage] load:self selecter:@selector(disposMessage:)];
    [self.usernameTextField setText:[ToolUtils getAccount]==nil?@"":[ToolUtils getAccount]];
    [self.passwordTextField setText:[ToolUtils getPassword]==nil?@"":[ToolUtils getPassword]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login:(UIButton *)sender {
    
    if ([self.usernameTextField.text isEqualToString:@""]) {
        [ProgressHUD showError:@"请输入您的手机号"];
        return;
    }
    if ([self.passwordTextField.text isEqualToString:@""]) {
        [ProgressHUD showError:@"密码不能为空"];
        return;
    }
    [self resignAllResponders:nil];
    [self waiting:@"登陆中"];
    #warning 注意加密
    [[ApisFactory getApiMLogin]load:self selecter:@selector(disposMessage:) phone:self.usernameTextField.text password:self.passwordTextField.text pushid:[[NSUserDefaults standardUserDefaults] objectForKey:@"pushId"] device:@"ios"];
}

- (void)viewWillAppear:(BOOL)animated
{
    if (!self.firstOpen) {
        NSLog(@"调用showLoginView");
        [self showLoginView];
    } else {
        NSLog(@"firstOpen设为YES");
        self.firstOpen = NO;
    }
}
#pragma - mark api回调
- (void)disposMessage:(Son *)son
{
    [self.loginIndicator removeFromSuperview];
    self.OK=YES;
    //error = 0 表示接口调用成功
    if ([son getError] == 0) {
        //判断接口名
        if ([[son getMethod] isEqualToString:@"MGetWelcomePage"]) {
            //获得返回类
            MRet_Builder *ret = (MRet_Builder *)[son getBuild];
            NSLog(@"=======%@",ret.msg);
            if ([ToolUtils isLogin]) {
//                CustomTabBar *root = [[CustomTabBar alloc] init];
//                [self presentViewController:root animated:YES completion:^{
//                    
//                }];
                [self loadMain];

            } else {
                [self showLoginView];
            }
        } else if ([[son getMethod] isEqualToString:@"MLogin"])
        {
            MUser_Builder *user = (MUser_Builder *)[son getBuild];
            NSLog(@"account%@  nickname%@ verify  %@ ",user.account,user.nickname,user.verify);
            [ToolUtils setVerify:user.verify];
            [ToolUtils setLoginId:user.id];
            [ToolUtils setHeadImg:user.headImg];
            NSArray *array=[[NSArray alloc]initWithObjects:[NSString stringWithFormat:@"appid=%@",[[Frame INITCONFIG] getAppid]],[NSString stringWithFormat:@"deviceid=%@",[ToolUtils getDeviceid]],[NSString stringWithFormat:@"verify=%@",[ToolUtils getVerify]],[NSString stringWithFormat:@"userid=%@",[ToolUtils getLoginId]],nil];
            [Frame setAutoAddParams:array];
    
            [ToolUtils setIsLogin:YES];
            [ToolUtils setAccount:self.usernameTextField.text];
            [ToolUtils setPassword:self.passwordTextField.text];
//            [self performSegueWithIdentifier:@"main" sender:nil];
            
//            CustomTabBar *root = [[CustomTabBar alloc] init];
//            [self presentViewController:root animated:YES completion:^{
//            
//            }];
            [self loadMain];
        }
    } else {
        [self showLoginView];
    }
}
- (void)loadMain

{
    UIStoryboard *firstStoryBoard = [UIStoryboard storyboardWithName:@"Home" bundle:nil];
    MainMenuViewController* mainMenuVC = (MainMenuViewController*)[firstStoryBoard instantiateViewControllerWithIdentifier:@"home"]; //test2为viewcontroller的StoryboardId
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:mainMenuVC];
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"Self" bundle:nil];
    SelfInfoVC* selfVC = (SelfInfoVC*)[secondStoryBoard instantiateViewControllerWithIdentifier:@"self"]; //test2为viewcontroller的StoryboardId
    UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:selfVC];
    
    UIStoryboard *thirdStoryBoard = [UIStoryboard storyboardWithName:@"News" bundle:nil];
    SubscribeVC* subVC = (SubscribeVC*)[thirdStoryBoard instantiateViewControllerWithIdentifier:@"subscribe"]; //test2为viewcontroller的StoryboardId
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:subVC];
    
    
    
    ActivityVC* activityVC = (ActivityVC*)[thirdStoryBoard instantiateViewControllerWithIdentifier:@"activity"]; //test2为viewcontroller的StoryboardId
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:activityVC];
    RDVTabBarController *tabBarController = [[RDVTabBarController alloc] init];
    [tabBarController setViewControllers:@[nav1, nav2,
                                           nav3,nav4]];
    [self customizeTabBarForController:tabBarController];
    [self presentViewController:tabBarController animated:YES completion:nil];
    
}


- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController {
//    NSArray *tabBarItemImages = @[@"first", @"second", @"third"];
    
    NSArray* buttonImages = @[@"首页",@"订阅",@"活动",@"个人"];
    NSArray* buttonImagesSelected=@[@"首页选中",@"订阅选中",@"活动选中",@"个人选中"];
    

    NSInteger index = 0;
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        
        UIImage *selectedimage = [UIImage imageNamed:[buttonImagesSelected objectAtIndex:index]];
        UIImage *unselectedimage = [UIImage imageNamed:[buttonImages objectAtIndex:index]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        [item setBackgroundColor:[UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1]];
       
        index++;
        
    }
}



- (IBAction)resignAllResponders:(id)sender {
    [self.usernameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
        CGRect loginViewFrame = CGRectMake(self.loginView.frame.origin.x, 146,self.loginView.frame.size.width, self.loginView.frame.size.height);
        self.loginView.frame = loginViewFrame;
        
        
        CGRect loginLogoFrame = CGRectMake(self.logoImage.frame.origin.x, -74,self.logoImage.frame.size.width, self.logoImage.frame.size.height);
        self.logoImage.frame = loginLogoFrame;
        
        
    } completion:^(BOOL finished) {
    }];
}

/*
 设置NavigationBar风格
-(void) setNavigationBarStyle
{
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigationBar_background.png"] forBarMetrics:UIBarMetricsDefault];
 } */




#pragma mark -UITextFieldDelegate
/*Return返回*/
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self resignAllResponders:nil];
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
   
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
        CGRect loginViewFrame = CGRectMake(self.loginView.frame.origin.x, 0,self.loginView.frame.size.width, self.loginView.frame.size.height);
        self.loginView.frame = loginViewFrame;
        
        
        CGRect loginLogoFrame = CGRectMake(self.logoImage.frame.origin.x, -228,self.logoImage.frame.size.width, self.logoImage.frame.size.height);
        self.logoImage.frame = loginLogoFrame;
        
        
    } completion:^(BOOL finished) {
    }];

    return YES;
}

/*设置代理*/
- (void) setDelegate
{
    self.navigationController.delegate = self;
    self.passwordTextField.delegate = self;
    self.usernameTextField.delegate = self;
}



- (void)hideLoad{
    [self.indicateView setHidden:YES];
}


- (void)timeChangeIndicate{
    self.page = (self.page)%6+1;
    
    NSString* imageUrl = [NSString stringWithFormat:@"加载点%d",self.page];
    [self.indicateView setImage:[UIImage imageNamed:imageUrl]];
}



//加载完毕，显示登录界面。
- (void)showLoginView
{
    
    [self hideLoad];
    [self.loginView removeFromSuperview];
    [self.logoImage removeFromSuperview];
    [self.logoImage setImage:[UIImage imageNamed:@"欢迎2"]];
    [self.view addSubview:self.logoImage];
    [self.view addSubview:self.loginView];

    
    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
        CGRect loginViewFrame = CGRectMake(self.loginView.frame.origin.x, 146,self.loginView.frame.size.width, self.loginView.frame.size.height);
        self.loginView.frame = loginViewFrame;
       
        
        CGRect loginLogoFrame = CGRectMake(self.logoImage.frame.origin.x, -74,self.logoImage.frame.size.width, self.logoImage.frame.size.height);
        self.logoImage.frame = loginLogoFrame;
        
        
    } completion:^(BOOL finished) {
        [self.loginButton setHidden:NO];
    }];
}


@end
