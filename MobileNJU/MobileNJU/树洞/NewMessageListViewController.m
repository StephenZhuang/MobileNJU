//
//  NewMessageListViewController.m
//  MobileNJU
//
//  Created by Stephen Zhuang on 14-6-6.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "NewMessageListViewController.h"

#import "TreeHoleDetailViewController.h"
#import "ZsndTreehole.pb.h"
#import "ZsndChat.pb.h"
#import "TreeHoleCell.h"
#import "ChatViewController.h"

@interface NewMessageListViewController ()

@end

@implementation NewMessageListViewController

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
//    [self setTitle:@"树洞的回复"];
    
    _sectionHeader = [[UIView alloc] initWithFrame:CGRectZero];
    selectIndex = 0;
    _commentNumLabel.layer.cornerRadius = 10;
    _messageNumLabel.layer.cornerRadius = 10;
    _topicArray = [[NSMutableArray alloc] init];
    _chatArray = [[NSMutableArray alloc] init];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)loadData
{
    [[ApisFactory getApiMGetMsgCount] load:self selecter:@selector(disposMessage:)];
    if (selectIndex == 0) {
        [[ApisFactory getApiMTreeHoleNewComment] load:self selecter:@selector(disposMessage:)];
    } else {
        [[ApisFactory getApiMChatIndex] load:self selecter:@selector(disposMessage:)];
    }
    
}

- (void)disposMessage:(Son *)son
{
    if ([son getError] == 0) {
        if ([[son getMethod] isEqualToString:@"MGetMsgCount"]) {
            MMsgCount_Builder *msgCount = (MMsgCount_Builder *)[son getBuild];
            [self setNum:_commentNumLabel num:msgCount.comment];
            [self setNum:_messageNumLabel num:msgCount.chat];
        } else if ([[son getMethod] isEqualToString:@"MTreeHoleNewComment"]) {
            MTopicMiniList_Builder *topicList = (MTopicMiniList_Builder *)[son getBuild];
            [_topicArray removeAllObjects];
            [_topicArray addObjectsFromArray:topicList.topicsList];
            [self.tableView reloadData];
            
        } else if ([[son getMethod] isEqualToString:@"MChatIndex"]) {
            MChatList_Builder *chatList = (MChatList_Builder *)[son getBuild];
            [_chatArray removeAllObjects];
            [_chatArray addObjectsFromArray:chatList.chatList];
            [self.tableView reloadData];
        }
    }
}

- (void)setNum:(UILabel *)label num:(int)num
{
    [label setText:[NSString stringWithFormat:@"%i",num]];
    if (num == 0) {
        [label setHidden:YES];
    } else {
        [label setHidden:NO];
    }
}

