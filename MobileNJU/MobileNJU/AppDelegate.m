//
//  AppDelegate.m
//  MobileNJU
//
//  Created by Stephen Zhuang on 14-5-21.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "AppDelegate.h"
#import "WelcomeViewController.h"

#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#import "APService.h"
#import "JDStatusBarNotification.h"
#import "RDVTabBarController.h"
#import "NewsListTVC.h"
#import "MobClick.h"
#import "TreeHoleListViewController.h"
#import <Frontia/Frontia.h>
#define APP_KEY @"xHX7fifhRp2wvqps34zwvr4c"

#define REPORT_ID @"d5dd317228"

#define IosAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    [NSThread sleepForTimeInterval:1.0];

    [self initDeviceid];
    [self initApiFrame];
    [self initJPush:launchOptions];
    [self initShare:application options:launchOptions];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Home" bundle:nil];
    WelcomeViewController *vc = [storyboard instantiateInitialViewController];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = nav;
    
    NSDictionary * userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];

//    userInfo = [[NSDictionary alloc]initWithObjectsAndKeys:@"15",@"type",@"7ea5ed86-463e-11e4-bde1-ac853d9f54d2",@"target", nil];
//    userInfo = [[NSDictionary alloc]initWithObjectsAndKeys:@"14",@"type",@"nju/news/1411992130101.html",@"target", @"source",@"source",@"img",@"img",@"titlepush",@"titlepush",nil];

    if (userInfo) {
        [self savePush:userInfo];
//        [self operaUserInfo:userInfo appliccation:application];
    }
    
    [self initUmen];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void) initJPush:(NSDictionary*) launchOptions
{
    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                   UIRemoteNotificationTypeSound |
                                                   UIRemoteNotificationTypeAlert)];
    [APService setupWithOption:launchOptions];
}


- (void)initShare:(UIApplication *)application options:(NSDictionary *)launchOptions
{
    
    //初始化Frontia
    [Frontia initWithApiKey:APP_KEY];
    
}


#pragma - mark init param
- (void) initUmen
{
    
    [MobClick startWithAppkey:@"54158d98fd98c55ce106b749" reportPolicy:BATCH   channelId:nil];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    [ToolUtils setVersion:version];
//    [MobClick setLogEnabled:YES];
//    Class cls = NSClassFromString(@"UMANUtil");
//    SEL deviceIDSelector = @selector(openUDIDString);
//    NSString *deviceID = nil;
//    if(cls && [cls respondsToSelector:deviceIDSelector]){
//        deviceID = [cls performSelector:deviceIDSelector];
//    }
//    NSLog(@"{\"oid\": \"%@\"}", deviceID);
    
}

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
    [APService registerDeviceToken:deviceToken];
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
    [APService handleRemoteNotification:userInfo];

    
}



