//
//  TagButton.m
//  MobileNJU
//
//  Created by luck-mac on 14-5-24.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "TagButton.h"

@implementation TagButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setTagContent:(NSString *)tagContent
{
    _tagContent = tagContent;
    [self setTitle:tagContent forState:UIControlStateNormal];
}

- (void)setChoose:(BOOL)choose
{
    if (choose) {
        [self setBackgroundImage:[UIImage imageNamed:@"tag_choose"] forState:UIControlStateNormal];
        [self setBackgroundImage:nil forState:UIControlStateSelected];
    } else {
        [self setBackgroundImage:[UIImage imageNamed:@"tag_choose"] forState:UIControlStateSelected];
        [self setBackgroundImage:nil forState:UIControlStateNormal];
    }
    
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
