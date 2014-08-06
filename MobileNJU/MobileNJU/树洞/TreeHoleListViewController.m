//
//  TreeHoleListViewController.m
//  MobileNJU
//
//  Created by Stephen Zhuang on 14-5-24.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "TreeHoleListViewController.h"
#import "TreeHoleCell.h"
#import "ZsndTreehole.pb.h"
#import "ZsndIndex.pb.h"
#import "AddTreeHoleViewController.h"
#import "TreeHoleDetailViewController.h"
#import "NewMessageListViewController.h"

@interface TreeHoleListViewController ()

@end

@implementation TreeHoleListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"树洞"];
    
    _sectionHeader = [[UIView alloc] initWithFrame:CGRectZero];
    
    UIBarButtonItem *releaseItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"bt_treehole_add"] style:UIBarButtonItemStyleBordered target:self action:@selector(goToAdd)];
    [releaseItem setTintColor:[UIColor whiteColor]];
    
    _messageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_messageButton setTitle:@"99" forState:UIControlStateNormal];
    [_messageButton setFrame:CGRectMake(0, 0, 30, 22)];
    [_messageButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:_messageButton];
    
    UIBarButtonItem *mesageitem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"bt_treehole_reply"] style:UIBarButtonItemStyleBordered target:nil action:nil];
    [item setTintColor:[UIColor whiteColor]];
    
    self.navigationItem.rightBarButtonItems = @[releaseItem ,item , mesageitem];
}

- (void)goToAdd
{
    [self performSegueWithIdentifier:@"add" sender:nil];
}

//- (void)loadData
//{
//    NSString *beginStr = @"";
//    if (page == 1) {
//        beginStr = @"";
//    } else {
//        if (self.dataArray.count > 0) {
//            MTopic *topic = [self.dataArray lastObject];
//            beginStr = topic.createTime;
//        }
//        
//    }
//    [[ApisFactory getApiMTreeHoleList] load:self selecter:@selector(disposMessage:) type:_isMyTreeHole?1:0 begin:beginStr];
//}

