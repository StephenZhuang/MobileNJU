//
//  ChatViewController.h
//  MobileNJU
//
//  Created by Stephen Zhuang on 14-6-11.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "NanguaBaseViewController.h"
#import "MJRefresh.h"

@interface ChatViewController : BaseViewController<UITableViewDataSource , UITableViewDelegate , UIActionSheetDelegate , UIImagePickerControllerDelegate>
{
    MJRefreshHeaderView *_header;
}
@property (nonatomic , weak) IBOutlet UITableView *tableView;
@property (nonatomic , strong) NSMutableArray *dataArray;
@property (nonatomic , assign) BOOL isFromGua;
@property (nonatomic , weak) IBOutlet UIView *bottomView;
@property (nonatomic , weak) IBOutlet UITextField *messageField;
@property (nonatomic , copy) NSString *targetid;
@property (nonatomic , copy) NSString *topicid;
@property (nonatomic , assign) int targetHead;
@property (nonatomic , assign) int headImg;
@property (nonatomic , strong) UIImage *image;
@end
