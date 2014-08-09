//
//  AddTreeHoleViewController.m
//  MobileNJU
//
//  Created by Stephen Zhuang on 14-6-6.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "AddTreeHoleViewController.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"
#import "ZsndTreehole.pb.h"
#import "TopicCell.h"
#import "AddImageCell.h"
#import "RDVTabBarController.h"
#import "TopicListViewController.h"

@interface AddTreeHoleViewController ()

@end

@implementation AddTreeHoleViewController

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
    
    [self setTitle:@"树洞"];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStyleBordered target:self action:@selector(commitTreeHole)];
    [item setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = item;
    
    _textView.placeholder = @"匿名发表树洞，不超过120字";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.rdv_tabBarController setTabBarHidden:YES];
}

- (void)commitTreeHole
{
    [self.view endEditing:YES];
    [_tableView setContentOffset:CGPointMake(0, 0) animated:YES];
    
    NSString *content = _textView.text;
    
    if (content.length == 0) {
        [ProgressHUD showError:@"内容不能为空"];
        return;
    } else if (content.length > 120) {
        [ProgressHUD showError:@"内容不能超过120字"];
        return;
    }
    MAddTopic_Builder *addTopic = [MAddTopic_Builder new];
    [addTopic setContent:content];
    if (_mtag) {
        [addTopic setTagId:_mtag.id];
    }
    if (_image) {
        [addTopic setImg:UIImagePNGRepresentation(_image)];
    }
    [[[ApisFactory getApiMAddTreeHole] isShowLoad:YES] load:self selecter:@selector(disposMessage:) topic:addTopic];
    
}

- (void)disposMessage:(Son *)son
{
    if ([son getError] == 0) {
        if ([[son getMethod] isEqualToString:@"MAddTreeHole"]) {
            [ProgressHUD showSuccess:@"发布成功"];
            if (_addSuccessBlock) {
                _addSuccessBlock();
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_image) {
        return 2;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 44;
    }
    return 220;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        TopicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TopicCell"];
        if (_mtag) {
            [cell.tipLabel setHidden:YES];
            [cell.topicLabel setHidden:NO];
            [cell.topicLabel setText:[NSString stringWithFormat:@"#%@",_mtag.title]];
        } else {
            [cell.tipLabel setHidden:NO];
            [cell.topicLabel setHidden:YES];
        }
        return cell;
    } else {
        AddImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddImageCell"];
        [cell.backImage setImage:_image];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - 键盘处理
#pragma mark 键盘即将显示
- (void)keyBoardWillShow:(NSNotification *)note{
    
    CGRect rect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat ty = - rect.size.height;
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
        self.bottomView.transform = CGAffineTransformMakeTranslation(0, ty);
    }];
//    rect = _footView.frame;
//    rect.size.height = [UIScreen mainScreen].bounds.size.height - 64 - 44 + ty - 42;
//    [_footView setFrame:rect];
    
}
#pragma mark 键盘即将退出
- (void)keyBoardWillHide:(NSNotification *)note{
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
        self.bottomView.transform = CGAffineTransformIdentity;
    }];
}

- (IBAction)deletePhoto:(id)sender
{
    _image = nil;
    [_bottomView setHidden:NO];
    [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma - mark photo select delegate
- (IBAction)photoBtnAct:(id)sender {
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

- (IBAction)camaraAction:(id)sender
{
    [self.view endEditing:YES];
    UIButton *button = (UIButton *)sender;
    
    NSUInteger sourceType = 0;
    
        
    switch (button.tag) {
        case 0:
        {
            // 判断是否支持相机
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            // 相机
                sourceType = UIImagePickerControllerSourceTypeCamera;
            } else {
                return;
            }
        }
            break;
        case 1:
            // 相册
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
            
        default:
            return;
            break;
    }
    // 跳转到相机或相册页面
    
    _imagePicker = [[GKImagePicker alloc] initWithSourceType:sourceType];
    self.imagePicker.cropSize = CGSizeMake(320, 220);
    self.imagePicker.delegate = self;
    [self presentViewController:_imagePicker.imagePickerController animated:YES completion:nil];
}

#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	[picker dismissViewControllerAnimated:YES completion:^{}];
    
    //    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    image = [self useImage:image];
    
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
        _imagePicker = [[GKImagePicker alloc] initWithSourceType:sourceType];
        self.imagePicker.cropSize = CGSizeMake(320, 220);
        self.imagePicker.delegate = self;
        [self presentViewController:_imagePicker.imagePickerController animated:YES completion:nil];
    }
}

# pragma mark -
# pragma mark GKImagePicker Delegate Methods

- (void)imagePicker:(GKImagePicker *)imagePicker pickedImage:(UIImage *)image{
    _image = [self useImage:image];
    [self.tableView reloadData];
    [self.bottomView setHidden:YES];
    [self hideImagePicker];
}

- (void)hideImagePicker{
    [self.imagePicker.imagePickerController dismissViewControllerAnimated:YES completion:^(void){
        [self.rdv_tabBarController setTabBarHidden:YES];
    }];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (_image) {
        [_tableView setContentOffset:CGPointMake(0, 264) animated:YES];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        [_tableView setContentOffset:CGPointMake(0, 0) animated:YES];
        return NO;
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
    TopicListViewController *vc = segue.destinationViewController;
    vc.selectTagBlock = ^(MTag *tag) {
        self.mtag = tag;
        [self.tableView reloadData];
    };
}


@end
