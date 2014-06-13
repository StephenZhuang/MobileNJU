//
//  CheckBox.m
//  MobileNJU
//
//  Created by luck-mac on 14-5-24.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "CheckBox.h"

@implementation CheckBox

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setChoose:(BOOL)choose{
    _choose = choose;
    if (choose) {
        [self setImage:[UIImage imageNamed:@"check_box_selected"] forState:UIControlStateNormal];
          [self setImage:[UIImage imageNamed:@"check_box_unselected"] forState:UIControlStateSelected];
        
    } else {
        [self setImage:[UIImage imageNamed:@"check_box_selected"] forState:UIControlStateSelected];
        [self setImage:[UIImage imageNamed:@"check_box_unselected"] forState:UIControlStateNormal];
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
