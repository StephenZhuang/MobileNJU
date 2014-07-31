//
//  WeekCell.m
//  CreateLesson
//
//  Created by luck-mac on 14-7-27.
//  Copyright (c) 2014年 nju.excalibur. All rights reserved.
//

#import "WeekCell.h"


@implementation WeekCell


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setFlag:(int)flag
{
    if (flag==1) {
        [self setBackgroundColor:[UIColor colorWithRed:156/255.0 green:216/255.0 blue:132/255.0 alpha:1]];
    } else {
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    self.select = flag;

}

- (IBAction)select:(id)sender {
    if (self.select==1) {
        [self setFlag:0];
    } else {
        [self setFlag:1];
    }
    [self.myDelegate chooseWeek:self.number select:self.select];
}


-(void)setNum:(int)num
{
    self.number = num;
    [self.numLabel setText:[NSString stringWithFormat:@"%d",num]];
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
