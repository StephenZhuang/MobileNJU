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
#import "RegisterVC.h"
#import "ZsndIndex.pb.h"
#import "loginDelegate.h"
#import <Frontia/Frontia.h>

@interface WelcomeViewController ()<UITextFieldDelegate,RDVTabBarControllerDelegate,loginDelegate>
@property (weak, nonatomic) IBOutlet UIView *loginView;
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UIImageView *indicateView;
@property (weak, nonatomic) IBOutlet UIButton *registBt;
@property (nonatomic)NSInteger page;
@property(nonatomic)BOOL firstOpen;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *forgetBt;
@property (nonatomic)NSInteger time;
@property(nonatomic,strong)MUnread_Builder* unread;
@property (strong,nonatomic)NSMutableArray* imageArrays;
@property (strong,nonatomic)NSMutableArray* imageArraysSelected;
@property (nonatomic)int complete;
@property (nonatomic)int jumpState;
@property (nonatomic,strong)RDVTabBarController* tabBarController;
@end

@implementation WelcomeViewController
static NSArray* buttonImages;

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
    self.time = 1;
    self.offline = NO;
    //api调用方式 可以点进去查看，也可按option + 左键查看 ， 回调函数统一写作disposMessage ， 如下
    [[ApisFactory getApiMGetWelcomePage] load:self selecter:@selector(disposMessage:)];
    [self.usernameTextField setText:[ToolUtils getAccount]==nil?@"":[ToolUtils getAccount]];
    [self.passwordTextField setText:[ToolUtils getPassword]==nil?@"":[ToolUtils getPassword]];
    [self.view setUserInteractionEnabled:NO];
    self.complete = 0;
    self.jumpState = 0 ; 
}

- (void)viewDidAppear:(BOOL)animated
{
    
    self.complete = 0 ;
    self.jumpState = 0;
    [self loadImages];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)login:(UIButton *)sender {
    
    if ([self.usernameTextField.text isEqualToString:@""]) {
        [ToolUtils showMessage:@"请输入您的手机号"];
        return;
    }
    if ([self.passwordTextField.text isEqualToString:@""]) {
        [ToolUtils showMessage:@"密码不能为空"];
        return;
    }
    [self resignAllResponders:sender];
    [self waiting:@"登录中"];
    [[ApisFactory getApiMLogin] load:self selecter:@selector(disposMessage:) phone:self.usernameTextField.text password:[mMD5 md5s:self.passwordTextField.text] device:@"ios"];
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
    if ([son getMethod] ==nil) {
        [self showLoginView];
        if ([ToolUtils isLogin]) {
            //                [self login:nil];
            self.offline=YES;
            [self loadMain];
        }
    } else if ([[son getMethod] isEqualToString:@"MGetWelcomePage"]) {
        if ([son getError] == 0) {
            //获得返回类
            self.time=0;
            MRet_Builder *ret = (MRet_Builder *)[son getBuild];
            NSLog(@"=======%@",ret.msg);
            if ([ToolUtils isLogin]) {
                [self login:nil ];
            } else {

                [self showLoginView];
            }
        }
    } else if ([[son getMethod] isEqualToString:@"MLogin"])
    {
        if ([son getError] == 0) {
            self.offline=NO;
            MUser_Builder *user = (MUser_Builder *)[son getBuild];
            NSLog(@"account%@  nickname%@ verify  %@ ",user.account,user.nickname,user.verify);
            [ToolUtils setVerify:user.verify];
            [ToolUtils setLoginId:user.id];
            if (user.headImg.length>0) {
                [ToolUtils setHeadImg:user.headImg];
            }
            NSArray *array=[[NSArray alloc]initWithObjects:[NSString stringWithFormat:@"appid=%@",[[Frame INITCONFIG] getAppid]],[NSString stringWithFormat:@"deviceid=%@",[ToolUtils getDeviceid]],[NSString stringWithFormat:@"verify=%@",[ToolUtils getVerify]],[NSString stringWithFormat:@"userid=%@",[ToolUtils getLoginId]],@"device=IOS",nil];
            [Frame setAutoAddParams:array];
            [ToolUtils setIsLogin:YES];
            [ToolUtils setAccount:self.usernameTextField.text];
            [ToolUtils setPassword:self.passwordTextField.text];
            
            FrontiaPush *push = [Frontia getPush];
            if(push) {
                
                NSString *tags = user.verify;
                if (![@"" isEqualToString:tags]) {
                    NSArray *tagArr = [tags componentsSeparatedByString:@";"];
                    
                    [push setTags:tagArr tagOpResult:^(int count, NSArray *failureTag) {
//                        NSString *message = [[NSString alloc] initWithFormat:@"set tag success result: %d with failure tags %@", count, failureTag];
//                        [self performSelectorOnMainThread:@selector(updateBindDisplayMessage:) withObject:message waitUntilDone:NO];
                        
                    } failureResult:^(NSString *action, int errorCode, NSString *errorMessage) {
                        NSString *message = [[NSString alloc] initWithFormat:@"set tag failed with %@ error code : %d error message %@", action, errorCode, errorMessage];
//                        [self performSelectorOnMainThread:@selector(updateBindDisplayMessage:) withObject:message waitUntilDone:NO];
                        [ToolUtils showMessage:message];
                        
                    }];
                }
                
            }
            [[ApisFactory getApiMGetUserInfo]load:self selecter:@selector(disposMessage:)];
        }
    } else if ([[son getMethod]isEqualToString:@"MUnreadModule"])
    {
        if ([son getError] == 0) {
            MUnread_Builder* unread = (MUnread_Builder*)[son getBuild];
            self.unread = unread;
            
            [self loadMain];
        }
    } else if ([[son getMethod] isEqualToString:@"MGetUserInfo"]) {
        //获得返回类
        MUser_Builder *user = (MUser_Builder *)[son getBuild];
        [ToolUtils setBelong:user.belong==nil?@"":user.belong];
        [ToolUtils setBirthday:user.birthday==nil?@"":user.birthday];
        [ToolUtils setNickname:user.nickname==nil?@"":user.nickname];
        [ToolUtils setHeadImg:user.headImg==nil?@"":user.headImg];
        [ToolUtils setIsVeryfy:user.isV];
        switch (user.sex) {
            case 0:
                [ToolUtils setSex:@"女"];
                break;
            case 1:
                [ToolUtils setSex:@"男"];
                break;
            case 2:
                [ToolUtils setSex:@"未知"];
                break;
            default:
                break;
        }
        [ToolUtils setFlowerCount:user.flower];
        [self getUnread];
    }

}
- (void)getUnread
{
    [[ApisFactory getApiMUnreadModule]load:self selecter:@selector(disposMessage:)];
}

