//
//  TreeHoleCell.m
//  MobileNJU
//
//  Created by Stephen Zhuang on 14-5-27.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "TreeHoleCell.h"

@implementation TreeHoleCell

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

+ (CGFloat)getHeightByTopic:(MTopic *)topic
{
    CGFloat height = 18;
    if (topic.tag.length > 0) {
        height += 29;
    }
    
    UIFont *font = [UIFont systemFontOfSize:17];
    CGSize size = CGSizeMake(286,2000);
    CGSize labelsize = [topic.content sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
    height += labelsize.height;
    
    if (topic.img.length > 0) {
        height += 110;
    }
    height += 17;
    height += 38;
    return height;
}

+ (CGFloat)getDetailHeightByTopic:(MTopic_Builder *)topic
{
    CGFloat height = 0;
    if (!topic) {
        return height;
    }
    if (topic.img.length > 0) {
        height += 220;
    }
    UIFont *font = [UIFont systemFontOfSize:17];
    CGSize size = CGSizeMake(280,2000);
    CGSize labelsize = [topic.content sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
    height += labelsize.height;
    
    
    height += 16;
    height += 38;
    return height;
}

@end
