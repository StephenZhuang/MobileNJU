//
//  ActivityCell.m
//  MobileNJU
//
//  Created by luck-mac on 14-5-31.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "ActivityCell.h"
#import "UtilMethods.h"
#import "UIImageView+WebCache.h"
@implementation ActivityCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
- (void)setImageName:(NSString *)imageName
{
    _imageName = imageName;
    UIImageView* img = [[UIImageView alloc]initWithFrame:CGRectMake(7, 70, 267, 140)];
    [img setImageWithURL:[UtilMethods getImageUrlWtihString:imageName width:534 height:280] placeholderImage:[UIImage imageNamed:@"560乘280"]];
    [self.activityView addSubview:img];
    self.imgView = img;
    
}
- (void)awakeFromNib
{
    // Initialization code
}
- (IBAction)showMore:(id)sender  {
    [self.delegate showAll:self.currentNew img:self.imgView.image] ;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setActivity:(NSDictionary *)activity
{
    self.timeLabel.layer.cornerRadius = 10;
    self.activityView.layer.cornerRadius = 5;
    self.activityView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.activityView.layer.borderWidth=1;
}


@end
