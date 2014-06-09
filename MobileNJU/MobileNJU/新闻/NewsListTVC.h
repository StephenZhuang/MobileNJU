//
//  NewsListTVC.h
//  ZSDX2.0
//
//  Created by luck-mac on 14-5-14.
//  Copyright (c) 2014年 zsdx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RefreshTableViewController.h"
@interface NewsListTVC : RefreshTableViewController
@property (nonatomic,strong)NSString* currentUrl;
@property (nonatomic)BOOL jump;
@end
