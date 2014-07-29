//
//  MyNavigationController.h
//  MobileNJU
//
//  Created by luck-mac on 14-7-29.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "myNavigationControllerDelegate.h"
@interface MyNavigationController : UINavigationController
@property (nonatomic) id<myNavigationControllerDelegate> myDelegate;
- (void)logOut;
- (void)hideTabBar:(BOOL)hide;
@end
