//
//  ShoppingVCDelegate.h
//  MobileNJU
//
//  Created by luck-mac on 14-7-29.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShoppingDetailVC.h"
@protocol ShoppingVCDelegate <NSObject>
- (void) moveToDetail:(UIViewController*) vc;
- (void) showView:(UIViewController*)vc;
@end
