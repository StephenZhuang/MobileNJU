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
#import <Frontia/Frontia.h>
#import "ChatViewController.h"

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
    _replyfloor = 0;
    [_textView setPlaceholder:@"评论不能超过120字！"];
    [_textView setPlaceholderColor:RGB(147, 147, 147)];
    
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
            if ([_topic.author isEqualToString:[ToolUtils getLoginId]]) {
                [_lzButton setHidden:NO];
            } else {
                [_lzButton setHidden:YES];
            }
            [self.tableView reloadData];
        } else if ([[son getMethod] isEqualToString:@"MTreeHoleComment"]) {
            page = 1;
            [self loadData];
            [self showFlower];
        } else if ([[son getMethod] isEqualToString:@"MTreeHoleComments"]) {
            MCommentList_Builder *commentList = (MCommentList_Builder *)[son getBuild];
            if (page == 1) {
                [self.dataArray removeAllObjects];
            }
            [self.dataArray addObjectsFromArray:commentList.commentsList];
        } else if ([[son getMethod] isEqualToString:@"MTreeHoleReport"]) {
            [ProgressHUD showSuccess:@"举报成功"];
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

    MComment *comment = [self.dataArray objectAtIndex:indexPath.row];
    return [CommentCell getHeightByComment:comment];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        TreeHoleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TreeHoleCell"];
        if (_topic) {            
            [cell.contentLabel setText:_topic.content];
            [cell.logoImage setImageWithURL:[ToolUtils getImageUrlWtihString:_topic.img] placeholderImage:[UIImage imageNamed:@""]];
//            cell.logoImage.layer.contentsGravity = kCAGravityCenter;
            [cell.zanButton setTag:indexPath.section];
            [cell.commentButton setTag:indexPath.section];
            [cell.moreButton setTag:indexPath.section];
            [cell.messageButton setTag:indexPath.section];
            [cell.zanButton setTitle:[NSString stringWithFormat:@"%i" , _topic.praiseCnt] forState:UIControlStateNormal];
            [cell.zanButton setTitle:[NSString stringWithFormat:@"%i" , _topic.praiseCnt] forState:UIControlStateSelected];
            [cell.zanButton setSelected:_topic.hasPraise ==1];
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
        
        if (comment.isLz == 1) {
            if (comment.replyid.length > 0) {
                [cell.replyLabel setText:[NSString stringWithFormat:@"楼主 回复%d楼",comment.replyFloor]];
            } else {
                [cell.replyLabel setText:[NSString stringWithFormat:@"楼主"]];
            }
            [cell.replyLabel setTextColor:RGB(168, 16, 166)];
            [cell.contentLabel setTextColor:RGB(168, 16, 166)];
        } else {
            if (comment.replyid.length > 0) {
                [cell.replyLabel setText:[NSString stringWithFormat:@"回复%d楼",comment.replyFloor]];
            }
            [cell.replyLabel setTextColor:RGB(164, 164, 164)];
            [cell.contentLabel setTextColor:RGB(82, 82, 82)];
        }
        
        [cell.floorLabel setBackgroundColor:_colorArray[indexPath.row % _colorArray.count]];
        [cell.floorLabel setText:[NSString stringWithFormat:@"%i",indexPath.row+1]];
        
        [cell.contentLabel setText:comment.content];
        [cell.timeLabel setText:comment.time];
        [cell.messageButton setTag:indexPath.row];
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
//    _targetid = @"";
//    _commentid = @"";
//    _cometName = @"";
//    [_messageField setPlaceholder:@""];
}

#pragma mark - 键盘处理
#pragma mark 键盘即将显示
- (void)keyBoardWillShow:(NSNotification *)note{
    
    CGRect rect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat ty = - rect.size.height - _editView.frame.size.height;
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
        self.editView.transform = CGAffineTransformMakeTranslation(0, ty);
    }];
    [self.textView becomeFirstResponder];
    
}
#pragma mark 键盘即将退出
- (void)keyBoardWillHide:(NSNotification *)note{
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
        self.editView.transform = CGAffineTransformIdentity;
    }];
    [self removeMask];
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

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self addMask];
    _targetid = @"";
    _replyfloor = 0;
    [_textView setPlaceholder:@"评论不得超过120字"];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self sendAction:nil];
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [self sendAction:nil];
//        [textView resignFirstResponder];
    }
    return YES;
}

- (IBAction)sendAction:(id)sender
{
    NSString *string = _textView.text;
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (string.length > 120) {
        [_textView resignFirstResponder];
        [ProgressHUD showError:@"回复不能超过120字"];
        return;
    }
    if (string.length > 0) {
//        MComment_Builder *comment = [MComment_Builder new];
//        comment 
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
        int isLz=1;
        if (_lzButton.isHidden) {
            isLz=0;
        } else {
            if (_lzButton.isSelected) {
                isLz=0;
            } else {
                isLz=1;
            }
        }
        [[ApisFactory getApiMTreeHoleComment] load:self selecter:@selector(disposMessage:) id:_treeHoleid content:string reply:_targetid floor:_replyfloor islz:isLz];
    }
    [_textView resignFirstResponder];
    [_textView setText:@""];
    _targetid = @"";
    [_textView setPlaceholder:@"评论不得超过120字"];
}

