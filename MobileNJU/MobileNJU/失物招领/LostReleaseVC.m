//
//  LostReleaseVC.m
//  MobileNJU
//
//  Created by luck-mac on 14-5-31.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "LostReleaseVC.h"
#import "UtilMethods.h"
#import <MobileCoreServices/MobileCoreServices.h>   // kUTTypeImage

@interface LostReleaseVC ()<UITextFieldDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextView *contentArea;
@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (strong,nonatomic)NSMutableArray* photos;
@property (weak, nonatomic) IBOutlet UIButton *addPhotoButton;
@end

@implementation LostReleaseVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initNavigationBar];
    self.titleField.layer.borderWidth=1;
    self.titleField.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.contentArea.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.contentArea.layer.borderWidth=1;
    // Do any additional setup after loading the view.
}

-(void)initNavigationBar
{
    [self setTitle:@"失物招领发布"];
    [self setSubTitle:@"谁捡到我的手机"];
    UIButton* button = [[UIButton alloc]init];
    [button setImage:[UIImage imageNamed:@"提交"] forState:UIControlStateNormal];
    CGRect frame = CGRectMake(0, 0, 53, 28);
    button.frame = frame;
    [button addTarget:self action:@selector(submitInfo) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* releaseItem =  [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = releaseItem;

}
- (NSMutableArray *)photos
{
    if (!_photos) {
        _photos = [[NSMutableArray alloc]init];
    }
    return _photos;
}

//去除输入框键盘相应
- (IBAction)resignAllResponder:(id)sender {
    [self.titleField resignFirstResponder];
    [self.contentArea resignFirstResponder];
}


//调用照相机
- (IBAction)addPhotos:(id)sender {
    UIImagePickerController *uiipc = [[UIImagePickerController alloc] init];
    uiipc.delegate = self;
    uiipc.mediaTypes = @[(NSString *)kUTTypeImage];
    uiipc.sourceType = UIImagePickerControllerSourceTypeCamera|UIImagePickerControllerSourceTypePhotoLibrary;
    uiipc.allowsEditing = YES;
    [self presentViewController:uiipc animated:YES completion:NULL];
}
//点击cancel
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
//获取照片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerEditedImage];
    if (!image) image = info[UIImagePickerControllerOriginalImage];
    [self.photos addObject:image];
    UIImage *scaledImage = [UtilMethods imageWithImageSimple:image scaledToSize:CGSizeMake(70.0, 70.0)];
    [self addImage:scaledImage];
    [self dismissViewControllerAnimated:YES completion:NULL];
}
//添加缩略图。
- (void)addImage:(UIImage*)image
{
    UIImageView* imageView = [[UIImageView alloc]initWithFrame:self.addPhotoButton.frame];
    imageView.image = image;
    [self.view addSubview:imageView];
    
    [self.addPhotoButton removeFromSuperview];
    CGPoint center = self.addPhotoButton.center;
    center.x = center.x+80;
    self.addPhotoButton.center = center;
    [self.view addSubview:self.addPhotoButton];
}

- (void)submitInfo
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -textFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
