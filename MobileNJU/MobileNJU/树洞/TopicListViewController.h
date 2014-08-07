//
//  TopicListViewController.h
//  MobileNJU
//
//  Created by Stephen Zhuang on 14-8-6.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "RefreshTableViewController.h"

typedef void(^SelectTagBlock)(MTag *tag);

@interface TopicListViewController : RefreshTableViewController<UITableViewDataSource , UITableViewDelegate>
@property (nonatomic , weak) IBOutlet UITableView *overtableView;
@property (nonatomic , copy) SelectTagBlock selectTagBlock;
@end