- (void)disposMessage:(Son *)son
{
    if ([son getError] == 0) {
        if ([[son getMethod] isEqualToString:@"MTreeHoleList"]) {
            MTreeHole_Builder *treeHole = (MTreeHole_Builder *)[son getBuild];
            if (page == 1) {
                [self.dataArray removeAllObjects];
            }
            [self.dataArray addObjectsFromArray:treeHole.topicsList];
        }
    }
    if ([[son getMethod] isEqualToString:@"MTreeHoleList"]) {
        if (page == 1) {
            [self doneWithView:_header];
        } else {
            [self doneWithView:_footer];
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return _sectionHeader;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    TreeHoleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TreeHoleCell"];
//    MTopic *topic = [self.dataArray objectAtIndex:indexPath.row];
//    [cell.contentLabel setText:topic.content];
//    
//    NSMutableArray *array = [[NSMutableArray alloc] init];
//    if (topic.imgs.length > 0) {
//        NSArray *imgStrArr = [topic.imgs componentsSeparatedByString:@","];
//        
//        for (NSString *str in imgStrArr) {
//            [array addObject:[ToolUtils getImageUrlWtihString:str].absoluteString];
//        }
//    }
//    [cell setImageArray:array];
//    return CGRectGetMaxY(cell.commentButton.frame) + 10;
//    return [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 1.0f;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TreeHoleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TreeHoleCell"];
    
//    MTopic *topic = [self.dataArray objectAtIndex:indexPath.row];
//    [cell.titleLabel setText:topic.title];
//    [cell.contentLabel setText:topic.content];
//    [cell.timeLabel setText:topic.time];
//    [cell.zanButton setTag:indexPath.row];
//    [cell.commentButton setTag:indexPath.row];
//    [cell.deleteButton setTag:indexPath.row];
//    [cell.zanButton setTitle:[NSString stringWithFormat:@"%i" , topic.praiseCnt] forState:UIControlStateNormal];
//    [cell.commentButton setTitle:[NSString stringWithFormat:@"%i" , topic.commentCnt] forState:UIControlStateNormal];
//    
//    NSMutableArray *array = [[NSMutableArray alloc] init];
//    if (topic.imgs.length > 0) {
//        NSArray *imgStrArr = [topic.imgs componentsSeparatedByString:@","];
//        
//        for (NSString *str in imgStrArr) {
//            [array addObject:[ToolUtils getImageUrlWtihString:str].absoluteString];
//        }
//    }
//    [cell setImageArray:array];
//    if (_isMyTreeHole) {
//        [cell.deleteButton setHidden:NO];
//    } else {
//        [cell.deleteButton setHidden:YES];
//    }
    return cell;
}

- (IBAction)zanAction:(id)sender
{
    UIButton *button = (UIButton *)sender;
    MTopic *topic = [self.dataArray objectAtIndex:button.tag];
    MTopic_Builder *newTopic = [MTopic_Builder new];
    //0:没赞 1：已赞
    if (topic.hasPraise == 0) {
        [button setTitle:[NSString stringWithFormat:@"%d" , topic.praiseCnt + 1] forState:UIControlStateNormal];
        [newTopic setPraiseCnt:topic.praiseCnt +1];
        [newTopic setHasPraise:1];
        
    } else {
        [button setTitle:[NSString stringWithFormat:@"%d" , topic.praiseCnt - 1] forState:UIControlStateNormal];
        [newTopic setPraiseCnt:topic.praiseCnt - 1];
        [newTopic setHasPraise:0];
    }
    [newTopic setCommentCnt:topic.commentCnt];
    [newTopic setId:topic.id];
//    [newTopic setTitle:topic.title];
    [newTopic setContent:topic.content];
    [newTopic setTime:topic.time];
//    [newTopic setImgs:topic.imgs];
    [newTopic setCreateTime:topic.createTime];
    [newTopic setAuthor:topic.author];
    
    [self.dataArray replaceObjectAtIndex:button.tag withObject:newTopic.build];
//    [self.tableView reloadData];
    [[ApisFactory getApiMPraise] load:self selecter:@selector(disposMessage:) id:topic.id type:topic.hasPraise == 0?1:2];
}

- (IBAction)deleteAction:(id)sender
{
    UIButton *button = (UIButton *)sender;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确定删除吗" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"删除", nil];
    alert.tag = button.tag;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        
    } else {
        MTopic *topic = [self.dataArray objectAtIndex:alertView.tag];
        [self.dataArray removeObjectAtIndex:alertView.tag];
//        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:alertView.tag inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView reloadData];
        [[ApisFactory getApiMTreeHoleDel] load:self selecter:@selector(disposMessage:) id:topic.id];
    }
}

- (IBAction)newMessageAction:(id)sender
{
    [self performSegueWithIdentifier:@"NewMessage" sender:sender];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"myTreeHole"]) {
        TreeHoleListViewController *vc = [segue destinationViewController];
    } else if ([segue.identifier isEqualToString:@"add"]) {
        AddTreeHoleViewController *vc = [segue destinationViewController];
        vc.addSuccessBlock = ^() {
            page = 1;
            [self loadData];
        };
    } else if ([segue.identifier isEqualToString:@"detail"] || [segue.identifier isEqualToString:@"detail1"]) {
        TreeHoleDetailViewController *vc = [segue destinationViewController];
        if ([sender isKindOfClass:NSClassFromString(@"UIButton")]) {
            UIButton *button = sender;
            vc.treeHoleid = [[self.dataArray objectAtIndex:button.tag] id];
        } else {
            TreeHoleCell *cell = sender;
            NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
            vc.treeHoleid = [[self.dataArray objectAtIndex:indexPath.row] id];
        }
    } else if ([segue.identifier isEqualToString:@"NewMessage"]) {
        NewMessageListViewController *vc = [segue destinationViewController];
//        vc.readMessageBlock = ^(NSInteger num) {
//            [_treeHoleListHeader.messageButton setTitle:[NSString stringWithFormat:@"%i" , num] forState:UIControlStateNormal];
//            [_treeHoleListHeader setMessageButtonHidden:(num <=0)];
//        };
    }
}


@end
