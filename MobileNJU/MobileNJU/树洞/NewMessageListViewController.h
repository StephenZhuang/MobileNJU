//
//  NewMessageListViewController.h
//  MobileNJU
//
//  Created by Stephen Zhuang on 14-6-6.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "RefreshTableViewController.h"

typedef void(^ReadMessageBlock)(NSInteger num);

@interface NewMessageListViewController : RefreshTableViewController
@property (nonatomic , copy) ReadMessageBlock readMessageBlock;
@end
