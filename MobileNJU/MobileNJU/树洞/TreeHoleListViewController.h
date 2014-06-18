//
//  TreeHoleListViewController.h
//  MobileNJU
//
//  Created by Stephen Zhuang on 14-5-24.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "RefreshTableViewController.h"
#import "TreeHoleListHeader.h"

@interface TreeHoleListViewController : RefreshTableViewController<UIAlertViewDelegate>
@property (nonatomic , assign) BOOL isMyTreeHole;
//@property (nonatomic , weak) IBOutlet UIButton *myTreeHoleButton;
//@property (nonatomic , weak) IBOutlet UIButton *messageButton;
@property (nonatomic , strong) TreeHoleListHeader *treeHoleListHeader;
@end
