//
//  BaseViewController.h
//  MobileNJU
//
//  Created by Stephen Zhuang on 14-5-21.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TitleView.h"

@interface BaseViewController : UIViewController
@property (strong, nonatomic) NSArray *backIcons;
@property (nonatomic , strong) TitleView *titleView;
-(void)closeSelf;
- (void)addTitleView;
- (void)setTitle:(NSString*)title;
- (void)setSubTitle:(NSString*)subTitle;
- (void)addMask;
- (void)removeMask;
- (void) showAlert:(NSString*)msg;
@end
