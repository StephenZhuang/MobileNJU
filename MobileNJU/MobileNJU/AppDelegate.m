//
//  AppDelegate.m
//  MobileNJU
//
//  Created by Stephen Zhuang on 14-5-21.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "AppDelegate.h"
#import "WelcomeViewController.h"
#import <Frontia/Frontia.h>
#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#import <Frontia/FrontiaPush.h>
#import <Frontia/Frontia.h>
#import "JDStatusBarNotification.h"
#import "RDVTabBarController.h"

#define APP_KEY @"MGZF96fGRexFypz7bvgapVY1"
#define REPORT_ID @"d5dd317228"

#define IosAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    [self initDeviceid];
    [self initApiFrame];
    [self initShare:application options:launchOptions];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Home" bundle:nil];
    WelcomeViewController *vc = [storyboard instantiateInitialViewController];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = nav;
    
    NSDictionary * userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (userInfo) {
        [self operaUserInfo:userInfo appliccation:application];
    }
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
      return YES;
}

#pragma - mark init param
- (void)initApiFrame
{
    [Frame build];
    
    //设置全局参数
    NSArray *array = nil;
    if ([ToolUtils isLogin]) {
        array=[[NSArray alloc]initWithObjects:[NSString stringWithFormat:@"appid=%@",[[Frame INITCONFIG] getAppid]],[NSString stringWithFormat:@"deviceid=%@",[ToolUtils getDeviceid]],[NSString stringWithFormat:@"verify=%@",[ToolUtils getVerify]],[NSString stringWithFormat:@"userid=%@",[ToolUtils getLoginId]],nil];
    } else {
        array=[[NSArray alloc]initWithObjects:[NSString stringWithFormat:@"appid=%@",[[Frame INITCONFIG] getAppid]],[NSString stringWithFormat:@"deviceid=%@",[ToolUtils getDeviceid]],@"device=IOS",nil];
    }
    [Frame setAutoAddParams:array];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"WIFI" forKey:@"internet"];
    [[NSUserDefaults standardUserDefaults] setObject:@"kai" forKey:@"3g2g"];
}

- (void)initShare:(UIApplication *)application options:(NSDictionary *)launchOptions
{

    //初始化Frontia
    [Frontia initWithApiKey:APP_KEY];
    
    [Frontia getPush];
    [FrontiaPush setupChannel:launchOptions];
    
    [application registerForRemoteNotificationTypes:
     UIRemoteNotificationTypeAlert
     | UIRemoteNotificationTypeBadge
     | UIRemoteNotificationTypeSound];
    
    
    FrontiaStatistics* statTracker = [Frontia getStatistics];
    statTracker.enableExceptionLog = YES; // 是否允许截获并发送崩溃信息，请设置YES或者NO
    statTracker.channelId = @"123456";//设置您的app的发布渠道
    statTracker.logStrategy = FrontiaStatLogStrategyCustom;//根据开发者设定的时间间隔接口发送 也可以使用启动时发送策略
    statTracker.logSendInterval = 1;  //为1时表示发送日志的时间间隔为1小时
    statTracker.logSendWifiOnly = YES; //是否仅在WIfi情况下发送日志数据
    statTracker.sessionResumeInterval = 60;//设置应用进入后台再回到前台为同一次session的间隔时间[0~600s],超过600s则设为600s，默认为30s
    statTracker.shortAppVersion  = IosAppVersion; //参数为NSString * 类型,自定义app版本信息，如果不设置，默认从CFBundleVersion里取
    [statTracker startWithReportId:REPORT_ID];//设置您在mtj网站上添加的app的appkey
    
    BOOL isFirstOpen = NO;
    if ([[ToolUtils getVersion] isEqualToString:IosAppVersion]) {
        isFirstOpen = NO;
    } else {
        isFirstOpen = YES;
    }
    
    if (isFirstOpen) {
        [self onBindClick:nil];
    }
    [ToolUtils setVersion:IosAppVersion];
}

//绑定，以获取通知
- (IBAction)onBindClick:(id)sender {
    FrontiaPush *push = [Frontia getPush];

    if(push) {

        [push bindChannel:^(NSString *appId, NSString *userId, NSString *channelId) {
//            NSString *message = [[NSString alloc] initWithFormat:@"appid:%@ \nuserid:%@ \nchannelID:%@", appId, userId, channelId];
            NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:userId forKey:@"pushId"];
            [userDefaults synchronize];

//            self.appidText.text = appId;
//            self.useridText.text = userId;
//            self.channelidText.text = channelId;
            
//            [self performSelectorOnMainThread:@selector(updateBindDisplayMessage:) withObject:message waitUntilDone:NO];
            
        } failureResult:^(NSString *action, int errorCode, NSString *errorMessage) {

//            NSString *message = [[NSString alloc] initWithFormat:@"string is %@ error code : %d error message %@", action, errorCode, errorMessage];
//            [self performSelectorOnMainThread:@selector(updateBindDisplayMessage:) withObject:message waitUntilDone:NO];
        }];
    } else {
    }
}

