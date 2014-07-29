//
//  myNavigationControllerDelegate.h
//  MobileNJU
//
//  Created by luck-mac on 14-7-29.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol myNavigationControllerDelegate <NSObject>
-(void)logOut;
-(void)hideTabBar:(BOOL)hide;
@end