- (IBAction)zanAction:(id)sender
{
    UIButton *button = (UIButton *)sender;
    //0:没赞 1：已赞
    if (_topic.hasPraise == 0) {
        [button setTitle:[NSString stringWithFormat:@"%d" , _topic.praiseCnt + 1] forState:UIControlStateNormal];
        [_topic setPraiseCnt:_topic.praiseCnt +1];
        [_topic setHasPraise:1];
        [self showFlower];

    } else {
        [button setTitle:[NSString stringWithFormat:@"%d" , _topic.praiseCnt - 1] forState:UIControlStateNormal];
        [_topic setPraiseCnt:_topic.praiseCnt - 1];
        [_topic setHasPraise:0];
    }
    [self.tableView reloadData];
    [[ApisFactory getApiMPraise] load:self selecter:@selector(disposMessage:) id:_topic.id type:_topic.hasPraise == 0?2:1];
}

- (IBAction)commentAction:(id)sender
{
    [self.messageField becomeFirstResponder];
}

- (IBAction)messageAction:(id)sender
{
    if ([_topic.author isEqualToString:[ToolUtils getLoginId]]) {
        return;
    }
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Nangua" bundle:nil];
    ChatViewController *vc = [sb instantiateViewControllerWithIdentifier:@"ChatViewController"];
    vc.targetid = _topic.author;
    vc.topicid = _topic.id;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)replyAction:(id)sender
{
    [self addMask];
    UIButton *button = (UIButton *)sender;
    MComment *comment = self.dataArray[button.tag];
    _replyfloor = comment.floor;
    _targetid = comment.userid;
    [_textView setPlaceholder:[NSString stringWithFormat:@"回复%d楼",comment.floor]];
    [self.textView becomeFirstResponder];
}

- (IBAction)moreAction:(id)sender
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"分享",@"举报", nil];
    [sheet showInView:[UIApplication sharedApplication].keyWindow];
}

- (IBAction)changeLz:(id)sender
{
    [self.lzButton setSelected:!self.lzButton.selected];
}

- (void)addMask
{
//    if (!self.maskView) {
        self.maskView = [[UIView alloc] initWithFrame:self.view.bounds];
        [self.maskView setAlpha:0.8];
        [self.maskView setBackgroundColor:[UIColor blackColor]];
    self.maskView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelEdit)];
    [self.maskView addGestureRecognizer:tap];
//    }
    [self.view addSubview:self.maskView];
    [self.view bringSubviewToFront:self.editView];
}

- (void)cancelEdit
{
    [self.view endEditing:YES];
}

- (void)showFlower
{
    [_flowerView setAlpha:0];
    [_flowerView setHidden:NO];
    
    [UIView animateWithDuration:0.2 animations:^(void) {
        [_flowerView setAlpha:1];
        _flowerView.transform = CGAffineTransformMakeTranslation(0, -50);
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_flowerView setHidden:YES];
        _flowerView.transform = CGAffineTransformIdentity;
    });
}

#pragma mark-
#pragma mark- action sheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            FrontiaShare *share = [Frontia getShare];
            
            //授权取消回调函数
            FrontiaShareCancelCallback onCancel = ^(){
                NSLog(@"OnCancel: share is cancelled");
            };
            
            //授权失败回调函数
            FrontiaShareFailureCallback onFailure = ^(int errorCode, NSString *errorMessage){
                NSLog(@"OnFailure: %d  %@", errorCode, errorMessage);
                [ProgressHUD showError:@"分享失败"];
            };
            
            //授权成功回调函数
            FrontiaMultiShareResultCallback onResult = ^(NSDictionary *respones){
                NSLog(@"OnResult: %@", [respones description]);
                [ProgressHUD showSuccess:@"分享成功"];
            };
            
            FrontiaShareContent *content=[[FrontiaShareContent alloc] init];
            //    content.url = ShareUrl;
            NSString *contentUrl = @"http://www.s1.smartjiangsu.com";
            content.url = contentUrl;
            if (_topic.tag.length > 0) {
                content.title = _topic.tag;
            } else {
                content.title = _topic.content;
            }
            content.description = _topic.content;
            content.imageObj = [ToolUtils getImageUrlWtihString:_topic.img].absoluteString;
            
            NSArray *platforms = @[FRONTIA_SOCIAL_SHARE_PLATFORM_WEIXIN_SESSION,FRONTIA_SOCIAL_SHARE_PLATFORM_WEIXIN_TIMELINE,FRONTIA_SOCIAL_SHARE_PLATFORM_QQFRIEND,FRONTIA_SOCIAL_SHARE_PLATFORM_QQ,FRONTIA_SOCIAL_SHARE_PLATFORM_RENREN];
            [share registerQQAppId:@"100358052" enableSSO:YES];
            [share registerWeixinAppId:@"wx0f170ef160f8fe0c"];
//            [share registerSinaweiboAppId:@"306527345"];

            [share showShareMenuWithShareContent:content displayPlatforms:platforms supportedInterfaceOrientations:UIInterfaceOrientationMaskPortrait isStatusBarHidden:NO targetViewForPad:nil cancelListener:onCancel failureListener:onFailure resultListener:onResult];
        }
            break;
        case 1:
        {
            [[ApisFactory getApiMTreeHoleReport] load:self selecter:@selector(disposMessage:) id:_topic.id];
        }
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


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
