//
//  HBTalkTableViewImageRightCell.m
//  MyTest
//
//  Created by weqia on 13-8-11.
//  Copyright (c) 2013年 weqia. All rights reserved.
//

#import "HBTalkTableViewImageRightCell.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"
@implementation HBTalkTableViewImageRightCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
#pragma -mark 私有方法
-(void)clear
{
    [_image removeFromSuperview];
    _image=nil;
    [super clear];
    
}

-(void)addImage
{
    _image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    _image.layer.cornerRadius = 5;
    _image.clipsToBounds = YES;
    _image.layer.contentsGravity = kCAGravityResizeAspectFill;
    [_content addSubview:_image];
    
    NSArray *arr = [self.talkData.size componentsSeparatedByString:@"x"];
    float owidth = [[arr firstObject] floatValue];
    float oheight = [[arr lastObject] floatValue];
    
    float scale = IMAGE_MAX_HEIGHT / IMAGE_MAX_WIDTH;
    float imgScale = oheight / owidth;
    float width = 0.0f , height = 0.0f;
    if(imgScale < scale && owidth > IMAGE_MAX_WIDTH) {
        width = IMAGE_MAX_WIDTH;
        height= width * imgScale;
    } else if (imgScale > scale && oheight > IMAGE_MAX_HEIGHT) {
        height = IMAGE_MAX_HEIGHT;
        width = height / imgScale;
    }
    
    CGRect frame = _image.frame;
    frame.size = CGSizeMake(width, height);
    _image.frame = frame;
    [_image sd_setImageWithURL:[ToolUtils getImageUrlWtihString:self.talkData.img] placeholderImage:[UIImage imageNamed:@""]];
    frame = _content.frame;
    frame.size = _image.frame.size;
    _content.frame = frame;
    
    
    UITapGestureRecognizer * tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(lookImageAction:)];
    tap.numberOfTapsRequired = 1;
    [_backView addGestureRecognizer:tap];
    _backView.userInteractionEnabled = YES;
    
}

-(void)setContent
{
    if(self.talkData==nil)
        return;
    [super setContent];
    [self addImage];
    [self layoutSubviews];
}

#pragma -mark 事件响应方法
-(void)lookImageAction:(UIGestureRecognizer*)sender
{
    if(_image==nil)
        return;
    int count = 1;
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        // 替换为中等尺寸图片
        NSString *imageUrl = [ToolUtils getImageUrlWtihString:self.talkData.img].absoluteString;
        NSString *url = [imageUrl stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        NSString * encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)url, NULL, NULL,  kCFStringEncodingUTF8 ));
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString:encodedString]; // 图片路径
        
        photo.srcImageView = _image; // 来源于哪个UIImageView
        //        photo.description = [NSString stringWithFormat:@"========%i" , i];
        [photos addObject:photo];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = 0; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
}




@end
