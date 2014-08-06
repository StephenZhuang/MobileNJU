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
    [self setTitle:@"树洞"];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStyleBordered target:self action:@selector(commitTreeHole)];
    [item setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = item;
    
    _textView.placeholder = @"匿名发表树洞，不超过120字";
}

- (void)commitTreeHole
{
//    [self.view endEditing:YES];
//    NSString *title = [_titleTextField text];
//    NSString *content = [_contentTextView text];
//    if (title.length == 0) {
//        [ProgressHUD showError:@"标题不能为空"];
//        return;
//    } else if (title.length > 20) {
//        [ProgressHUD showError:@"标题不能超过20字"];
//        return;
//    }
//    
//    if (content.length == 0) {
//        [ProgressHUD showError:@"内容不能为空"];
//        return;
//    } else if (content.length > 500) {
//        [ProgressHUD showError:@"内容不能超过500字"];
//        return;
//    }
//    MAddTopic_Builder *addTopic = [MAddTopic_Builder new];
//    [addTopic setTitle:title];
//    [addTopic setContent:content];
//    for (UIImage *image in _photoArray) {
//        [addTopic addImgs:UIImagePNGRepresentation(image)];
//    }
//    
//    UpdateOne *updateone=[[UpdateOne alloc] init:@"MAddTreeHole" params:addTopic  delegate:self selecter:@selector(disposMessage:)];
//    [DataManager loadData:[[NSArray alloc] initWithObjects:updateone, nil] delegate:self];
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
        return cell;
    } else {
        AddImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddImageCell"];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
//    self.imgView.image = image;
    [self hideImagePicker];
}

- (void)hideImagePicker{
    [self.imagePicker.imagePickerController dismissViewControllerAnimated:YES completion:nil];
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
