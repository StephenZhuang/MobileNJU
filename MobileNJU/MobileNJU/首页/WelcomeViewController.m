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
#import "ZsndSystem.pb.h"

@interface WelcomeViewController ()<UITextFieldDelegate,UINavigationBarDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *loginView;
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UIPageControl *loadingIndicate;

@end

@implementation WelcomeViewController
#pragma mark -UINavigationDelegate,UINavigationBarDelegate
/*
 设置rootViewController的NavigationBar 不可见
 */
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ( [viewController class] ==  [self class]
        || [viewController class] == [MainMenuViewController class]
        || [viewController class]==[SelfInfoVC class]) {
        [navigationController setNavigationBarHidden:YES animated:animated];
    } else if ( [navigationController isNavigationBarHidden] ) {
        [navigationController setNavigationBarHidden:NO animated:animated];
    }
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
    [textField resignFirstResponder];
    return YES;
}

/*Show Alert*/
- (void) showAlert:(NSString*)msg
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"登录" message:msg delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil] ;
    [alert show];
}
/*设置代理*/
- (void) setDelegate
{
    self.navigationController.delegate = self;
    self.passwordTextField.delegate = self;
    self.usernameTextField.delegate = self;
}

#pragma mark segue
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([identifier isEqualToString:@"login in"]){
        return [self login];
    }
    return YES;
}

- (BOOL)login
{
    
    return YES;
}

#pragma mark UIViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
  //  [self setNavigationBarStyle];
    [self setDelegate];
    //中间缺少加载过程
    [self showLoginView];
    
    
    [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(timeChangeIndicate) userInfo:nil repeats:YES];
    // Do any additional setup after loading the view.
    
    
    //not need
    [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(hideLoad) userInfo:nil repeats:NO];
    
    //api调用方式 可以点进去查看，也可按option + 左键查看 ， 回调函数统一写作disposMessage ， 如下
    [[ApisFactory getApiMGetWelcomePage] load:self selecter:@selector(disposMessage:)];
}

- (void)disposMessage:(Son *)son
{
    //error = 0 表示接口调用成功
    if ([son getError] == 0) {
        //判断接口名
        if ([[son getMethod] isEqualToString:@"MGetWelcomePage"]) {
            //获得返回类
            MRet_Builder *ret = (MRet_Builder *)[son getBuild];
            NSLog(@"=======%@",ret.msg);
        }
    }
}

//not need
- (void)hideLoad{
    self.loadingIndicate.hidden = YES;
}
- (void)timeChangeIndicate{
    if (self.loadingIndicate.currentPage == self.loadingIndicate.numberOfPages-1)
    {
        [self.loadingIndicate setCurrentPage:0];
    }
    else
    {
        [self.loadingIndicate setCurrentPage:self.loadingIndicate.currentPage+1];
    }

}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//加载完毕，显示登录界面。
- (void)showLoginView
{
    [self.loginView removeFromSuperview];
    [self.logoImage removeFromSuperview];
    [self.view addSubview:self.loginView];
    [self.view addSubview:self.logoImage];
    
    
    
    [UIView animateWithDuration:1.0 delay:5.0 options:UIViewAnimationOptionTransitionNone animations:^{
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
