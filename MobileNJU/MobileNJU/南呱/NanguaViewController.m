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
    [self setSubTitle:@"和水果聊天"];
    _dataArray = [[NSMutableArray alloc] init];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LeaveMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LeaveMessageCell"];
    MChatIndex *chatIndex = [_dataArray objectAtIndex:indexPath.row];
    [cell.logoImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"fruit_%i" , chatIndex.headImg]]];
    [cell.contentLabel setText:chatIndex.content];
    [cell.timeLabel setText:chatIndex.time];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipLeft:)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [cell addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight:)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [cell addGestureRecognizer:swipeRight];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"chat" sender:indexPath];
}

- (void)swipLeft:(UISwipeGestureRecognizer *)swipe
{
    LeaveMessageCell *cell = (LeaveMessageCell *)swipe.view;
    [cell.contentView bringSubviewToFront:cell.deleteButton];
    [cell.contentView bringSubviewToFront:cell.blackListButton];
//    [UIView animateWithDuration:0.2 animations:^(void) {
//        CGRect rect = cell.logoImage.frame;
//        rect.origin.x = -90;
//        [cell.logoImage setFrame:rect];
//        
//        CGRect rect1 = cell.contentLabel.frame;
//        rect1.origin.x = -29;
//        [cell.contentLabel setFrame:rect1];
//    } completion:^(BOOL isFinished) {
//    }];
    [self performSelector:@selector(doAnimation:) withObject:cell afterDelay:0.2];
}

- (void)doAnimation:(LeaveMessageCell *)cell
{
    [UIView animateWithDuration:0.2 animations:^(void) {
        CGRect rect = cell.logoImage.frame;
        rect.origin.x = -10;
        [cell.logoImage setFrame:rect];
        
        CGRect rect1 = cell.contentLabel.frame;
        rect1.origin.x = 51;
        [cell.contentLabel setFrame:rect1];
    } completion:^(BOOL isFinished) {
    }];
}

- (void)swipeRight:(UISwipeGestureRecognizer *)swipe
{
    LeaveMessageCell *cell = (LeaveMessageCell *)swipe.view;
    [cell.contentView sendSubviewToBack:cell.deleteButton];
    [cell.contentView sendSubviewToBack:cell.blackListButton];
    [UIView animateWithDuration:0.2 animations:^(void) {
        CGRect rect = cell.logoImage.frame;
        rect.origin.x = 10;
        [cell.logoImage setFrame:rect];
        
        CGRect rect1 = cell.contentLabel.frame;
        rect1.origin.x = 71;
        [cell.contentLabel setFrame:rect1];
    } completion:^(BOOL isFinished) {
//        [cell bringSubviewToFront:cell.deleteButton];
//        [cell bringSubviewToFront:cell.blackListButton];
    }];
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
    if ([segue.identifier isEqualToString:@"chat"]) {
        if ([sender isKindOfClass:NSClassFromString(@"UIButton")]) {
            ChatViewController *vc = segue.destinationViewController;
            vc.isFromGua = YES;
        }
    }
}


@end
