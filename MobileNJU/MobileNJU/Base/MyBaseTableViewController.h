//
//  MyBaseTableViewController.h
//  MobileNJU
//
//  Created by luck-mac on 14-7-29.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TitleView.h"
#import "MBProgressHUD.h"
@interface MyBaseTableViewController : UITableViewController
@property (strong, nonatomic) NSArray *backIcons;
@property (nonatomic , strong) TitleView *titleView;
@property (weak, nonatomic) IBOutlet UIView *maskView;
@property (nonatomic,strong)UIActivityIndicatorView* loginIndicator;
@property (nonatomic)BOOL OK;
-(void)closeSelf;
- (void)addTitleView;
- (void)addMask;
- (void)removeMask;

- (void) showAlert:(NSString*)msg;
- (void) waiting:(NSString*)msg;
- (void)disposMessage:(Son *)son;
@end
