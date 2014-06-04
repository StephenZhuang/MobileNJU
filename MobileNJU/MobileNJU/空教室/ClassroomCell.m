//
//  ClassroomCell.m
//  MobileNJU
//
//  Created by luck-mac on 14-5-29.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "ClassroomCell.h"

@implementation ClassroomCell

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

- (void)addClassrooms:(NSArray *)classrooms
{
    for (int i = 0 ; i < classrooms.count; i++) {
        CGRect frame = CGRectMake(20+i%5*55, 39+i/5*25, 50, 21);
        UILabel* label = [[UILabel alloc]initWithFrame:frame];
        label.text = [classrooms objectAtIndex:i];
        label.frame = frame;
        label.layer.cornerRadius = 3;
        label.layer.borderColor = [UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1].CGColor;
        label.layer.borderWidth = 1;
        label.textColor = [UIColor colorWithRed:139/255.0 green:63/255.0 blue:138/255.0 alpha:1];
        label.textAlignment = NSTextAlignmentCenter;
        [label setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:label];
    }
    self.line = classrooms.count/5+1;
}
@end
