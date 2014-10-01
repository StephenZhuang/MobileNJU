//
//  BaseViewController.h
//  MobileNJU
//
//  Created by Stephen Zhuang on 14-5-21.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TitleView.h"
#import "MBProgressHUD.h"
#import "WaitingView.h"
@interface BaseViewController : UIViewController
@property (strong, nonatomic) NSArray *backIcons;
@property (nonatomic , strong) TitleView *titleView;
@property (strong, nonatomic) IBOutlet UIView *maskView;
@property (nonatomic,strong)WaitingView* loginIndicator;
@property (nonatomic)BOOL OK;
@property (nonatomic)BOOL hasAlert;
@property (nonatomic)BOOL offline;
-(void)closeSelf;
- (void)addTitleView;
- (void)addMask;
- (void)removeMask;
- (void)returnToWelcome;
- (void) showAlert:(NSString*)msg;
- (void) waiting:(NSString*)msg;
- (void)disposMessage:(Son *)son;
- (void)goToChat:(NSNotification *)notification;
@end
