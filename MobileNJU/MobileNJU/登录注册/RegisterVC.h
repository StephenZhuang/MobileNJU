//
//  RegisterVC.h
//  MobileNJU
//
//  Created by luck-mac on 14-7-26.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "loginDelegate.h"
@interface RegisterVC : BaseViewController
@property (nonatomic,strong) id<loginDelegate> myDelegate;
@end
