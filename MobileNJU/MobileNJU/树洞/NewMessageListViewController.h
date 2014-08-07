//
//  NewMessageListViewController.h
//  MobileNJU
//
//  Created by Stephen Zhuang on 14-6-6.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "RefreshTableViewController.h"

typedef void(^ReadMessageBlock)(NSInteger num);

@interface NewMessageListViewController : BaseViewController
{
    NSInteger selectIndex;
}
@property (nonatomic , copy) ReadMessageBlock readMessageBlock;
@property (nonatomic , weak) IBOutlet UITableView *tableView;
@property (nonatomic , weak) IBOutlet UILabel *commentNumLabel;
@property (nonatomic , weak) IBOutlet UILabel *messageNumLabel;
@property (nonatomic , strong) NSMutableArray *topicArray;
@property (nonatomic , strong) NSMutableArray *chatArray;
@end
