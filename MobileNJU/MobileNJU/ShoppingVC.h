//
//  ShoppingVC.h
//  CreateLesson
//
//  Created by luck-mac on 14-7-29.
//  Copyright (c) 2014年 nju.excalibur. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "ShoppingVCDelegate.h"
@interface ShoppingVC : BaseViewController
@property (nonatomic) id<ShoppingVCDelegate> myDelegate;
@end
