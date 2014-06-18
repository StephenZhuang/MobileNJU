//
//  TreeHoleListHeader.m
//  MobileNJU
//
//  Created by Stephen Zhuang on 14-6-18.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "TreeHoleListHeader.h"

@implementation TreeHoleListHeader

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)setMyTreeHoleButtonHidden
{
    [self.myTreeHoleButton setHidden:YES];
    [self.messageButton setCenter:self.center];
}

- (void)setMessageButtonHidden:(BOOL)hidden
{
    [self.messageButton setHidden:hidden];
    if (hidden) {
        [self.myTreeHoleButton setCenter:self.center];
    } else {
        CGRect rect = self.myTreeHoleButton.frame;
        rect.origin.x = 78;
        [self.myTreeHoleButton setFrame:rect];
    }
}

@end
