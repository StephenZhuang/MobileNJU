//
//  TreeHoleListViewController.h
//  MobileNJU
//
//  Created by Stephen Zhuang on 14-5-24.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "RefreshTableViewController.h"

@interface TreeHoleListViewController : RefreshTableViewController<UIAlertViewDelegate , UITableViewDataSource , UITableViewDelegate>
@property (nonatomic , strong) UIView *sectionHeader;
@property (nonatomic , strong) UIButton *messageButton;
@end
