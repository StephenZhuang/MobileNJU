//
//  FirstPage.m
//  MobileNJU
//
//  Created by luck-mac on 14-7-30.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "FirstPage.h"

@implementation FirstPage
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
#pragma mark -初始化
- (void)initial
{
    self.titleField.delegate = self;
    self.priceFIeld.delegate = self;
    self.originPriceField.delegate = self;
    self.discriptionField.delegate = self;
    self.photoArray = [[NSMutableArray alloc]init];
    self.buttonArray = [[NSMutableArray alloc]init];
    
    [self.takePhotoBt addTarget:self action:@selector(takePhoto) forControlEvents:UIControlEventTouchUpInside];
    self.font = self.titleLabel.font;
    for (int i = 0 ; i < 5; i++) {
        UIButton* button = [[UIButton alloc]initWithFrame:CGRectMake(7.5+i*51+i*10, 7.5, 51, 51)];
        [button setImage:[UIImage imageNamed:i==4?@"10-发布-已选照片-删除":@"10-发布-已选照片-添加"] forState:UIControlStateNormal];
        [button setTag:i+200];
        [self.photoArea addSubview:button];
        [self.buttonArray addObject:button];
        [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    [self.photoArea setHidden:YES];
}

#pragma textFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self returnLabel:textField];
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height);
    self.frame = rect;
    [UIView commitAnimations];
    [textField resignFirstResponder];
    if (textField==self.titleField) {
        [self.priceFIeld becomeFirstResponder];
    } else if (textField==self.priceFIeld)
    {
        [self.originPriceField becomeFirstResponder];
    } else if (textField==self.originPriceField)
    {
        [self.discriptionField becomeFirstResponder];
    }
    return YES;
}

-(void) returnLabel:(id)textField
{
    if (textField==nil) {
        return;
    }
    UILabel *label;
    if (textField==self.titleField) {
        label = self.titleLabel;
    } else if (textField==self.priceFIeld)
    {
        label = self.priceLabel;
    } else if (textField==self.originPriceField)
    {
        label = self.originPriceLabel;
    } else if (textField==self.discriptionField)
    {
        label = self.discLabel;
    }
    if (((UITextField*)textField).text.length>0) {
    } else {
        [self.discLabel2 setHidden:NO];
        [UIView animateWithDuration:0.2f animations:^{
            [label setFont:self.font];
            [label setTextColor:self.discLabel2.textColor];
            label.transform = CGAffineTransformMakeTranslation(0, 0);
        }];
        
    }

}

-(void) changeLabel:(id)textField
{
    UILabel *label;
    if (textField==self.titleField) {
        label = self.titleLabel;
    } else if (textField==self.priceFIeld)
    {
        label = self.priceLabel;
    } else if (textField==self.originPriceField)
    {
        label = self.originPriceLabel;
    } else if (textField==self.discriptionField)
    {
        [self.discLabel2 setHidden:YES];
        label = self.discLabel;
    }
    [UIView animateWithDuration:0.2f animations:^{
        [label setTextColor:[UIColor purpleColor]];
        [label setFont:[UIFont fontWithName:@"Helvetica" size:10.0]];
        label.transform = CGAffineTransformMakeTranslation(0, -10);
    }];
    self.lastField = textField;
}


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [self returnLabel:self.lastField];
    [self changeLabel:textView];
    CGFloat height_off = 500 ;
    CGRect frame = textView.frame;
    if (
    [[UIScreen mainScreen] bounds].size.height >= 568.0f && [[UIScreen mainScreen] bounds].size.height < 1024.0f
        ){
        height_off = 600;
    }
    
        
    int offset = frame.origin.y + height_off - (self.frame.size.height - 240);//键盘高度216
    NSLog(@"offset is %d",offset);
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.frame.size.width;
    float height = self.frame.size.height;
    if(offset > 0)
    {
        CGRect rect = CGRectMake(0.0f, -offset,width,height);
        self.frame = rect;
    }
    [UIView commitAnimations];
    return YES;
}
//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
//{
//    
//    if ([text isEqualToString:@"\n"]) {
//        [self returnLabel:textView];
//        NSTimeInterval animationDuration = 0.30f;
//        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
//        [UIView setAnimationDuration:animationDuration];
//        CGRect rect = CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height);
//        self.frame = rect;
//        [UIView commitAnimations];
//        [textView resignFirstResponder];
//        return NO;
//    }
//    
//    return YES;
//}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self returnLabel:self.lastField];
    [self changeLabel:textField];
    CGRect frame = textField.frame;
    int offset = frame.origin.y +440 - (self.frame.size.height - 240);//键盘高度216
    NSLog(@"offset is %d",offset);
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.frame.size.width;
    float height = self.frame.size.height;
    if(offset > 0)
    {
        CGRect rect = CGRectMake(0.0f, -offset,width,height);
        self.frame = rect;
    }
    [UIView commitAnimations];
    return YES;
}


#pragma mark -拍照
- (void)takePhoto
{
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
    [sheet setDelegate:self];
    [sheet showInView:[UIApplication sharedApplication].keyWindow];

}

- (void)clickButton:(UIButton*) sender
{
    if (sender.tag==204) {
        [self.photoArray removeLastObject];
        
        [[self.buttonArray objectAtIndex:self.photoArray.count]setImage:[UIImage imageNamed:@"10-发布-已选照片-添加"] forState:UIControlStateNormal];
        UIButton* button = [self.buttonArray objectAtIndex:self.photoArray.count ];
        [button setTag:self.photoArray.count+200];
        
    } else if (sender.tag>=200){
        [self takePhoto];
    }
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
	[picker dismissViewControllerAnimated:YES completion:^{}];
    
    //    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    image = [self useImage:image];
    [self.photoArray addObject:image];
    if (_photoArray.count <= 4) {
        [[self.buttonArray objectAtIndex:_photoArray.count-1] setImage:[self OriginImage:image scaleToSize:CGSizeMake(51, 51)] forState:UIControlStateNormal];
        UIButton* button = [self.buttonArray objectAtIndex:_photoArray.count-1];
        button.tag = _photoArray.count;
        if (self.photoArray.count==1) {
            [self.takePhotoBt setHidden:YES];
        }
    }
    [self.photoArea setHidden:NO];
}

-(UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;   //返回的就是已经改变的图片
}

- (UIImage *)useImage:(UIImage *)image {
    //    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    // Create a graphics image context
    CGSize newSize = CGSizeMake(640, 640);
    //    [pool release];
    return [self OriginImage:image scaleToSize:newSize];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	[picker dismissViewControllerAnimated:YES completion:^{}];
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
                    NSLog(@"相机");
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
        
        
        [self.myDelegate showView:imagePickerController];
//        [self presentViewController:imagePickerController animated:YES completion:^{}];
        
        //        [imagePickerController release];
        
        //        [[NSNotificationCenter defaultCenter] postNotificationName:@"HidePhotoTabbar" object:nil];
    }
    
}
- (void)resignAll
{
    float width = self.frame.size.width;
    float height = self.frame.size.height;
    CGRect rect = CGRectMake(0.0f,0,width,height);
    self.frame = rect;
    [self.lastField resignFirstResponder];
    [self returnLabel:self.lastField];

}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==self.priceFIeld||textField==self.originPriceField) {
        if (range.location >=4)
            return NO; // return NO to not change text
        return YES;
    }
    if (textField==self.titleField)
    {
        if(range.location>=20)
            return NO;
        return YES;
    }
    return YES;
}

- (IBAction)resignAll:(id)sender {
    }


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
