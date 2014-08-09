//
//  SelfInfoVC.h
//  MobileNJU
//
//  Created by luck-mac on 14-5-22.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "RDVTabBarController.h"
@interface SelfInfoVC : BaseViewController
@property(nonatomic,strong)NSArray* infos;
@property (nonatomic)int flowerCount;
@property (nonatomic,strong)RDVTabBarController* tabBarVC;
@end
