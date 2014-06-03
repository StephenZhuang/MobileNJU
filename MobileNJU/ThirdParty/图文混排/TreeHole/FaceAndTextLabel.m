//
//  FaceAndTextLabel.m
//  FaceAndText
//
//  Created by Ibokan on 14-4-10.
//  Copyright (c) 2014年 CainiaoLiu. All rights reserved.
//

#import "FaceAndTextLabel.h"

@implementation FaceAndTextLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    self.numberOfLines = 0;
    return self;
}
/**
 *  单例创建字典
 *
 *  @return 返回含有表情名称的列表
 */
-(NSDictionary *)getFace{
    static NSDictionary * dic = nil;
    if (dic == nil ) {
        NSString * path = [[NSBundle mainBundle]pathForResource:@"FaceList" ofType:@"plist"];
        dic = [NSDictionary dictionaryWithContentsOfFile:path];
    }
    return dic;

}
/**
 *  是否含有表情符
 *
 *  @param value 表情符的名称
 *  @param face  表情符名称的字典
 *
 *  @return 符合条件的表情符名称
 */
-(NSString *)faceKeyForValue:(NSString * )value face:(NSDictionary * )face{
    NSArray * allKeys = [face allKeys];
    for (NSString * key in allKeys){
        if ([value isEqualToString:[face objectForKey:key]]) {
            return key;
        }
    }
    return nil;

}
/**
 *  获取每一行字数
 *
 *  @param resourceString 传入的字符
 *  @param width          要求的宽度
 *
 *  @return 每一行的字符数量
 */
-(int)getIndex:(NSString * )resourceString withWidth:(float)width{
    NSMutableDictionary * attr = [[NSMutableDictionary alloc]init];
    [attr setObject:self.font forKey:NSFontAttributeName];
    int length = [resourceString length];
    for (int i = 0 ; i < length; i++) {
        NSString * subStr = [resourceString substringToIndex:i];
        CGSize size = [subStr sizeWithAttributes:attr];//7.0
//        CGSize size = [subStr sizeWithFont:self.font];//6.0

        if (size.width > width) {
            return i - 1;
            
        }
    }
    return length - 1;
}
/**
 *  输入的字符串处理
 *
 *  @param string 需要处理的字符串
 */
-(void)drawWithString:(NSString * )string{
    if (xIndex + kSPACE_WIDTH + 5 > maxWidth) {
        xIndex = 0.0f;
        yIndex += kLINE_HEIGHT;
    }
    NSMutableDictionary * attr = [[NSMutableDictionary alloc]init];
    [attr setObject:self.font forKey:NSFontAttributeName];
    CGSize size = [string sizeWithAttributes:attr];//7.0
//    CGSize size = [string sizeWithFont:self.font];//6.0
    while (size.width > (maxWidth - xIndex)) {
        int index = [self getIndex:string withWidth:maxWidth - xIndex];
        NSString * subString  = [string substringToIndex:index];
        CGSize subSize = [subString sizeWithAttributes:attr];
//        CGSize subSize = [subString sizeWithFont:self.font];//6.0

        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(xIndex, yIndex, subSize.width, subSize.height)];
        label.text = subString;
        label.textColor = self.textColor;
        label.font = self.font;
        label.backgroundColor = [UIColor clearColor];
        [self addSubview:label];
        xIndex = 0 ;
        line++ ;
        yIndex += kLINE_HEIGHT;
        string = [string substringFromIndex:index];
        size  = [string sizeWithAttributes:attr];
//        size  = [string  sizeWithFont:self.font];//6.0

    }
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(xIndex, yIndex, size.width, size.height)];
    if ([string isEqualToString:@"姑妈"]) {
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:@"姑妈"];
        [attributeString setAttributes:@{NSForegroundColorAttributeName : [UIColor redColor],   NSFontAttributeName : [UIFont systemFontOfSize:14]} range:NSMakeRange(0, 2)];
        label.attributedText = attributeString;
    } else {        
        label.text = string;
        label.textColor = self.textColor;
        label.font = self.font;
        label.backgroundColor = [UIColor clearColor];
    }
    [self addSubview:label];
    xIndex += size.width;
}
/**
 *  绘制处理图片
 *
 *  @param string 有可能是表情名称的字符串；
 */
-(void)doFace:(NSString * )string{
    NSString * faceStr = [self faceKeyForValue:string face:[self getFace]];
    if (faceStr == nil) {
        [self drawWithString:string];
        return;
    }
    NSMutableString * faceName= [NSMutableString stringWithString:faceStr];
    [faceName appendString:@".png"];
    UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:faceName]];
    if (xIndex + kICON_SIZE + kSPACE_WIDTH >= maxWidth) {
        xIndex = 0.0f;
        yIndex += kLINE_HEIGHT;
        line++ ;
    }
    imageView.frame = CGRectMake(kSPACE_WIDTH + xIndex, (kLINE_HEIGHT - kICON_SIZE ) / 2 +yIndex, kICON_SIZE, kICON_SIZE);
    [self addSubview:imageView];
    xIndex = xIndex + kICON_SIZE + kSPACE_WIDTH;
}
#pragma mark--接口实现
-(void)setFaceAndText:(NSString *)string;
{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    FaceMatch * faceMatch = [[FaceMatch alloc]init];
    NSArray * faceArray = [faceMatch match:string];
    line = 1;
    xIndex  = 0.0f;
    yIndex  = 0.0f;
    maxWidth = self.frame.size.width;
    int count = [faceArray count];
    for (int i = 0 ; i <count ; i++) {
        NSString * str = [faceArray objectAtIndex:i];
        if ([str hasPrefix:kBEGIN_MARK] && [str hasSuffix:kEND_MARK ]) {
            [self doFace:str];
        }else{
        
            [self drawWithString:str];
        }
    }
    CGRect frame = self.frame;
    frame.size.height = yIndex + 21;
    if (line == 1) {
        frame.size.width = xIndex;
        self.frame = frame;
    } else {
        self.frame = frame;
    }
 }

@end
