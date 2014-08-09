//
//  GradeDetailVC.h
//  MobileNJU
//
//  Created by luck-mac on 14-5-26.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "GradeVC.h"
@interface GradeDetailVC : BaseViewController
@property (nonatomic,strong)NSString* term;
@property (nonatomic,strong)NSString* account;
@property(nonatomic,strong)NSString* password;
@property(nonatomic,weak)GradeVC* lastVC;
@end