- (void)initDeviceid
{
    //获取deviceid，7以上使用udid，以下使用macaddress
    NSString *sysVersion = [UIDevice currentDevice].systemVersion;
    CGFloat version = [sysVersion floatValue];
    
    NSString *deviceid = @"";
    if (version >= 7.0) {
        deviceid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    }
    else if (version >= 2.0) {
        deviceid =  [self getMacAddress];
    }
    [[NSUserDefaults standardUserDefaults] setObject:deviceid forKey:@"deviceid"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)getMacAddress
{
    int                 mgmtInfoBase[6];
    char                *msgBuffer = NULL;
    size_t              length;
    unsigned char       macAddress[6];
    struct if_msghdr    *interfaceMsgStruct;
    struct sockaddr_dl  *socketStruct;
    NSString            *errorFlag = NULL;
    
    // Setup the management Information Base (mib)
    mgmtInfoBase[0] = CTL_NET;        // Request network subsystem
    mgmtInfoBase[1] = AF_ROUTE;       // Routing table info
    mgmtInfoBase[2] = 0;
    mgmtInfoBase[3] = AF_LINK;        // Request link layer information
    mgmtInfoBase[4] = NET_RT_IFLIST;  // Request all configured interfaces
    
    // With all configured interfaces requested, get handle index
    if ((mgmtInfoBase[5] = if_nametoindex("en0")) == 0)
        errorFlag = @"if_nametoindex failure";
    else
    {
        // Get the size of the data available (store in len)
        if (sysctl(mgmtInfoBase, 6, NULL, &length, NULL, 0) < 0)
            errorFlag = @"sysctl mgmtInfoBase failure";
        else
        {
            // Alloc memory based on above call
            if ((msgBuffer = malloc(length)) == NULL)
                errorFlag = @"buffer allocation failure";
            else
            {
                // Get system information, store in buffer
                if (sysctl(mgmtInfoBase, 6, msgBuffer, &length, NULL, 0) < 0)
                    errorFlag = @"sysctl msgBuffer failure";
            }
        }
    }
    
    // Befor going any further...
    if (errorFlag != NULL)
    {
        NSLog(@"Error: %@", errorFlag);
        return errorFlag;
    }
    
    // Map msgbuffer to interface message structure
    interfaceMsgStruct = (struct if_msghdr *) msgBuffer;
    
    // Map to link-level socket structure
    socketStruct = (struct sockaddr_dl *) (interfaceMsgStruct + 1);
    
    // Copy link layer address data in socket structure to an array
    memcpy(&macAddress, socketStruct->sdl_data + socketStruct->sdl_nlen, 6);
    
    // Read from char array into a string object, into traditional Mac address format
    NSString *macAddressString = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x",
                                  macAddress[0], macAddress[1], macAddress[2],
                                  macAddress[3], macAddress[4], macAddress[5]];
    NSLog(@"Mac Address: %@", macAddressString);
    
    // Release the buffer memory
    free(msgBuffer);
    
    return macAddressString;
}

#pragma - mark push
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    NSLog(@"frontia application:%@", deviceToken);
    [FrontiaPush registerDeviceToken: deviceToken];
    
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"frontia application:%@", error);
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"frontia applciation receive Notify: %@", [userInfo description]);
//    NSString *alert = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
    if (application.applicationState == UIApplicationStateActive || application.applicationState == UIApplicationStateInactive) {
        // Nothing to do if applicationState is Inactive, the iOS already displayed an alert view.
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Did receive a Remote Notification"
//                                                            message:[NSString stringWithFormat:@"The application received this remote notification while it was running:\n%@", alert]
//                                                           delegate:self
//                                                  cancelButtonTitle:@"OK"
//                                                  otherButtonTitles:nil];
//        [alertView show];
        [self operaUserInfo:userInfo appliccation:application];
    } else {
        int bage = [[userInfo objectForKey:@"badge"] intValue];
        [application setApplicationIconBadgeNumber:bage];
    }
    
    [FrontiaPush handleNotification:userInfo];
    
}

- (void)operaUserInfo:(NSDictionary *)userInfo appliccation:(UIApplication *)application
{
    if ([[userInfo objectForKey:@"type"] integerValue] == 1) {
        UIViewController *vc = (UINavigationController *)application.keyWindow.rootViewController;
        RDVTabBarController *tabbar = (RDVTabBarController *)vc.presentedViewController;
        UINavigationController *nav = [tabbar.viewControllers firstObject];
        if (![[nav.viewControllers lastObject] isKindOfClass:NSClassFromString(@"ChatViewController")]) {
            [JDStatusBarNotification addStyleNamed:@"style" prepare:^JDStatusBarStyle *(JDStatusBarStyle *style) {
                style.font = [UIFont systemFontOfSize:12];
                style.textColor = [UIColor whiteColor];
                style.barColor = RGB(60, 139, 253);
                style.animationType = JDStatusBarAnimationTypeMove;

                //        style.progressBarColor = self.progressBarColorPreview.backgroundColor;
                //        style.progressBarPosition = self.progressBarPosition;
                //        style.progressBarHeight = [self.barHeightLabel.text integerValue];
                
                return style;
            }];
            [JDStatusBarNotification showWithStatus:[[userInfo objectForKey:@"aps"] objectForKey:@"alert"] dismissAfter:2.0
                                          styleName:@"style" object:@"1" userInfo:userInfo];
        } else {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"getNanguaMessage" object:nil userInfo:userInfo];
        }

    } else if ([[userInfo objectForKey:@"type"] integerValue] == 3) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"getCall" object:nil userInfo:userInfo];        
    } else if ([[userInfo objectForKey:@"type"] integerValue] == 4) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"receivedCall" object:nil userInfo:userInfo];
    }
    [application setApplicationIconBadgeNumber:0];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSInteger badge = application.applicationIconBadgeNumber;
    if (badge > 0) {
        badge = 0;
        [application setApplicationIconBadgeNumber:badge];
        [[ApisFactory getApiMPushClear] load:self selecter:@selector(disposMessage:)];
    }
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    FrontiaShare *share = [Frontia getShare];
    return [share handleOpenURL:url];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application { // 清除内存中的图片缓存
    SDWebImageManager *mgr = [SDWebImageManager sharedManager];
    [mgr cancelAll];
    [mgr.imageCache clearMemory];
}

@end
