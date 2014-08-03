//
//  ShoppingDetailVC.h
//  MobileNJU
//
//  Created by luck-mac on 14-7-29.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyBaseTableViewController.h"
#import "ApiMMarketList.h"
@interface ShoppingDetailVC : MyBaseTableViewController
@property (nonatomic,strong)MMarket* market;
@end