- (void)loadMain

{
    UIStoryboard *firstStoryBoard = [UIStoryboard storyboardWithName:@"Home" bundle:nil];
    MainMenuViewController* mainMenuVC = (MainMenuViewController*)[firstStoryBoard instantiateViewControllerWithIdentifier:@"home"]; //test2为viewcontroller的StoryboardId
    mainMenuVC.unread = self.unread;
    mainMenuVC.offline = self.offline;
    mainMenuVC.imageArrays = self.imageArrays;
    mainMenuVC.imageArraysSelected = self.imageArraysSelected;
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:mainMenuVC];
    
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"Self" bundle:nil];
    SelfInfoVC* selfVC = (SelfInfoVC*)[secondStoryBoard instantiateViewControllerWithIdentifier:@"self"]; //test2为viewcontroller的StoryboardId
    selfVC.offline = self.offline;
    UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:selfVC];

    UIStoryboard *thirdStoryBoard = [UIStoryboard storyboardWithName:@"News" bundle:nil];
    SubscribeVC* subVC = (SubscribeVC*)[thirdStoryBoard instantiateViewControllerWithIdentifier:@"subscribe"]; //test2为viewcontroller的StoryboardId
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:subVC];
    
    
    
    ActivityVC* activityVC = (ActivityVC*)[thirdStoryBoard instantiateViewControllerWithIdentifier:@"activity"]; //test2为viewcontroller的StoryboardId
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:activityVC];
    self.tabBarController = [[RDVTabBarController alloc] init];
    [self.tabBarController setViewControllers:@[nav1, nav2,
                                           nav3,nav4]];
    [self.tabBarController setDelegate:self];
    [self customizeTabBarForController:self.tabBarController];
    if (self.complete>=buttonImages.count*2) {
        [self hideLoad];
        [self presentViewController:self.tabBarController animated:YES completion:nil];
    } else {
        self.jumpState=1;
    }
    
}


- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController {
    NSString* rssName = @"订阅";
    NSString* activityName = @"活动";
    if (self.unread.module3>0) {
        rssName = @"订阅消息";
    }
    if (self.unread.module4>0) {
        activityName = @"活动消息";
    }
    NSArray* buttonImages = @[@"首页",rssName,activityName,@"个人"];
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
    if (sender==self.loginButton||sender==self.view||sender==self.loginView) {
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
}




#pragma mark -UITextFieldDelegate
/*Return返回*/
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self resignAllResponders:self.loginButton];
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
   
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
        if (self.view.bounds.size.height==480) {
            CGRect loginViewFrame = CGRectMake(self.loginView.frame.origin.x, 0,self.loginView.frame.size.width, self.loginView.frame.size.height);
            self.loginView.frame = loginViewFrame;
            
            
            CGRect loginLogoFrame = CGRectMake(self.logoImage.frame.origin.x, -228,self.logoImage.frame.size.width, self.logoImage.frame.size.height);
            self.logoImage.frame = loginLogoFrame;

        } else {
            CGRect loginViewFrame = CGRectMake(self.loginView.frame.origin.x, 50,self.loginView.frame.size.width, self.loginView.frame.size.height);
            self.loginView.frame = loginViewFrame;
            
            
            CGRect loginLogoFrame = CGRectMake(self.logoImage.frame.origin.x, -178,self.logoImage.frame.size.width, self.logoImage.frame.size.height);
            self.logoImage.frame = loginLogoFrame;

        }
        
        
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
//    self.time++;
//    if (self.time==20&&!self.indicateView.isHidden) {
//        [ToolUtils showMessage:@"网络连接超时,进入脱机浏览"];
//        [self loadMain];
//    }
}



//加载完毕，显示登录界面。
- (void)showLoginView
{
    [self.view setUserInteractionEnabled:YES];
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

#pragma mark -RDVTabbarcontrollerdelegate
- (BOOL)tabBarController:(RDVTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    if ([tabBarController.viewControllers indexOfObject:viewController]==3) {
//        [viewController.rdv_tabBarController setTabBarHidden:YES];
        [tabBarController presentViewController:viewController animated:YES completion:^{
            
        }];
        return NO;
    };
    return YES;

}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"next"]) {
        RegisterVC* next = (RegisterVC*)segue.destinationViewController;
        if (sender==self.forgetBt) {
            next.myTitle = @"忘记密码";

        } else {
            next.myTitle = @"注册";

        }
        next.myDelegate = self;
    }
}

- (void)login
{
    [self.usernameTextField setText:[ToolUtils getAccount]==nil?@"":[ToolUtils getAccount]];
    [self.passwordTextField setText:[ToolUtils getPassword]==nil?@"":[ToolUtils getPassword]];
    [self loadMain];
}
- (IBAction)goToRegist:(id)sender {
    
    [self performSegueWithIdentifier:@"next" sender:sender];
}

-(void)loadImages
{
    buttonImages = [ToolUtils getButtonImage];
    
    if (buttonImages!=nil) {
        self.imageArrays = [[NSMutableArray alloc]init];
        self.imageArraysSelected = [[NSMutableArray alloc]init];
        for (NSString* imageUrl in buttonImages) {
            CGRect frame = CGRectMake(0, 0, 52, 52);
            NSArray* imageUrls = [imageUrl componentsSeparatedByString:@","];;
            UIImageView* image = [[UIImageView alloc]init];
            image.frame = frame;
            [image setImageWithURL:[ToolUtils getImageUrlWtihString:[imageUrls firstObject]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                self.complete++;
                if (self.complete==buttonImages.count*2&&self.jumpState==1) {
                    [self hideLoad];
                    
                    [self presentViewController:self.tabBarController animated:YES completion:nil];
                }
            }];
            UIImageView* imageSelected = [[UIImageView alloc]init];
            imageSelected.frame = frame;
            [imageSelected setImageWithURL:[ToolUtils getImageUrlWtihString:[imageUrls lastObject]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                self.complete++;
                if (self.complete==buttonImages.count*2&&self.jumpState==1) {
                    [self hideLoad];
                    
                    [self presentViewController:self.tabBarController animated:YES completion:nil];
                }
            }];
            [self.imageArrays addObject:image];
            [self.imageArraysSelected addObject:imageSelected];
        }

    }
        //    [self.tableView reloadData];
}

@end
