//
//  NanguaViewController.m
//  MobileNJU
//
//  Created by Stephen Zhuang on 14-6-9.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "NanguaViewController.h"
#import "LeaveMessageCell.h"
#import "ChatViewController.h"
#import "ZsndChat.pb.h"

@interface NanguaViewController ()

@end

@implementation NanguaViewController

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
    [self setTitle:@"南呱"];
    _dataArray = [[NSMutableArray alloc] init];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[ApisFactory getApiMChatIndex] load:self selecter:@selector(disposMessage:)];
}

- (IBAction)goToCheck:(id)sender
{
    [self performSegueWithIdentifier:@"chat" sender:sender];
}

- (void)disposMessage:(Son *)son
{
    if ([son getError] == 0) {
        if ([[son getMethod] isEqualToString:@"MChatIndex"]) {
            MChatList_Builder *chatList = (MChatList_Builder *)[son getBuild];
            [_dataArray removeAllObjects];
            [_dataArray addObjectsFromArray:chatList.chatList];
            [_tableView reloadData];
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    LeaveMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LeaveMessageCell"];
//    MChatIndex *chatIndex = [_dataArray objectAtIndex:indexPath.row];
//    [cell.logoImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"fruit_%i" , chatIndex.headImg]]];
////    [cell.contentLabel setText:chatIndex.content];
//    MatchParser *match = [[MatchParser alloc] init];
//    match.width = cell.contentLabel.frame.size.width;
//    match.numberOfLimitLines = 1;
//    match.font = [UIFont systemFontOfSize:17];
//    [match match:chatIndex.content];
//    cell.contentLabel.match = match;
//    [cell.timeLabel setText:chatIndex.time];
//    cell.blackListButton.tag = indexPath.row;
//    cell.deleteButton.tag = indexPath.row;
//    
//    if (chatIndex.total > 0) {
//        [cell.hasMessgeView setHidden:NO];
//    } else {
//        [cell.hasMessgeView setHidden:YES];
//    }
//    
//    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipLeft:)];
//    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
//    [cell addGestureRecognizer:swipeLeft];
//    
//    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight:)];
//    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
//    [cell addGestureRecognizer:swipeRight];
//    return cell;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [self performSegueWithIdentifier:@"chat" sender:indexPath];
//}
//
//- (void)swipLeft:(UISwipeGestureRecognizer *)swipe
//{
//    LeaveMessageCell *cell = (LeaveMessageCell *)swipe.view;
//    [cell.contentView bringSubviewToFront:cell.deleteButton];
//    [cell.contentView bringSubviewToFront:cell.blackListButton];
////    [UIView animateWithDuration:0.2 animations:^(void) {
////        CGRect rect = cell.logoImage.frame;
////        rect.origin.x = -90;
////        [cell.logoImage setFrame:rect];
////        
////        CGRect rect1 = cell.contentLabel.frame;
////        rect1.origin.x = -29;
////        [cell.contentLabel setFrame:rect1];
////    } completion:^(BOOL isFinished) {
////    }];
//    [self performSelector:@selector(doAnimation:) withObject:cell afterDelay:0.2];
//}
//
//- (void)doAnimation:(LeaveMessageCell *)cell
//{
//    [UIView animateWithDuration:0.2 animations:^(void) {
//        CGRect rect = cell.logoImage.frame;
//        rect.origin.x = -10;
//        [cell.logoImage setFrame:rect];
//        
//        rect = cell.hasMessgeView.frame;
//        rect.origin.x = 39;
//        [cell.hasMessgeView setFrame:rect];
//        
//        CGRect rect1 = cell.contentLabel.frame;
//        rect1.origin.x = 51;
//        [cell.contentLabel setFrame:rect1];
//    } completion:^(BOOL isFinished) {
//    }];
//}
//
//- (void)swipeRight:(UISwipeGestureRecognizer *)swipe
//{
//    LeaveMessageCell *cell = (LeaveMessageCell *)swipe.view;
//    [cell.contentView sendSubviewToBack:cell.deleteButton];
//    [cell.contentView sendSubviewToBack:cell.blackListButton];
//    [UIView animateWithDuration:0.2 animations:^(void) {
//        CGRect rect = cell.logoImage.frame;
//        rect.origin.x = 10;
//        [cell.logoImage setFrame:rect];
//        
//        rect = cell.hasMessgeView.frame;
//        rect.origin.x = 59;
//        [cell.hasMessgeView setFrame:rect];
//        
//        CGRect rect1 = cell.contentLabel.frame;
//        rect1.origin.x = 71;
//        [cell.contentLabel setFrame:rect1];
//    } completion:^(BOOL isFinished) {
////        [cell bringSubviewToFront:cell.deleteButton];
////        [cell bringSubviewToFront:cell.blackListButton];
//    }];
//}
//
//- (IBAction)blackListAction:(id)sender
//{
//    UIButton *button = (UIButton *)sender;
//    MChatIndex *chatIndex = [_dataArray objectAtIndex:button.tag];
//    [[ApisFactory getApiMChatBlack] load:self selecter:@selector(disposMessage:) id:chatIndex.targetid];
//    [self.dataArray removeObjectAtIndex:button.tag];
//    [self.tableView reloadData];
//}
//
//- (IBAction)deleteAction:(id)sender
//{
//    UIButton *button = (UIButton *)sender;
//    MChatIndex *chatIndex = [_dataArray objectAtIndex:button.tag];
//    [[ApisFactory getApiMChatDel] load:self selecter:@selector(disposMessage:) id:chatIndex.targetid];
//    [self.dataArray removeObjectAtIndex:button.tag];
//    [self.tableView reloadData];
//}

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
    if ([segue.identifier isEqualToString:@"chat"]) {
        if ([sender isKindOfClass:NSClassFromString(@"UIButton")]) {
            ChatViewController *vc = segue.destinationViewController;
            vc.isFromGua = YES;
        } else {
            ChatViewController *vc = segue.destinationViewController;
            NSIndexPath *indexPath = sender;
            MChatIndex *chatIndex = [self.dataArray objectAtIndex:indexPath.row];
            vc.targetid = chatIndex.targetid;
        }
    }
}


@end
