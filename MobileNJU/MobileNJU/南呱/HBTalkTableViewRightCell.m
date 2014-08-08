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
        _mLogo.frame=CGRectMake(SCREEN_WIDTH - LOGO_WIDTH - 10, 10, LOGO_WIDTH, LOGO_WIDTH);
        _backView.frame=CGRectMake(SCREEN_WIDTH - LOGO_WIDTH - 15 - BUBBLE_MIN_WIDTH, 10, BUBBLE_MIN_WIDTH, BUBBLe_MIN_HEIGHT);
        _content.frame=CGRectMake(10, 15, 10, 10);
        UIImage* image=[UIImage imageNamed:@"SenderTextNodeBkg"];
        image=[image stretchableImageWithLeftCapWidth:60 topCapHeight:30];
        _backView.image=image;

    }
    return self;
}

#pragma -mark 私有方法
-(void)clear
{
    [super clear];
    _backView.frame=CGRectMake(SCREEN_WIDTH - LOGO_WIDTH - 15 - BUBBLE_MIN_WIDTH, 10, BUBBLE_MIN_WIDTH, BUBBLe_MIN_HEIGHT);
    _content.frame=CGRectMake(10, 15, 10, 10);
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGRect frame = _backView.frame;
    frame.origin.x = SCREEN_WIDTH - LOGO_WIDTH - 15 -frame.size.width;
    _backView.frame = frame;
}

@end