- (IBAction)changeIndex:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if (!button.selected) {
        [button setSelected:YES];
        [button setBackgroundColor:[UIColor whiteColor]];
        selectIndex = button.tag;
        [self.tableView reloadData];
        [self loadData];
        if (selectIndex == 0) {
            [_messageButton setSelected:NO];
            [_messageButton setBackgroundColor:RGB(238, 238, 238)];
            [_tableView setBackgroundColor:RGB(238, 238, 238)];
        } else {
            [_commentButton setSelected:NO];
            [_commentButton setBackgroundColor:RGB(238, 238, 238)];
            [_tableView setBackgroundColor:[UIColor whiteColor]];
        }
    }
    
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NewMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewMessageCell"];
//    MComment *comment = [self.dataArray objectAtIndex:indexPath.row];
//    [cell.titleLabel setText:comment.title];
//    
//    cell.contentLabel.font = [UIFont systemFontOfSize:14];
//    
//    NSString *fromStr = comment.nickname1;
//    if ([comment.userid1 isEqualToString:comment.author]) {
//        fromStr = @"南大树洞";
//    }
//    
//    NSMutableAttributedString *fromString = [[NSMutableAttributedString alloc] initWithString:fromStr attributes:@{NSForegroundColorAttributeName : RGB(110, 15, 109),   NSFontAttributeName : [UIFont systemFontOfSize:14]}];
//    
////    if (comment.userid2.length > 0) {
//        NSString *toStr = comment.nickname2;
//        if ([comment.userid2 isEqualToString:comment.author] || comment.userid2.length == 0) {
//            toStr = @"南大树洞";
//        }
//        toStr = [toStr stringByAppendingString:@"："];
//        NSMutableAttributedString *replyString = [[NSMutableAttributedString alloc] initWithString:@" 回复 " attributes:@{NSForegroundColorAttributeName : RGB(162, 162, 162),   NSFontAttributeName : [UIFont systemFontOfSize:14]}];
//        NSMutableAttributedString *toString = [[NSMutableAttributedString alloc] initWithString:toStr attributes:@{NSForegroundColorAttributeName : RGB(110, 15, 109),   NSFontAttributeName : [UIFont systemFontOfSize:14]}];
//        
//        [fromString appendAttributedString:replyString];
//        [fromString appendAttributedString:toString];
////    }
//    
//    
//    MatchParser * match=[[MatchParser alloc]init];
//    match.width=290;
//    //    [match match:@"[月亮]开始这是MyFaceAndTextLabel的测试[转圈][发怒][抠鼻]中间这是MyFaceAndTextLabel的测试[傲慢][得意][吐][弱]最后这是MyFaceAndTextLabel的测试[晕][擦汗][月亮]开始这是MyFaceAndTextLabel的测试[转圈][发怒][抠鼻]中间这是MyFaceAndTextLabel的测试[傲慢][得意][吐][弱]最后这是MyFaceAndTextLabel的测试[晕][擦汗" ];
//    [match match:comment.content atCallBack:^BOOL(NSString *string) {
//        return YES;
//    }title:fromString];
//    cell.contentLabel.match=match;
//    return cell;
//}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    page = 1;
//    [self loadData];
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (selectIndex == 0) {
        return self.topicArray.count;
    } else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (selectIndex == 0) {
        return 1;
    } else {
        return self.chatArray.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (selectIndex == 0) {
        return 20;
    } else {
        return 0.01;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (selectIndex == 0) {
        MTopicMini *topic = self.topicArray[indexPath.section];
        return [TreeHoleCell getMessageHeightByTopic:topic];
    } else {
        return 91;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return _sectionHeader;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (selectIndex == 0) {
        MTopicMini *topic = [self.topicArray objectAtIndex:indexPath.section];
        TreeHoleCell *cell = nil;
        if (topic.tag.length > 0) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"TreeHoleCellTopic"];
            [cell.topicButton setTitle:[NSString stringWithFormat:@"#%@",topic.tag] forState:UIControlStateNormal];
        } else {
            cell = [tableView dequeueReusableCellWithIdentifier:@"TreeHoleCell"];
        }
        
        UIColor *color = topic.unreadCnt > 0?[UIColor redColor]:[UIColor grayColor];
        
        NSMutableAttributedString *fromString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%i",topic.unreadCnt] attributes:@{NSForegroundColorAttributeName : color,   NSFontAttributeName : [UIFont systemFontOfSize:17]}];
        
        NSMutableAttributedString *toString = [[NSMutableAttributedString alloc] initWithString:@" 条未读" attributes:@{NSForegroundColorAttributeName : color,   NSFontAttributeName : [UIFont systemFontOfSize:12]}];
        [fromString appendAttributedString:toString];
        [cell.unreadLabel setAttributedText:fromString];
        
        [cell.contentLabel setText:topic.content];
        return cell;
    } else {
        NewMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewMessageCell"];
        [cell setRightUtilityButtons:[self rightButtons] WithButtonWidth:66.0f];
        cell.delegate = self;
        MChatIndex *chat = self.chatArray[indexPath.row];
        [cell.tipView setHidden:chat.hasNew==0];
        [cell.logoImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"logo_default_%i",chat.headImg]]];
        [cell.timeLabel setText:chat.time];
        if (chat.topicImg.length > 0) {
            [cell.topicImage setImageWithURL:[ToolUtils getImageUrlWtihString:chat.topicImg] placeholderImage:[UIImage imageNamed:@""]];
        } else {
            [cell.smallLabel setText:chat.topicContent];
        }
        MatchParser *match = [[MatchParser alloc] init];
        match.width = 152;
        [match match:chat.msg];
        cell.contentLabel.match = match;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (selectIndex == 1) {        
        MChatIndex *chats = [self.chatArray objectAtIndex:indexPath.row];
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Nangua" bundle:nil];
        ChatViewController *vc = [sb instantiateViewControllerWithIdentifier:@"ChatViewController"];
        vc.targetid = chats.targetid;
        vc.topicid = chats.topicid;
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        MTopicMini *topic = [self.topicArray objectAtIndex:indexPath.section];
        TreeHoleDetailViewController *vc = [[self storyboard] instantiateViewControllerWithIdentifier:@"TreeHoleDetailViewController"];
        vc.treeHoleid = topic.id;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (NSArray *)rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0]
                                                title:@"黑名单"];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                                title:@"删除"];
    
    return rightUtilityButtons;
}

#pragma mark - SWTableViewDelegate

- (void)swipeableTableViewCell:(SWTableViewCell *)cell scrollingToState:(SWCellState)state
{
    switch (state) {
        case 0:
            NSLog(@"utility buttons closed");
            break;
        case 1:
            NSLog(@"left utility buttons open");
            break;
        case 2:
            NSLog(@"right utility buttons open");
            break;
        default:
            break;
    }
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index
{
    switch (index) {
        case 0:
            NSLog(@"left button 0 was pressed");
            break;
        case 1:
            NSLog(@"left button 1 was pressed");
            break;
        case 2:
            NSLog(@"left button 2 was pressed");
            break;
        case 3:
            NSLog(@"left btton 3 was pressed");
        default:
            break;
    }
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
    NSIndexPath *cellIndexPath = [self.tableView indexPathForCell:cell];
    MChatIndex *chat = self.chatArray[cellIndexPath.row];
    switch (index) {
        case 0:
        {
            [[ApisFactory getApiMChatBlack] load:self selecter:@selector(disposMessage:) viewid:chat.id];
            [_chatArray removeObjectAtIndex:cellIndexPath.row];
            [self.tableView deleteRowsAtIndexPaths:@[cellIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
            break;
        }
        case 1:
        {
            // Delete button was pressed
            [[ApisFactory getApiMChatDel] load:self selecter:@selector(disposMessage:) viewid:chat.id];
            [_chatArray removeObjectAtIndex:cellIndexPath.row];
            [self.tableView deleteRowsAtIndexPaths:@[cellIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
            break;
        }
        default:
            break;
    }
}

- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell
{
    // allow just one cell's utility button to be open at once
    return YES;
}

- (BOOL)swipeableTableViewCell:(SWTableViewCell *)cell canSwipeToState:(SWCellState)state
{
    switch (state) {
        case 1:
            // set to NO to disable all left utility buttons appearing
            return NO;
            break;
        case 2:
            // set to NO to disable all right utility buttons appearing
        {
            NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
            if (indexPath.row == 0) {
                return NO;
            }
            
        }
            return YES;
            break;
        default:
            break;
    }
    
    return YES;
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
    NewMessageCell *cell = sender;
    TreeHoleDetailViewController *vc = [segue destinationViewController];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
//    vc.treeHoleid = [[self.dataArray objectAtIndex:indexPath.row] pid];
}


@end
