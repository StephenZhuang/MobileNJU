//
//  TitleView.m
//  MobileNJU
//
//  Created by Stephen Zhuang on 14-5-6.
//  Copyright (c) 2014年 udows. All rights reserved.
//

#import "TitleView.h"

@implementation TitleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setTitle:(NSString *)title{
    _title = title;
    [self.titleLabel setText:title];
}

- (void)setSubTitle:(NSString *)subTitle{
    _subTitle = subTitle;
    [self.subtitleLabel setText:subTitle];
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
