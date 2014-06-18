//
//  WelcomeViewController.m
//  ZSDX2.0
//
//  Created by luck-mac on 14-5-7.
//  Copyright (c) 2014年 zsdx. All rights reserved.
//

#import "WelcomeViewController.h"
#import "MainMenuViewController.h"
#import "SelfInfoVC.h"
#import "ExerciseVC.h"
#import "EcardVC.h"
#import "MyLibraryVC.h"
#import "ZsndSystem.pb.h"
#import "UtilMethods.h"
#import "ExerciseVC.h"
#import "ZsndUser.pb.h"

@interface WelcomeViewController ()<UITextFieldDelegate,UINavigationBarDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *loginView;
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UIImageView *indicateView;
@property (nonatomic)NSInteger page;
@property(nonatomic)BOOL firstOpen;
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
    [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(timeChangeIndicate) userInfo:nil repeats:YES];
//  [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(hideLoad) userInfo:nil repeats:NO];
    
    //api调用方式 可以点进去查看，也可按option + 左键查看 ， 回调函数统一写作disposMessage ， 如下
    [[ApisFactory getApiMGetWelcomePage] load:self selecter:@selector(disposMessage:)];
    [self.usernameTextField setText:[UtilMethods getLoginId]==nil?@"":[UtilMethods getLoginId]];
    [self.passwordTextField setText:[UtilMethods getPassword]==nil?@"":[UtilMethods getPassword]];
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
//    [self performSegueWithIdentifier:@"main" sender:nil];
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
            if ([UtilMethods isLogin]) {
                [self login:nil];
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
            
#warning 这里写的很有问题，UtilMethods不需要的，然后loginid要存user.id的，这些东西统一存到toolutils里面， 注意字段不要冲突
            [UtilMethods setIsLogin:YES];
            [UtilMethods setLoginId:self.usernameTextField.text];
            [UtilMethods setPassword:self.passwordTextField.text];
            [self performSegueWithIdentifier:@"main" sender:nil];
        }
    } else {
        [self showLoginView];
    }
}


#pragma mark -UINavigationDelegate,UINavigationBarDelegate
/*
 设置rootViewController的NavigationBar 不可见
 */
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ( [viewController class] ==  [self class]
        || [viewController class] == [MainMenuViewController class]
        || [viewController class]==[SelfInfoVC class]
        || [viewController class]== [ExerciseVC class]
        || [viewController class]==[EcardVC class]
        || [viewController class]==[MyLibraryVC class]
        || [viewController class]==[ExerciseVC class]
        ) {
        [navigationController setNavigationBarHidden:YES animated:animated];
    } else if ( [navigationController isNavigationBarHidden] ) {
        [navigationController setNavigationBarHidden:NO animated:animated];
    }
}
- (IBAction)resignAllResponders:(id)sender {
    [self.usernameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
        self.loginView.center = CGPointMake(self.loginView.center.x, 250);
        self.logoImage.center = CGPointMake(self.logoImage.center.x, 200);
        
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
        self.loginView.center = CGPointMake(self.loginView.center.x, 150);
        self.logoImage.center = CGPointMake(self.logoImage.center.x, 100);
        
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

//#pragma mark segue
//- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
//{
//
//}





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
    [self.view addSubview:self.loginView];
    [self.view addSubview:self.logoImage];

    
    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
        self.loginView.center = CGPointMake(self.loginView.center.x, 250);
        self.logoImage.center = CGPointMake(self.logoImage.center.x, 200);

    } completion:^(BOOL finished) {
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
