//
//  TreeHoleListViewController.h
//  MobileNJU
//
//  Created by Stephen Zhuang on 14-5-24.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "RefreshTableViewController.h"

@interface TreeHoleListViewController : RefreshTableViewController
@property (nonatomic , assign) BOOL isMyTreeHole;
@property (nonatomic , weak) IBOutlet UIButton *myTreeHoleButton;
@property (nonatomic , weak) IBOutlet UIButton *messageButton;
@end
