//
//  HBTalkTableViewRightCell.m
//  MyTest
//
//  Created by weqia on 13-8-10.
//  Copyright (c) 2013年 weqia. All rights reserved.
//

#import "HBTalkTableViewRightCell.h"

@implementation HBTalkTableViewRightCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _mLogo.frame=CGRectMake(270, 10, 40, 40);
        _backView.frame=CGRectMake(250, 15, 35, 30);
        _content.frame=CGRectMake(8, 8, 10, 10);
        UIImage* image=[UIImage imageNamed:@"SenderTextNodeBkg"];
        image=[image stretchableImageWithLeftCapWidth:30 topCapHeight:30];
        _backView.image=image;

    }
    return self;
}

#pragma -mark 私有方法
-(void)clear
{
    [super clear];
    _backView.frame=CGRectMake(250, 15, 35, 30);
    _content.frame=CGRectMake(8, 8, 10, 10);
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGRect frame=_backView.frame;
    frame.origin.x=265-frame.size.width;
    _backView.frame=frame;
}

@end
