//
//  NanguaViewController.h
//  MobileNJU
//
//  Created by Stephen Zhuang on 14-6-9.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "NanguaBaseViewController.h"

@interface NanguaViewController : NanguaBaseViewController<UITableViewDataSource , UITableViewDelegate>
@property (nonatomic , weak) IBOutlet UITableView *tableView;
@property (nonatomic , strong) NSMutableArray *dataArray;
@end
