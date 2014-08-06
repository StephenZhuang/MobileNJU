//
//  TreeHoleDetailViewController.m
//  MobileNJU
//
//  Created by Stephen Zhuang on 14-5-29.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "TreeHoleDetailViewController.h"
#import "TreeHoleCell.h"
#import "CommentCell.h"
#import "EmojiViewController.h"
#import "NSString+unicode.h"
#import "ProgressHUD.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"

@interface TreeHoleDetailViewController ()

@end

@implementation TreeHoleDetailViewController

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
    [self setTitle:@"详情"];
    _targetid = @"";
    _commentid = @"";
    _cometName = @"";
    _imageArray = [[NSMutableArray alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    _colorArray = @[RGB(227, 122, 250),RGB(255, 98, 250),RGB(255, 169, 165),RGB(255, 202, 133),RGB(255, 205, 30),RGB(75, 168, 255),RGB(143, 128, 255),RGB(0, 196, 231),RGB(118, 233, 188),RGB(156, 216, 123),RGB(216, 216, 216)];
}

- (void)loadData
{
    NSString *beginStr = @"";
    if (page == 1) {
        [[ApisFactory getApiMTreeHole] load:self selecter:@selector(disposMessage:) id:_treeHoleid];
        beginStr = @"";
    } else {
        if (self.dataArray.count > 0) {
            MComment *topic = [self.dataArray lastObject];
            beginStr = topic.createTime;
        }
        
    }
    [[ApisFactory getApiMTreeHoleComments] load:self selecter:@selector(disposMessage:) id:_treeHoleid begin:beginStr];
}

//- (void)addFooter
//{
//    
//}

- (void)disposMessage:(Son *)son
{
    if ([son getError] == 0) {
        if ([[son getMethod] isEqualToString:@"MTreeHole"]) {
            _topic = (MTopic_Builder *)[son getBuild];
            
            [self.tableView reloadData];
        } else if ([[son getMethod] isEqualToString:@"MTreeHoleComment"]) {
//            [self loadData];
        } else if ([[son getMethod] isEqualToString:@"MTreeHoleComments"]) {
            MCommentList_Builder *commentList = (MCommentList_Builder *)[son getBuild];
            if (page == 1) {
                [self.dataArray removeAllObjects];
            }
            [self.dataArray addObjectsFromArray:commentList.commentsList];
        }
    }
    if ([[son getMethod] isEqualToString:@"MTreeHoleComments"]) {
        if (page == 1) {
            [self doneWithView:_header];
        } else {
            [self doneWithView:_footer];
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 || section == 1) {
        return 1;
    } else {
        return self.dataArray.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return [TreeHoleCell getDetailHeightByTopic:_topic];
    } else if (indexPath.section == 1) {
            return 38;
    }
//    } else {
//        CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
        MComment *comment = [self.dataArray objectAtIndex:indexPath.row];
//        return [cell matchContent:comment author:_topic.author] + 10;
//    }
    return [CommentCell getHeightByComment:comment];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        TreeHoleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TreeHoleCell"];
        if (_topic) {            
            [cell.contentLabel setText:_topic.content];
            [cell.logoImage setImageWithURL:[ToolUtils getImageUrlWtihString:_topic.img] placeholderImage:[UIImage imageNamed:@""]];
            [cell.zanButton setTag:indexPath.section];
            [cell.commentButton setTag:indexPath.section];
            [cell.moreButton setTag:indexPath.section];
            [cell.messageButton setTag:indexPath.section];
            [cell.zanButton setTitle:[NSString stringWithFormat:@"%i" , _topic.praiseCnt] forState:UIControlStateNormal];
            [cell.commentButton setTitle:[NSString stringWithFormat:@"%i" , _topic.commentCnt] forState:UIControlStateNormal];
        }
        return cell;
    } else if (indexPath.section == 1){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Header"];
        return cell;
    } else {
        CommentCell *cell = nil;
        MComment *comment = [self.dataArray objectAtIndex:indexPath.row];
        if (comment.replyid.length > 0 || comment.isLz == 1) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCellReply"];
        } else {
            cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
        }
        [cell.floorLabel setBackgroundColor:_colorArray[indexPath.row % _colorArray.count]];
        [cell.floorLabel setText:[NSString stringWithFormat:@"%i",indexPath.row+1]];
        
        [cell.contentLabel setText:comment.content];
        [cell.timeLabel setText:comment.createTime];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    MComment *comment = [self.dataArray objectAtIndex:indexPath.row];
//    if (![comment.userid1 isEqualToString:[ToolUtils getLoginId]]) {
//        if (![comment.userid1 isEqualToString:_topic.author]) {                
//            _targetid = comment.userid1;
//            _commentid = comment.id;
//            _cometName = comment.nickname1;
//            
//            [_messageField setPlaceholder:[NSString stringWithFormat:@"回复 %@：" , comment.nickname1]];
//        }
//        [_messageField becomeFirstResponder];
//    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _targetid = @"";
    _commentid = @"";
    _cometName = @"";
    [_messageField setPlaceholder:@""];
}

#pragma mark - 键盘处理
#pragma mark 键盘即将显示
- (void)keyBoardWillShow:(NSNotification *)note{
    
    CGRect rect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat ty = - rect.size.height;
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, ty);
    }];
    
}
#pragma mark 键盘即将退出
- (void)keyBoardWillHide:(NSNotification *)note{
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
        self.view.transform = CGAffineTransformIdentity;
    }];
}

