//
//  NewsListTVC.h
//  ZSDX2.0
//
//  Created by luck-mac on 14-5-14.
//  Copyright (c) 2014年 zsdx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RefreshTableViewController.h"
#import "ZsndNews.pb.h"
@interface NewsListTVC : RefreshTableViewController
@property (nonatomic,strong)MNews* currentNew;
@property (nonatomic,strong)NSString* currentUrl;
@property (nonatomic)BOOL jump;
@property (nonatomic,strong)UIImage*  currentImg;
@end
