//
//  NewsCell.m
//  MobileNJU
//
//  Created by luck-mac on 14-5-22.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "NewsCell.h"
#import "Utilities.h"
#import "UIImage+GIF.h"
@implementation NewsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setImageName:(NSString *)imageName
{
    
    _imageName = imageName;
    UIImage* loading = [UIImage imageNamed:@"178乘134"];
    [self.newsImage setImageWithURL:[ToolUtils getImageUrlWtihString:imageName width:178 height:134] placeholderImage:loading];
    [self.newsImage setClipsToBounds:YES];
}
- (void)setType:(NSString *)type
{
    _type = type;
    [self.newsType setText:type];
}

- (void) setDate:(NSString *)date
{
    _date = date;
    [self.newsDate setText:date];
}

- (void)setTitle:(NSString *)title{
    _title = title;
    [self.newsTitle setText:title];
}

- (void)setDetail:(NSString *)detail
{
    _detail = detail;
    [self.newsDetail setText:detail];
}

@end
