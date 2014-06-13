//
//  HBTalkTableViewLeftCell.m
//  MyTest
//
//  Created by weqia on 13-8-10.
//  Copyright (c) 2013年 weqia. All rights reserved.
//

#import "HBTalkTableViewLeftCell.h"

@implementation HBTalkTableViewLeftCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    if (self) {
        // Initialization code
        _mLogo.frame=CGRectMake(10, 10, 40, 40);
        _backView.frame=CGRectMake(55,15, 35, 30);
        _content.frame=CGRectMake(12, 8, 10, 10);

        UIImage* image=[UIImage imageNamed:@"ReceiverTextNodeBkg"];
        image=[image stretchableImageWithLeftCapWidth:30 topCapHeight:30];
        _backView.image=image;

    }
    return self;
}

#pragma -mark 私有方法
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGRect frame=_backView.frame;
    frame.origin.x=55;
    _backView.frame=frame;
}
-(void)clear
{
    [super clear];
    
    _backView.frame=CGRectMake(55,15, 35, 30);
    _content.frame=CGRectMake(12, 8, 10, 10);
}
#pragma -mark 事件响应方法


#pragma -mark 接口方法




@end
