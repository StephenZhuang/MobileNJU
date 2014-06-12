//
//  HBTalkTableViewTextLeftCell.m
//  MyTest
//
//  Created by weqia on 13-8-11.
//  Copyright (c) 2013年 weqia. All rights reserved.
//

#import "HBTalkTableViewTextLeftCell.h"

@implementation HBTalkTableViewTextLeftCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code

    }
    return self;
}
#pragma -mark 私有方法
-(void)addText:(NSString*)text
{
    _text= [[HBCoreLabel alloc]initWithFrame:CGRectMake(0, 0, 200, 21)];
    _text.backgroundColor=[UIColor clearColor];
    [_text setFont:[UIFont systemFontOfSize:15]];
    MatchParser *match = [[MatchParser alloc] init];
    match.width = _text.frame.size.width;
    [match match:text];
    _text.match = match;
    
    CGRect rect = _text.frame;
    rect.size.height = match.height;
    if (match.numberOfTotalLines == 1) {
        rect.size.width = match.miniWidth;
    }
    _text.frame = rect;
    
    [_content addSubview:_text];
    CGRect frame=_content.frame;
    frame.size.height=_text.frame.size.height;
    frame.size.width=_text.frame.size.width;
    _content.frame=frame;
    [self layoutSubviews];
}

#pragma -mark 覆盖父类的方法
-(void)setContent
{
    if(self.talkData==nil)
        return;
    [super setContent];
//    if([self.talkData.contents isKindOfClass:[NSString class]]){
        [self addText:self.talkData.content];
//    }
}

@end
