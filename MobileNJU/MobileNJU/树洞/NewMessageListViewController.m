//
//  NewMessageListViewController.m
//  MobileNJU
//
//  Created by Stephen Zhuang on 14-6-6.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "NewMessageListViewController.h"
#import "NewMessageCell.h"
#import "TreeHoleDetailViewController.h"
#import "ZsndTreehole.pb.h"
#import "NSString+unicode.h"

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
    [self setTitle:@"树洞的回复"];
    
}

//- (void)loadData
//{
//    NSString *beginStr = @"";
//    if (page == 1) {
//        beginStr = @"";
//    } else {
//        if (self.dataArray.count > 0) {
//            MComment *comment = [self.dataArray lastObject];
//            beginStr = comment.time;
//        }
//        
//    }
//    [[ApisFactory getApiMTreeHoleNews] load:self selecter:@selector(disposMessage:) begin:beginStr];
//}
//
//- (void)disposMessage:(Son *)son
//{
//    if ([son getError] == 0) {
//        if ([[son getMethod] isEqualToString:@"MTreeHoleNews"]) {
//            MNewComments_Builder *commentList = (MNewComments_Builder *)[son getBuild];
//            if (page == 1) {
//                [self.dataArray removeAllObjects];
//            }
//            [self.dataArray addObjectsFromArray:commentList.newsList];
//            if (_readMessageBlock) {
//                _readMessageBlock(self.dataArray.count);
//            }
//        }
//    }
//    if (page == 1) {
//        [self doneWithView:_header];
//    } else {
//        [self doneWithView:_footer];
//    }
//}
//
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    page = 1;
    [self loadData];
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