- (void) savePush:(NSDictionary*)userInfo
{
    
//    userInfo = [[NSDictionary alloc]initWithObjectsAndKeys:@"15",@"type",@"7ea5ed86-463e-11e4-bde1-ac853d9f54d2",@"target", nil];

    int type = [[userInfo objectForKey:@"type"] integerValue];
    if (type==11) {
        NSMutableDictionary* pushNews = [[NSMutableDictionary alloc]init];
    
        [pushNews setObject:[userInfo objectForKey:@"target"]==nil?@"":[userInfo objectForKey:@"target"] forKey:@"url"];
        [pushNews setObject:[userInfo objectForKey:@"source"]==nil?@"":[userInfo objectForKey:@"source"] forKey:@"source"];
        [pushNews setObject:[userInfo objectForKey:@"img"]==nil?@"":[userInfo objectForKey:@"img"] forKey:@"img"];
        [pushNews setObject:[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]  forKey:@"title"];
        //        [pushNews setObject:@"title" forKey:@"title"];
        [ToolUtils setShowNews:pushNews];
        
    } else if (type == 13)
    {
        NSMutableDictionary* pushNews = [[NSMutableDictionary alloc]init];
        [pushNews setObject:[userInfo objectForKey:@"target"]==nil?@"":[userInfo objectForKey:@"target"] forKey:@"url"];
        [pushNews setObject:[userInfo objectForKey:@"source"]==nil?@"":[userInfo objectForKey:@"source"] forKey:@"source"];
        [pushNews setObject:[userInfo objectForKey:@"img"] ==nil?@"":[userInfo objectForKey:@"img"]forKey:@"img"];
        [pushNews setObject:[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]  forKey:@"title"];
        //        [pushNews setObject:@"title" forKey:@"title"];
        [ToolUtils setShowActivity:pushNews];
        
    } else if (type == 14)
    {
        NSMutableDictionary* pushNews = [[NSMutableDictionary alloc]init];
        [pushNews setObject:[userInfo objectForKey:@"target"]==nil?@"":[userInfo objectForKey:@"target"] forKey:@"url"];
        [pushNews setObject:[userInfo objectForKey:@"source"]==nil?@"":[userInfo objectForKey:@"source"] forKey:@"source"];
        [pushNews setObject:[userInfo objectForKey:@"img"]==nil?@"":[userInfo objectForKey:@"img"] forKey:@"img"];
        [pushNews setObject:[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]  forKey:@"title"];
        //        [pushNews setObject:@"title" forKey:@"title"];
        [ToolUtils setShowRss:pushNews];
    } else if (type==15)
    {
        NSString* url = [userInfo objectForKey:@"target"];
        if (url) {
            [ToolUtils setShowTreeHole:url];
        }
    }
    else if (type==1)
    {
        [ToolUtils setHasSixin:YES];
    }

}
- (void)operaUserInfo:(NSDictionary *)userInfo appliccation:(UIApplication *)application
{
//    userInfo = [[NSDictionary alloc]initWithObjectsAndKeys:@"14",@"type",@"nju/news/1411901779786.html",@"target",@"测试",@"titlepush",@"img",@"img",@"source",@"source",nil];
    [self savePush:userInfo];
    
    
    if ([[userInfo objectForKey:@"type"] integerValue] == 1) {
        [ToolUtils setHasSixin:NO];
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
    } else if ([[userInfo objectForKey:@"type"] integerValue] == 11){
//            NSMutableDictionary* pushNews = [[NSMutableDictionary alloc]init];
//            [pushNews setObject:[userInfo objectForKey:@"target"] forKey:@"url"];
//            [pushNews setObject:[userInfo objectForKey:@"source"] forKey:@"source"];
//            [pushNews setObject:[userInfo objectForKey:@"img"] forKey:@"img"];
//            [pushNews setObject:[userInfo objectForKey:@"titlepush"] forKey:@"title"];
////        [pushNews setObject:@"title" forKey:@"title"];
//            [ToolUtils setShowNews:pushNews];
        if (application.applicationState == UIApplicationStateInactive){
            UIViewController *vc = (UINavigationController *)application.keyWindow.rootViewController;
            RDVTabBarController *tabbar = (RDVTabBarController *)vc.presentedViewController;
            UINavigationController *nav = (UINavigationController*)tabbar.selectedViewController;
            UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"News" bundle:nil];
            UINavigationController* unc = (UINavigationController*)[secondStoryBoard instantiateViewControllerWithIdentifier:@"newsList"]; //test2为viewcontroller的StoryboardId
            NewsListTVC* newsList = (NewsListTVC*)[unc.childViewControllers firstObject];
            newsList.jump = YES;
            MNews_Builder* focus = [[MNews_Builder alloc]init];
            NSDictionary* pushNews = [ToolUtils shouldShowNews];
            focus.title = [pushNews objectForKey:@"title"];
            focus.source = [pushNews objectForKey:@"source"];
            focus.img = [pushNews objectForKey:@"img"];
            focus.url = [pushNews objectForKey:@"url"];
            [newsList setCurrentUrl:focus.url];
            [newsList setCurrentNew:focus.build];
            [[nav.viewControllers lastObject] presentViewController:unc animated:YES completion:nil];
            //        [newsList setCurrentImg:[self.photoList objectAtIndex:self.pageController.currentPage]];
            [ToolUtils setShowNews:nil];

        } else if(application.applicationState == UIApplicationStateActive){
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
                                          styleName:@"style" object:@"2" userInfo:userInfo];

        }
    }else if ([[userInfo objectForKey:@"type"] integerValue] == 14){
//        NSMutableDictionary* pushNews = [[NSMutableDictionary alloc]init];
//        [pushNews setObject:[userInfo objectForKey:@"target"] forKey:@"url"];
//        [pushNews setObject:[userInfo objectForKey:@"source"] forKey:@"source"];
//        [pushNews setObject:[userInfo objectForKey:@"img"] forKey:@"img"];
//        [pushNews setObject:[userInfo objectForKey:@"titlepush"] forKey:@"title"];
////        [pushNews setObject:@"title" forKey:@"title"];
//        [ToolUtils setShowRss:pushNews];
        if (application.applicationState != UIApplicationStateActive){
#warning 此处判断是否在新闻列表界面
            UIViewController *vc = (UINavigationController *)application.keyWindow.rootViewController;
            RDVTabBarController *tabbar = (RDVTabBarController *)vc.presentedViewController;
            [tabbar setSelectedIndex:1];
        } else {
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
                                          styleName:@"style" object:@"3" userInfo:userInfo];
        }

    }else if ([[userInfo objectForKey:@"type"] integerValue] == 13){
//        NSMutableDictionary* pushNews = [[NSMutableDictionary alloc]init];
//        [pushNews setObject:[userInfo objectForKey:@"target"] forKey:@"url"];
//        [pushNews setObject:[userInfo objectForKey:@"source"] forKey:@"source"];
//        [pushNews setObject:[userInfo objectForKey:@"img"] forKey:@"img"];
//        [pushNews setObject:[userInfo objectForKey:@"titlepush"] forKey:@"title"];
////        [pushNews setObject:@"title" forKey:@"title"];
//        [ToolUtils setShowActivity:pushNews];
        if (application.applicationState != UIApplicationStateActive){
#warning 此处判断是否在新闻列表界面
            UIViewController *vc = (UINavigationController *)application.keyWindow.rootViewController;
            RDVTabBarController *tabbar = (RDVTabBarController *)vc.presentedViewController;
            [tabbar setSelectedIndex:2];
        } else {
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
                                          styleName:@"style" object:@"4" userInfo:userInfo];
        }
        
    } else if ([[userInfo objectForKey:@"type"] integerValue] == 15)
    {
        if (application.applicationState != UIApplicationStateActive){
            UIViewController *vc = (UINavigationController *)application.keyWindow.rootViewController;
            RDVTabBarController *tabbar = (RDVTabBarController *)vc.presentedViewController;
            [tabbar setTabBarHidden:YES];
            UINavigationController *nav = (UINavigationController*)tabbar.selectedViewController;
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"TreeHole" bundle:nil];
            TreeHoleListViewController *treeHole = [storyboard instantiateInitialViewController];
            [nav pushViewController:treeHole animated:YES];
        } else {
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
                                          styleName:@"style" object:@"5" userInfo:userInfo];

        }
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


- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application { // 清除内存中的图片缓存
    SDWebImageManager *mgr = [SDWebImageManager sharedManager];
    [mgr cancelAll];
    [mgr.imageCache clearMemory];
}

@end
