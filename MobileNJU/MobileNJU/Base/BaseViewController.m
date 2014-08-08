//
//  BaseViewController.m
//  MobileNJU
//
//  Created by Stephen Zhuang on 14-5-21.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "BaseViewController.h"
#import "MainMenuViewController.h"
#import "SelfInfoVC.h"
#import "ExerciseVC.h"
#import "EcardVC.h"
#import "MyLibraryVC.h"
#import "ExerciseVC.h"
#import "WelcomeViewController.h"
#import "RDVTabBarController.h"
#import "BookViewController.h"
#import "RDVTabBarController.h"
#import "VerifyVC.h"
@interface BaseViewController ()<UINavigationBarDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
//}
//- (void)setTitle:(NSString*)title{
////    [self.titleView setTitle:title];
//    [self setTitle:title];
//}
//
//- (void)setSubTitle:(NSString*)subTitle{
//    [self.titleView setSubTitle:subTitle];
//}

/*Show Alert*/
- (void) showAlert:(NSString*)msg
{
//    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"注册" message:msg delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil] ;
//    [alert show];
    [ProgressHUD showError:msg];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.hasAlert = NO;
    // Do any additional setup after loading the view.
    if([self.navigationController.navigationBar
        respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        [self.navigationController.navigationBar  setBackgroundImage:[[UIImage imageNamed:@"navigationBack"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)]   forBarMetrics:UIBarMetricsDefault];
        //        [self.navigationController.navigationBar setBackgroundColor:RGB(143, 60, 133)];
        [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                         [UIColor colorWithRed:1 green:1 blue:1 alpha:1], NSForegroundColorAttributeName,
                                                                         [UIColor colorWithRed:1 green:1 blue:1 alpha:1], UITextAttributeTextShadowColor,
                                                                         [NSValue valueWithUIOffset:UIOffsetMake(0, 0)],
                                                                         UITextAttributeTextShadowOffset,
                                                                                                                                    [UIFont fontWithName:@"Helvetica" size:24.0],
                                                                        UITextAttributeFont,
                                                                         nil]];
        
        if([self.navigationController respondsToSelector:@selector(backIcons)]){
            _backIcons=[self.navigationController performSelector:@selector(backIcons)];
        }
        if([self.navigationController viewControllers].count>1){
            UIButton *button  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 30)];
            NSString *iconname=DEFAULTBACKICON;
            if(_backIcons!=nil && _backIcons.count>0){
                if ([self.navigationController viewControllers].count-2<_backIcons.count) {
                    iconname=[_backIcons objectAtIndex:[self.navigationController viewControllers].count-2];
                }else{
                    iconname=[_backIcons objectAtIndex:_backIcons.count-1 ];
                }
            }
            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_n",iconname]] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_p",iconname]] forState:UIControlStateHighlighted];
            [button addTarget:self action:@selector(closeSelf) forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem *myAddButton = [[UIBarButtonItem alloc] initWithCustomView:button];
            NSArray *myButtonArray = [[NSArray alloc] initWithObjects: myAddButton, nil];
            self.navigationItem.leftBarButtonItems = myButtonArray;
        }
    }
    [self.navigationController.navigationBar setAlpha:1];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
}

- (void)addTitleView
{
    self.titleView = [[[NSBundle mainBundle] loadNibNamed:@"TitleView" owner:self options:nil] firstObject];
    [self.navigationItem setTitleView:self.titleView];
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeSelf)];
    [self.titleView.touchView addGestureRecognizer:singleTap];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.loginIndicator setHidden:YES];
    [self.loginIndicator removeFromSuperview];
}

-(void)closeSelf{
    if (self.loginIndicator) {
        [self.loginIndicator setHidden:YES];
        [self.loginIndicator removeFromSuperview];
    }
    if([self.navigationController viewControllers].count>0){
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [[self.navigationItem.leftBarButtonItems objectAtIndex:0] hidesBackButton];
    }
}

- (void)didReceiveMemoryWarning
{
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
UIView* view;
- (void)addMask
{
//    if (!_view) {
    if (view!=nil) {
        [view removeFromSuperview];
    }
    [self.maskView setHidden:NO];
    CGRect frame = CGRectMake(0, -20, 0, 0);
    frame.size = self.navigationController.navigationBar.frame.size;
    if ([[[UIDevice currentDevice]systemVersion]floatValue]<7.0) {
        frame.size.height = frame.size.height+21;
    }
    frame.size.height = frame.size.height+20;
    view = [[UIView alloc]initWithFrame:frame];
    [view setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6]];
    [self.navigationController.navigationBar addSubview:view];


}


- (void) waiting:(NSString*)msg
{
    [self.loginIndicator removeFromSuperview];
    CGRect frame = CGRectMake(110, 200, 100, 100);
    self.loginIndicator = [[[NSBundle mainBundle] loadNibNamed:@"WaitingView" owner:self options:nil] firstObject];
    self.loginIndicator.layer.cornerRadius=15;
    [self.loginIndicator setClipsToBounds:YES];
    self.loginIndicator.frame = frame;
    [self.navigationController.view addSubview:self.loginIndicator];
    [self.loginIndicator.msgLbel setText:msg];
    [self.navigationController.view bringSubviewToFront:self.loginIndicator];
}

- (void)disposMessage:(Son *)son
{
    if ([son getError]!=0) {
        if ([[son getMsg] isEqualToString:@"登录验证失败"]) {
            if (!self.hasAlert) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您的账户在别处登录" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                alert.delegate = self;
                [alert show];
                self.hasAlert = YES;
            }
            
        }
    }
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [self returnToWelcome];
}
- (void)returnToWelcome
{
    [self.rdv_tabBarController dismissViewControllerAnimated:YES completion:nil];
}
- (void)removeMask
{
    [self.maskView setHidden:YES];
    [view setHidden:YES];
    [view removeFromSuperview];
}
#pragma mark -UINavigationDelegate,UINavigationBarDelegate
/*
 设置rootViewController的NavigationBar 不可见
 */
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (
        [viewController class]==[WelcomeViewController class]||
        [viewController class] == [MainMenuViewController class]
        || [viewController class]==[SelfInfoVC class]
        || [viewController class]== [ExerciseVC class]
        || [viewController class]==[EcardVC class]
        || [viewController class]==[ExerciseVC class]
        || [viewController class]==[BookViewController class]
        ) {
        [navigationController setNavigationBarHidden:YES animated:animated];
    } else if ( [navigationController isNavigationBarHidden] ) {
        [navigationController setNavigationBarHidden:NO animated:animated];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.loginIndicator removeFromSuperview];
    [view removeFromSuperview];
    [self removeMask];
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
