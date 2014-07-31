//
//  AddShopVC.h
//  MobileNJU
//
//  Created by luck-mac on 14-7-29.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "BaseViewController.h"
#import "FirstPage.h"
@interface AddShopVC : BaseViewController
@property (nonatomic)NSInteger currentPage;
@property (weak, nonatomic) IBOutlet FirstPage *firstPage;
@end
