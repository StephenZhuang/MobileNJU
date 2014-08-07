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
#import "ChatViewController.h"

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
    if (_mtag) {
        [self setTitle:_mtag.title];
        self.tableView.tableHeaderView = nil;
    } else {
        [self setTitle:@"树洞"];
    }
    
    _sectionHeader = [[UIView alloc] initWithFrame:CGRectZero];
    
    UIBarButtonItem *releaseItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"bt_treehole_add"] style:UIBarButtonItemStyleBordered target:self action:@selector(goToAdd)];
    [releaseItem setTintColor:[UIColor whiteColor]];
    
    _messageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_messageButton setTitle:@"99" forState:UIControlStateNormal];
    [_messageButton setImage:[UIImage imageNamed:@"bt_treehole_reply"] forState:UIControlStateNormal];
    [_messageButton setFrame:CGRectMake(0, 0, 52, 22)];
    [_messageButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [_messageButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 6, 0, 0)];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:_messageButton];
    
    self.navigationItem.rightBarButtonItems = @[releaseItem ,item];
    
    [[ApisFactory getApiMGetTags] load:self selecter:@selector(disposMessage:)];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[ApisFactory getApiMGetMsgCount] load:self selecter:@selector(disposMessage:)];
}

- (void)goToAdd
{
    [self performSegueWithIdentifier:@"add" sender:nil];
}

- (void)loadData
{
    NSString *beginStr = @"";
    double type = 1;
    if (page == 1) {
        beginStr = @"";
        type = 1;
    } else {
        if (self.dataArray.count > 0) {
            MTopic *topic = [self.dataArray lastObject];
            beginStr = topic.createTime;
        }
        type = 2;
        
    }
    if (_mtag) {
        if ([_mtag.id isEqualToString:@"热门"]) {
            [[ApisFactory getApiMTreeHoleQuery] load:self selecter:@selector(disposMessage:) type:2];
        } else if ([_mtag.id isEqualToString:@"推荐"]) {
            [[ApisFactory getApiMTreeHoleQuery] load:self selecter:@selector(disposMessage:) type:2];
        } else {
            [[ApisFactory getApiMTagTreeHole] load:self selecter:@selector(disposMessage:) tagid:_mtag.id begin:beginStr];
        }
    } else {
        [[ApisFactory getApiMTreeHoleList] load:self selecter:@selector(disposMessage:) type:type begin:beginStr];
    }
}

- (void)addFooter
{
    if (_mtag) {
        if ([_mtag.id isEqualToString:@"热门"]) {

        } else if ([_mtag.id isEqualToString:@"推荐"]) {

        } else {
            [super addFooter];
        }
    } else {
        [super addFooter];
    }
}

- (void)disposMessage:(Son *)son
{
    if ([son getError] == 0) {
        if ([[son getMethod] isEqualToString:@"MTreeHoleList"] || [[son getMethod] isEqualToString:@"MTagTreeHole"] || [[son getMethod] isEqualToString:@"MTreeHoleQuery"]) {
            MTreeHole_Builder *treeHole = (MTreeHole_Builder *)[son getBuild];
            if (page == 1) {
                [self.dataArray removeAllObjects];
            }
            [self.dataArray addObjectsFromArray:treeHole.topicsList];
        } else if ([[son getMethod] isEqualToString:@"MGetMsgCount"]) {
            MMsgCount_Builder *msgCountBuilder = (MMsgCount_Builder *)[son getBuild];
            [_messageButton setTitle:[NSString stringWithFormat:@"%d",msgCountBuilder.comment + msgCountBuilder.chat] forState:UIControlStateNormal];
        } else if ([[son getMethod] isEqualToString:@"MGetTags"]) {
            NSMutableArray *tagArray = [[NSMutableArray alloc] init];
            MTagList_Builder *tagsList = (MTagList_Builder *)[son getBuild];
            [tagArray addObjectsFromArray:tagsList.tagsList];
            [ToolUtils sharedToolUtils].tagArray = tagArray;
            
            
            for (int i = 0; i < 3; i++) {
                UIButton *button = (UIButton *)[self.tableView viewWithTag:i+100];
                MTag *tag = tagArray[i];
                [button setTitle:[NSString stringWithFormat:@"#%@",tag.title] forState:UIControlStateNormal];
                
            }
        }
    }
    if ([[son getMethod] isEqualToString:@"MTreeHoleList"] || [[son getMethod] isEqualToString:@"MTagTreeHole"] || [[son getMethod] isEqualToString:@"MTreeHoleQuery"]) {
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
    MTopic *topic = [self.dataArray objectAtIndex:indexPath.section];
    return [TreeHoleCell getHeightByTopic:topic];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MTopic *topic = [self.dataArray objectAtIndex:indexPath.section];
    TreeHoleCell *cell = nil;
    if (topic.tag.length > 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"TreeHoleCellTopic"];
        [cell.topicButton setTitle:[NSString stringWithFormat:@"#%@",topic.tag] forState:UIControlStateNormal];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"TreeHoleCell"];
    }
    
    [cell.contentLabel setText:topic.content];
    [cell.logoImage setImageWithURL:[ToolUtils getImageUrlWtihString:topic.img] placeholderImage:[UIImage imageNamed:@""]];
    [cell.zanButton setTag:indexPath.section];
    [cell.commentButton setTag:indexPath.section];
    [cell.moreButton setTag:indexPath.section];
    [cell.messageButton setTag:indexPath.section];
    [cell.topicButton setTag:indexPath.section];
    [cell.zanButton setTitle:[NSString stringWithFormat:@"%i" , topic.praiseCnt] forState:UIControlStateNormal];
    [cell.commentButton setTitle:[NSString stringWithFormat:@"%i" , topic.commentCnt] forState:UIControlStateNormal];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MTopic *topic = [self.dataArray objectAtIndex:indexPath.section];
    TreeHoleDetailViewController *vc = [[self storyboard] instantiateViewControllerWithIdentifier:@"TreeHoleDetailViewController"];
    vc.treeHoleid = topic.id;
    [self.navigationController pushViewController:vc animated:YES];
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

- (IBAction)messageAction:(id)sender
{
    UIButton *button = (UIButton *)sender;
    MTopic *topic = self.dataArray[button.tag];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Nangua" bundle:nil];
    ChatViewController *vc = [sb instantiateViewControllerWithIdentifier:@"ChatViewController"];
    vc.targetid = topic.author;
    vc.topicid = topic.id;
    [self.navigationController pushViewController:vc animated:YES];
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

- (IBAction)tagAction:(id)sender
{
    UIButton *button = (UIButton *)sender;
    MTag *tag = [[ToolUtils sharedToolUtils].tagArray objectAtIndex:button.tag-100];
    TreeHoleListViewController *vc = [[self storyboard] instantiateInitialViewController];
    vc.mtag = tag;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)cellTagAction:(id)sender
{
    UIButton *button = (UIButton *)sender;
    MTopic *topic = self.dataArray[button.tag];
    MTag_Builder *tag = [MTag_Builder new];
    [tag setTitle:topic.tag];
    [tag setId:topic.tagid];
    TreeHoleListViewController *vc = [[self storyboard] instantiateInitialViewController];
    vc.mtag = tag.build;
    [self.navigationController pushViewController:vc animated:YES];
    
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
        if (_mtag) {
            if ([_mtag.id isEqualToString:@"热门"]) {
                
            } else if ([_mtag.id isEqualToString:@"推荐"]) {
                
            } else {
                vc.mtag = _mtag;
            }
        }
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