- (IBAction)emojiAction:(id)sender
{
//    [_messageField resignFirstResponder];
    UIStoryboard *storyboard = [self storyboard];
    EmojiViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"EmojiViewController"];
    vc.emojiBlock = ^(NSString *string) {
        _messageField.text = [_messageField.text stringByAppendingString:[NSString stringWithFormat:@"%@" , string]];
    };
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.navigationController presentViewController:nav animated:YES completion:^(){
        
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self sendAction:nil];
    return YES;
}

- (IBAction)sendAction:(id)sender
{
    NSString *string = _messageField.text;
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (string.length > 100) {
        [_messageField resignFirstResponder];
        [ProgressHUD showError:@"回复不能超过100字"];
        return;
    }
//    if (string.length > 0) {
//        MComment_Builder *comment = [MComment_Builder new];
//        [comment setUserid1:[ToolUtils getLoginId]];
//        [comment setNickname1:[ToolUtils getNickName]];
//        [comment setUserid2:_commentid];
//        [comment setNickname2:_cometName];
//        [comment setContent:string];
//        [comment setAuthor:_topic.author];
//        
//        [self.dataArray addObject:comment.build];
//        [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:self.dataArray.count - 1 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
//        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataArray.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
//        
//        [_topic setCommentCnt:_topic.commentCnt + 1];
//        [_detailView.commentButton setTitle:[NSString stringWithFormat:@"%i",_topic.commentCnt] forState:UIControlStateNormal];
//        [[ApisFactory getApiMTreeHoleComment] load:self selecter:@selector(disposMessage:) id:_topic.id content:string reply:_targetid commentid:_commentid];
//    }
    [_messageField resignFirstResponder];
    [_messageField setText:@""];
    _targetid = @"";
    _commentid = @"";
    _cometName = @"";
    [_messageField setPlaceholder:@""];
}

- (IBAction)zanAction:(id)sender
{
    UIButton *button = (UIButton *)sender;
    //0:没赞 1：已赞
    if (_topic.hasPraise == 0) {
        [button setTitle:[NSString stringWithFormat:@"%d" , _topic.praiseCnt + 1] forState:UIControlStateNormal];
        [_topic setPraiseCnt:_topic.praiseCnt +1];
        [_topic setHasPraise:1];

    } else {
        [button setTitle:[NSString stringWithFormat:@"%d" , _topic.praiseCnt - 1] forState:UIControlStateNormal];
        [_topic setPraiseCnt:_topic.praiseCnt - 1];
        [_topic setHasPraise:0];
    }
    //    [self.tableView reloadData];
    [[ApisFactory getApiMPraise] load:self selecter:@selector(disposMessage:) id:_topic.id type:_topic.hasPraise == 0?2:1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma - mark collectionview delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (_imageArray) {
        return _imageArray.count;
    }
    return 0;
}

//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    TreeHoleImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TreeHoleImageCell" forIndexPath:indexPath];
//    
//    NSString *imageUrl = [_imageArray objectAtIndex:indexPath.row];
//    [cell.contentImage setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@""]];
//    cell.contentImage.layer.contentsGravity = kCAGravityResizeAspectFill;
//    
//    return cell;
//}
//
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSInteger count = _imageArray.count;
//    // 1.封装图片数据
//    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
//    for (int i = 0; i<count; i++) {
//        // 替换为中等尺寸图片
//        NSString *imageUrl = [_imageArray objectAtIndex:i];
//        NSString *url = [imageUrl stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
//        NSString * encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)url, NULL, NULL,  kCFStringEncodingUTF8 ));
//        MJPhoto *photo = [[MJPhoto alloc] init];
//        photo.url = [NSURL URLWithString:encodedString]; // 图片路径
//        
//        TreeHoleImageCell *cell = (TreeHoleImageCell *)[collectionView cellForItemAtIndexPath:indexPath];
//        photo.srcImageView = cell.contentImage; // 来源于哪个UIImageView
//        //        photo.description = [NSString stringWithFormat:@"========%i" , i];
//        [photos addObject:photo];
//    }
//    
//    // 2.显示相册
//    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
//    browser.currentPhotoIndex = indexPath.row; // 弹出相册时显示的第一张图片是？
//    browser.photos = photos; // 设置所有的图片
//    [browser show];
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
