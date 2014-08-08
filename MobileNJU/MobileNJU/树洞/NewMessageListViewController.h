//
//  NewMessageListViewController.h
//  MobileNJU
//
//  Created by Stephen Zhuang on 14-6-6.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "RefreshTableViewController.h"
#import "NewMessageCell.h"

typedef void(^ReadMessageBlock)(NSInteger num);

@interface NewMessageListViewController : BaseViewController<UITableViewDataSource , UITableViewDelegate , SWTableViewCellDelegate>
{
    NSInteger selectIndex;
}
@property (nonatomic , copy) ReadMessageBlock readMessageBlock;
@property (nonatomic , weak) IBOutlet UITableView *tableView;
@property (nonatomic , weak) IBOutlet UILabel *commentNumLabel;
@property (nonatomic , weak) IBOutlet UILabel *messageNumLabel;
@property (nonatomic , strong) NSMutableArray *topicArray;
@property (nonatomic , strong) NSMutableArray *chatArray;
@property (nonatomic , weak) IBOutlet UIButton *commentButton;
@property (nonatomic , weak) IBOutlet UIButton *messageButton;
@property (nonatomic , strong) UIView *sectionHeader;
@end
