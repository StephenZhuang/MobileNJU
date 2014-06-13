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
@interface BaseViewController : UIViewController
@property (strong, nonatomic) NSArray *backIcons;
@property (nonatomic , strong) TitleView *titleView;
@property (weak, nonatomic) IBOutlet UIView *maskView;
@property (nonatomic,strong)MBProgressHUD* loginIndicator;
@property (nonatomic)BOOL OK;
-(void)closeSelf;
- (void)addTitleView;
- (void)setTitle:(NSString*)title;
- (void)setSubTitle:(NSString*)subTitle;
- (void)addMask;
- (void)removeMask;

- (void) showAlert:(NSString*)msg;
- (void) waiting:(NSString*)msg;
- (void)disposMessage:(Son *)son;
@end
