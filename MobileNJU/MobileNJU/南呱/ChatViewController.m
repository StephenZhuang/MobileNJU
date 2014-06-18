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
#import "ZsndSystem.pb.h"

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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getNewMessage:) name:@"getNanguaMessage" object:nil];
    _dataArray = [[NSMutableArray alloc] init];
    
    if (_isFromGua) {
        [self addConnect];
    } else {
        [self setTitle:@"聊天"];
        [self setSubTitle:@"西瓜和猕猴桃的故事"];
        [self addCall];
        [self addHeader];
    }
}

- (void)addConnect
{
    [self setTitle:@"南呱"];
    [self setSubTitle:@"和水果聊天"];
    ConnectViewController *vc = [[self storyboard] instantiateViewControllerWithIdentifier:@"ConnectViewController"];
    vc.matchSuccessBlock = ^(NSString *targetid , int targethead ,NSString *headImg) {
        [self setTitle:@"聊天"];
        [self setSubTitle:@"西瓜和猕猴桃的故事"];
        _targetid = targetid;
        _targetHead = targethead;
        _headImg = headImg;
        [self addChangge];
        
        for (int i = 0; i < 2; i++) {
            MChat_Builder *chat = [MChat_Builder new];
            if (i == 0) {
                [chat setUserid:_targetid];
            } else {
                [chat setUserid:[ToolUtils getLoginId]];
            }
            [chat setContent:@"Hi~"];
            [chat setImg:@""];
            NSDate *date = [NSDate new];
            NSDateFormatter *dateFomatter = [[NSDateFormatter alloc] init];
            [dateFomatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSString *time = [dateFomatter stringFromDate:date];
            [chat setCreatetime:time];
            
            [self.dataArray addObject:chat.build];
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:self.dataArray.count - 1 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataArray.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
    };
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
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

- (void)getNewMessage:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    if ([[userInfo objectForKey:@"target"] isEqualToString:_targetid]) {
        [[ApisFactory getApiMChatMsg] load:self selecter:@selector(disposMessage:) id:[userInfo objectForKey:@"id"]];
    }
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
    [[ApisFactory getApiMChatCall] load:self selecter:@selector(disposMessage:) id:_targetid];
}

- (void)addChangge
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, 45, 30)];
    [button setTitle:@"换人" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventTouchUpInside];
    button.layer.borderColor = [UIColor blackColor].CGColor;
    button.layer.borderWidth = 1;
    button.layer.cornerRadius = 5;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)changeAction:(id)sender
{
    self.navigationItem.rightBarButtonItem = nil;
    _targetid = @"";
    [self.dataArray removeAllObjects];
    [self.tableView reloadData];
    
    
//    [UIView transitionFromView:self.view
//                        toView:self.view
//                      duration:1
//                       options: UIViewAnimationOptionTransitionFlipFromRight
//                    completion:^(BOOL finished) {
//                        if (finished) {
//                            
//                        }
//                    }];
    [self addConnect];
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
        } else if ([[son getMethod] isEqualToString:@"MAddChat"]){
            if ([[son getParam:@"content"] length] <= 0) {
                MChat_Builder *chat = (MChat_Builder *)[son getBuild];
                
//                MChat_Builder *chat = [MChat_Builder new];
//                [chat setUserid:[ToolUtils getLoginId]];
//                [chat setContent:@""];
//                [chat setImg:ret.msg];
                [self.dataArray addObject:chat.build];
                [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:self.dataArray.count - 1 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
                [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataArray.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            }
        } else if ([[son getMethod] isEqualToString:@"MChatMsg"]){
            MChat_Builder *chat = (MChat_Builder *)[son getBuild];
            [self.dataArray addObject:chat.build];
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:self.dataArray.count - 1 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataArray.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
    }
    if ([[son getMethod] isEqualToString:@"MChat"]) {
        [self doneWithView:_header];
        if (self.dataArray.count > 0) {
            if ([[son getParam:@"begin"] isEqualToString:@""]) {
                [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataArray.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            } else {
                MChats_Builder *chats = (MChats_Builder *)[son getBuild];
                if (self.dataArray.count > chats.chatList.count) {
                    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:chats.chatList.count inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
                }
            }
        }
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
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
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
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataArray.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        
        [[ApisFactory getApiMAddChat] load:self selecter:@selector(disposMessage:) id:_targetid content:string];
    }
    [_messageField resignFirstResponder];
    [_messageField setText:@""];

}

- (IBAction)addImageAction:(id)sender
{
    [_messageField resignFirstResponder];
    UIActionSheet *sheet;
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        sheet  = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
    }
    else {
        
        sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择", nil];
    }
    
    sheet.tag = 255;
    
    [sheet showInView:[UIApplication sharedApplication].keyWindow];
}

#pragma mark - 保存图片至沙盒
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    //    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    NSData *imageData = UIImagePNGRepresentation(currentImage);
    // 获取沙盒目录
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    
    // 将图片写入文件
    
    [imageData writeToFile:fullPath atomically:NO];
}

#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //    [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowPhotoTabbar" object:nil];
	[picker dismissViewControllerAnimated:YES completion:^{}];
    
    //    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    _image = [info objectForKey:UIImagePickerControllerOriginalImage];
    _image = [self useImage:_image];
    
    [self uploadImg];
    //    [_userInfoView.logoButton setBackgroundImage:image forState:UIControlStateNormal];
    //    [self updateHeadImg];
}

- (void)uploadImg
{
    MImg_Builder *img = [MImg_Builder new];
    [img setImg:UIImagePNGRepresentation(_image)];
    
    UpdateOne *updateone=[[UpdateOne alloc] init:@"MAddChat" params:img  delegate:self selecter:@selector(disposMessage:)];
    [updateone addParam:@"id" value:_targetid];
    [updateone addParam:@"content" value:@""];
    [updateone setShowLoading:YES];
    [DataManager loadData:[[NSArray alloc] initWithObjects:updateone, nil] delegate:self];
}

- (UIImage *)useImage:(UIImage *)image {
    //    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    // Create a graphics image context
    CGSize newSize = CGSizeMake(640, 640 * image.size.height / image.size.width);
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    
    //    [pool release];
    return newImage;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    //    [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowPhotoTabbar" object:nil];
	[self dismissViewControllerAnimated:YES completion:^{}];
}

#pragma mark - actionsheet delegate
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255) {
        
        NSUInteger sourceType = 0;
        
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            switch (buttonIndex) {
                case 0:
                    // 相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 1:
                    // 相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
                    
                case 2:
                    // 取消
                    return;
                    break;
                default:
                    return;
                    break;
            }
        }
        else {
            if (buttonIndex == 0) {
                
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            } else {
                return;
            }
        }
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        imagePickerController.delegate = self;
        
        imagePickerController.allowsEditing = NO;
        
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:^{}];
        
        //        [imagePickerController release];
        
        //        [[NSNotificationCenter defaultCenter] postNotificationName:@"HidePhotoTabbar" object:nil];
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
