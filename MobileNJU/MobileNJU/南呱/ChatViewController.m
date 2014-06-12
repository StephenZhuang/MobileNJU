//
//  ChatViewController.m
//  MobileNJU
//
//  Created by Stephen Zhuang on 14-6-11.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "ChatViewController.h"
#import "ZsndUser.pb.h"
#import "ConnectViewController.h"
#import "EmojiViewController.h"
#import "ZsndChat.pb.h"
#import "HBTalkTableViewCell.h"
#import "HBTalkTableViewImageLeftCell.h"
#import "HBTalkTableViewImageRightCell.h"
#import "HBTalkTableViewTextLeftCell.h"
#import "HBTalkTableViewTextRightCell.h"

@interface ChatViewController ()

@end

@implementation ChatViewController

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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [self setTitle:@"南呱"];
    [self setSubTitle:@"和水果聊天"];
    _dataArray = [[NSMutableArray alloc] init];
    
    if (_isFromGua) {
        ConnectViewController *vc = [[self storyboard] instantiateViewControllerWithIdentifier:@"ConnectViewController"];
        [self addChildViewController:vc];
        [self.view addSubview:vc.view];
    } else {
        [self addCall];
        [self addHeader];
    }
}

- (void)addHeader
{
    
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = self.tableView;
    header.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        // 进入刷新状态就会回调这个Block
        [self loadData];
        
        NSLog(@"%@----开始进入刷新状态", refreshView.class);
    };
    header.endStateChangeBlock = ^(MJRefreshBaseView *refreshView) {
        // 刷新完毕就会回调这个Block
        NSLog(@"%@----刷新完毕", refreshView.class);
    };
    header.refreshStateChangeBlock = ^(MJRefreshBaseView *refreshView, MJRefreshState state) {
        // 控件的刷新状态切换了就会调用这个block
        switch (state) {
            case MJRefreshStateNormal:
                NSLog(@"%@----切换到：普通状态", refreshView.class);
                break;
                
            case MJRefreshStatePulling:
                NSLog(@"%@----切换到：松开即可刷新的状态", refreshView.class);
                break;
                
            case MJRefreshStateRefreshing:
                NSLog(@"%@----切换到：正在刷新状态", refreshView.class);
                break;
            default:
                break;
        }
    };
    [header beginRefreshing];
    _header = header;
    [_header.arrowImage setAlpha:0];
    [_header.statusLabel setHidden:YES];
    [_header.lastUpdateTimeLabel setHidden:YES];
}

- (void)doneWithView:(MJRefreshBaseView *)refreshView
{
    // 刷新表格
    [self.tableView reloadData];
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [refreshView endRefreshing];
    
}

- (void)loadData
{
    NSString *beginStr = @"";

    if (self.dataArray.count > 0) {
        MChat *chat = [self.dataArray firstObject];
        beginStr = chat.createtime;
    }
    
    [[ApisFactory getApiMChat] load:self selecter:@selector(disposMessage:) id:_targetid begin:beginStr];
}

- (void)addCall
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, 45, 30)];
    [button setTitle:@"呼叫" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(callAction:) forControlEvents:UIControlEventTouchUpInside];
    button.layer.borderColor = [UIColor blackColor].CGColor;
    button.layer.borderWidth = 1;
    button.layer.cornerRadius = 5;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)callAction:(id)sender
{
    
}

- (void)addChangge
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, 45, 30)];
    [button setTitle:@"换人" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(callAction:) forControlEvents:UIControlEventTouchUpInside];
    button.layer.borderColor = [UIColor blackColor].CGColor;
    button.layer.borderWidth = 1;
    button.layer.cornerRadius = 5;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)changeAction:(id)sender
{
    
}

- (void)disposMessage:(Son *)son
{
    if ([son getError] == 0) {
        if ([[son getMethod] isEqualToString:@"MChat"]) {
            MChats_Builder *chats = (MChats_Builder *)[son getBuild];
            for (int i = 0; i < chats.chatList.count; i++) {
                MChat *chat = [chats.chatList objectAtIndex:i];
                [_dataArray insertObject:chat atIndex:0];
                _targetHead = chats.headImg;
                _headImg = [ToolUtils getHeadImg];
            }
        }
    }
    if ([[son getMethod] isEqualToString:@"MChat"]) {
        [self doneWithView:_header];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MChat *data=[self.dataArray objectAtIndex:indexPath.row];
    return  [HBTalkTableViewCell getHeightByContent:data];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MChat *data = [self.dataArray objectAtIndex:indexPath.row];
    if (data.img.length > 0) {
        return [self getImageCell:tableView data:data];
    } else {
        return [self getTextCell:tableView data:data];
    }
    return nil;
}

-(UITableViewCell*) getTextCell:(UITableView*)tableView  data:(MChat*)data
{
    HBTalkTableViewCell * cell=nil;
    if(![data.userid isEqualToString:_targetid]){
        cell=[tableView dequeueReusableCellWithIdentifier:@"textRightCell"];
        if(cell==nil)
            cell=[[HBTalkTableViewTextRightCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"textRightCell"];
        
    }else{
        cell=[tableView dequeueReusableCellWithIdentifier:@"textLeftCell"];
        if(cell==nil)
            cell=[[HBTalkTableViewTextLeftCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"textLeftCell"];
    }
    cell.talkData=data;
    if ([data.userid isEqualToString:_targetid]) {
        [cell setLogoImageWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"fruit_%i_s" ,_targetHead]]];
    } else {
        [cell setLogoImage:_headImg];
    }
    [cell setContent];
    return cell;
    
}
-(UITableViewCell*) getImageCell:(UITableView*)tableView  data:(MChat*)data
{
    HBTalkTableViewCell * cell=nil;
    if(![data.userid isEqualToString:_targetid]){
        cell=[tableView dequeueReusableCellWithIdentifier:@"imageRightCell"];
        if(cell==nil)
            cell=[[HBTalkTableViewImageRightCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"imageRightCell"];
        
    }else{
        cell=[tableView dequeueReusableCellWithIdentifier:@"imageLeftCell"];
        if(cell==nil)
            cell=[[HBTalkTableViewImageLeftCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"imageLeftCell"];
    }
    cell.talkData=data;
    if ([data.userid isEqualToString:_targetid]) {
        [cell setLogoImageWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"fruit_%i_s" ,_targetHead]]];
    } else {
        [cell setLogoImage:_headImg];
    }
    [cell setContent];
    return cell;
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
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"TreeHole" bundle:nil];
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
    if (string.length > 100) {
        [_messageField resignFirstResponder];
        [ProgressHUD showError:@"不能超过100字"];
        return;
    }
    if (string.length > 0) {
        MChat_Builder *chat = [MChat_Builder new];
        [chat setUserid:[ToolUtils getLoginId]];
        [chat setContent:string];
        [chat setImg:@""];
        [self.dataArray addObject:chat.build];
        [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:self.dataArray.count - 1 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        [[ApisFactory getApiMAddChat] load:self selecter:@selector(disposMessage:) id:_targetid content:string];
    }
    [_messageField resignFirstResponder];
    [_messageField setText:@""];

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
