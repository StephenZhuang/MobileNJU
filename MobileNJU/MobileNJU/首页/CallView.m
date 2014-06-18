//
//  CallView.m
//  MobileNJU
//
//  Created by Stephen Zhuang on 14-6-18.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "CallView.h"

@implementation CallView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    self.backView.layer.cornerRadius = 10;
    _cancelButton.layer.borderColor = [UIColor blackColor].CGColor;
    _cancelButton.layer.borderWidth = 1;
    _cancelButton.layer.cornerRadius = 5;
    _confirmButton.layer.borderColor = [UIColor blackColor].CGColor;
    _confirmButton.layer.borderWidth = 1;
    _confirmButton.layer.cornerRadius = 5;
}


@end
