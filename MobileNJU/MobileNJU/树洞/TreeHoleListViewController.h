//
//  TreeHoleListViewController.h
//  MobileNJU
//
//  Created by Stephen Zhuang on 14-5-24.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "RefreshTableViewController.h"

@interface TreeHoleListViewController : RefreshTableViewController<UIAlertViewDelegate , UITableViewDataSource , UITableViewDelegate , UIActionSheetDelegate>
{
    NSInteger selectedIndex;
}
@property (nonatomic , strong) UIView *sectionHeader;
@property (nonatomic , strong) UIButton *messageButton;
@property (nonatomic , strong) MTag *mtag;
@property (nonatomic , weak) IBOutlet UIButton *indexButton;
@property (nonatomic,weak) TreeHoleListViewController* rootVC;
@property (nonatomic)NSInteger level;
- (void)changeToNewest;
@end
