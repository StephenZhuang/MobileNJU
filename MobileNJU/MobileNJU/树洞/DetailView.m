//
//  DetailView.m
//  MobileNJU
//
//  Created by Stephen Zhuang on 14-6-13.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "DetailView.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"

@implementation DetailView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
//    _imageArray = [[NSMutableArray alloc] init];
//    [_collectionView registerNib:[UINib nibWithNibName:@"DetailView" bundle:nil] forCellWithReuseIdentifier:@"TreeHoleImageCell"];
}

#pragma - mark collectionview delegate
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
//{
//    if (_imageArray) {
//        return _imageArray.count;
//    }
//    return 0;
//}
//
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

- (void)setImageArray:(NSMutableArray *)imageArray
{
    _imageArray = imageArray;
    float height = 0;
    float originY = CGRectGetMaxY(_contentLabel.frame) + 8;
    for (int i = 0; i < imageArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        switch (i) {
            case 0:
                imageView.frame = CGRectMake(10, originY, 145, 145);
                height = 155;
                break;
            case 1:
                imageView.frame = CGRectMake(165, originY, 145, 145);
                height = 155;
                break;
            case 2:
                imageView.frame = CGRectMake(10, originY + 155, 145, 145);
                height = 300;
                break;
            default:
                imageView.frame = CGRectMake(165, originY +155, 145, 145);
                height = 300;
                break;
        }
        [imageView setImageWithURL:[NSURL URLWithString:_imageArray[i]] placeholderImage:[UIImage imageNamed:@""]];
        imageView.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lookImage:)];
        [imageView addGestureRecognizer:tap];
        imageView.userInteractionEnabled = YES;
        [self addSubview:imageView];
    }
    
//    [_collectionView reloadData];
//    
    CGRect rect = _contentLabel.frame;
//    rect.origin.y = CGRectGetMaxY(_contentLabel.frame) + 8;
//    if (_imageArray.count == 0) {
//        rect.size.height = 0.1;
//    } else if (_imageArray.count < 3) {
//        rect.size.height = 145;
//    } else {
//        rect.size.height = 300;
//    }
    //    rect.size = _collectionView.contentSize;
//    [_collectionView setFrame:rect];
    
    CGRect zanFrame = _zanButton.frame;
    zanFrame.origin.y = CGRectGetMaxY(rect) +height+ 8;
    [_zanButton setFrame:zanFrame];
    
    CGRect commentFrame = _commentButton.frame;
    commentFrame.origin.y = CGRectGetMaxY(rect) +height + 8;
    [_commentButton setFrame:commentFrame];
    
    CGRect selfFrame = self.frame;
    selfFrame.size.height = CGRectGetMaxY(commentFrame) + 8;
    self.frame = selfFrame;
    
}

- (void)setTopic:(MTopic_Builder *)topic
{
    [_titleLabel setText:topic.title];
    [_timeLabel setText:topic.time];
    [_contentLabel setText:topic.content];
    [_contentLabel sizeToFit];
    
    [_zanButton setTitle:[NSString stringWithFormat:@"%i" , topic.praiseCnt] forState:UIControlStateNormal];
    [_commentButton setTitle:[NSString stringWithFormat:@"%i" , topic.commentCnt] forState:UIControlStateNormal];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    if (topic.imgs.length > 0) {
        NSArray *imgStrArr = [topic.imgs componentsSeparatedByString:@","];
        
        for (NSString *str in imgStrArr) {
            [array addObject:[ToolUtils getImageUrlWtihString:str].absoluteString];
        }
    }
    [self setImageArray:array];
}

- (void)lookImage:(UITapGestureRecognizer *)tap
{
    UIImageView *imageView = (UIImageView *)tap.view;
    NSInteger count = _imageArray.count;
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        // 替换为中等尺寸图片
        NSString *imageUrl = [_imageArray objectAtIndex:i];
        NSString *url = [imageUrl stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        NSString * encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)url, NULL, NULL,  kCFStringEncodingUTF8 ));
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString:encodedString]; // 图片路径
        
        photo.srcImageView = imageView; // 来源于哪个UIImageView
        //        photo.description = [NSString stringWithFormat:@"========%i" , i];
        [photos addObject:photo];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = imageView.tag; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
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
