//
//  AddShopVC.h
//  MobileNJU
//
//  Created by luck-mac on 14-7-29.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "BaseViewController.h"
#import "FirstPage.h"
#import "SecondPage.h"
@interface AddShopVC : BaseViewController
@property (nonatomic)NSInteger currentPage;
@property (nonatomic)UIViewController* lastVC;
@property (weak, nonatomic) IBOutlet FirstPage *firstPage;
@property (nonatomic,strong)MAddMarket_Builder* market;
@property (weak, nonatomic) IBOutlet SecondPage *secondPage;
@property (nonatomic) AddShopVC* myLast;
@property(nonatomic)BOOL shoudReturn;
@property (nonatomic,strong)NSArray* typeList;
- (void)setType:(NSArray *)typeList;
@end
