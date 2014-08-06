//
//  TopicListViewController.h
//  MobileNJU
//
//  Created by Stephen Zhuang on 14-8-6.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "RefreshTableViewController.h"

@interface TopicListViewController : RefreshTableViewController<UITableViewDataSource , UITableViewDelegate>
@property (nonatomic , weak) IBOutlet UITableView *overtableView;
@end
