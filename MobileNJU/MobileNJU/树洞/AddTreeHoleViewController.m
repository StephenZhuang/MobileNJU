//
//  AddTreeHoleViewController.m
//  MobileNJU
//
//  Created by Stephen Zhuang on 14-6-6.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "AddTreeHoleViewController.h"
#import "TreeHoleImageCell.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"
#import "ZsndTreehole.pb.h"

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
    [self setTitle:@"发布树洞"];
    [self setSubTitle:@"吐槽您的生活"];
    
    UIButton* button = [[UIButton alloc]init];
    [button setImage:[UIImage imageNamed:@"提交"] forState:UIControlStateNormal];
    CGRect frame = CGRectMake(0, 0, 53, 28);
    button.frame = frame;
    [button addTarget:self action:@selector(commitTreeHole) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* releaseItem =  [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = releaseItem;
    
    _photoArray = [[NSMutableArray alloc] init];
    self.titleTextField.layer.borderWidth=1;
    self.titleTextField.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.contentTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.contentTextView.layer.borderWidth=1;
}

- (void)commitTreeHole
{
    NSString *title = [_titleTextField text];
    NSString *content = [_contentTextView text];
    if (title.length == 0) {
        [ProgressHUD showError:@"标题不能为空"];
        return;
    } else if (title.length > 20) {
        [ProgressHUD showError:@"标题不能超过20字"];
        return;
    }
    
    if (content.length == 0) {
        [ProgressHUD showError:@"内容不能为空"];
        return;
    } else if (content.length > 500) {
        [ProgressHUD showError:@"内容不能超过500字"];
        return;
    }
    MAddTopic_Builder *addTopic = [MAddTopic_Builder new];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (_photoArray.count < 4) {
        return _photoArray.count + 1;
    }
    return _photoArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TreeHoleImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TreeHoleImageCell" forIndexPath:indexPath];
    cell.contentImage.layer.contentsGravity = kCAGravityResizeAspectFill;
    if (indexPath.row == _photoArray.count) {
        [cell.contentImage setImage:[UIImage imageNamed:@"添加图片"]];
        [cell.contentImage setUserInteractionEnabled:NO];
    } else {
        [cell.contentImage setImage:[_photoArray objectAtIndex:indexPath.row]];
        [cell.contentImage setUserInteractionEnabled:YES];
        cell.contentImage.tag = indexPath.row;
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(showDelete:)];
        [cell.contentImage addGestureRecognizer:longPress];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == _photoArray.count) {
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
    } else {
        int count = _photoArray.count;
        // 1.封装图片数据
        NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
        for (int i = 0; i<count; i++) {
            // 替换为中等尺寸图片
            UIImage *image = [_photoArray objectAtIndex:i];
//            NSString *url = [imageUrl stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
//            NSString * encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)url, NULL, NULL,  kCFStringEncodingUTF8 ));
            MJPhoto *photo = [[MJPhoto alloc] init];
//            photo.url = [NSURL URLWithString:encodedString]; // 图片路径
            photo.image = image;
            
            TreeHoleImageCell *cell = (TreeHoleImageCell *)[collectionView cellForItemAtIndexPath:indexPath];
            photo.srcImageView = cell.contentImage; // 来源于哪个UIImageView
            //        photo.description = [NSString stringWithFormat:@"========%i" , i];
            [photos addObject:photo];
        }
        
        // 2.显示相册
        MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
        browser.currentPhotoIndex = indexPath.row; // 弹出相册时显示的第一张图片是？
        browser.photos = photos; // 设置所有的图片
        [browser show];
    }
}

- (void)showDelete:(UILongPressGestureRecognizer *)longPress
{
    if (longPress.state == UIGestureRecognizerStateBegan) {        
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除" otherButtonTitles:nil, nil];
        actionSheet.tag = longPress.view.tag;
        [actionSheet showInView:self.view];
    }
}

#pragma - mark photo select delegate
//- (IBAction)photoBtnAct:(id)sender {
//    UIActionSheet *sheet;
//    // 判断是否支持相机
//    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
//    {
//        sheet  = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
//    }
//    else {
//        
//        sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择", nil];
//    }
//    
//    sheet.tag = 255;
//    
//    [sheet showInView:[UIApplication sharedApplication].keyWindow];
//}

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
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    image = [self useImage:image];
    
    [_photoArray addObject:image];
    if (_photoArray.count < 4) {
        [_photoCollectionView insertItemsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForItem:_photoArray.count - 1 inSection:0]]];
    } else {
        [_photoCollectionView reloadData];
//        [_photoCollectionView deleteItemsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForItem:_photoArray.count - 1 inSection:0]]];
    }
//    [_userInfoView.logoButton setBackgroundImage:image forState:UIControlStateNormal];
//    [self updateHeadImg];
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
        
        imagePickerController.allowsEditing = YES;
        
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:^{}];
        
        //        [imagePickerController release];
        
        //        [[NSNotificationCenter defaultCenter] postNotificationName:@"HidePhotoTabbar" object:nil];
    } else {
        switch (buttonIndex) {
            case 0:
                // 删除
            {
                [_photoArray removeObjectAtIndex:actionSheet.tag];
//                if (_photoArray.count == 3) {
                    [_photoCollectionView reloadData];
//                } else {
//                    [_photoCollectionView deleteItemsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForItem:actionSheet.tag inSection:0]]];
//                }
                [actionSheet dismissWithClickedButtonIndex:buttonIndex animated:YES];
            }
                
                break;
            default:
                break;
        }
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
