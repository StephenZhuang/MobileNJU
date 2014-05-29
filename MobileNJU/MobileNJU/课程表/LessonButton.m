//
//  LessonButton.m
//  MobileNJU
//
//  Created by luck-mac on 14-5-29.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "LessonButton.h"
#define STARTX 15   
#define STARTY -1
#define WIDTH 61
#define HEIGHT 49.5
@implementation LessonButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setMyLesson:(ScheduleLesson *)myLesson
{
    _myLesson = myLesson;
    CGRect frame = CGRectMake(STARTX+(myLesson.day-1)*WIDTH, STARTY+(myLesson.start-1)*HEIGHT, WIDTH, HEIGHT*myLesson.length);
    self.frame = frame;
    self.backgroundColor = [self randomColor];
    [self setTitle:myLesson.name forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.lineBreakMode= NSLineBreakByCharWrapping;
}


- (UIColor*)randomColor
{
    switch (arc4random()%8) {
        case 0:return [UIColor colorWithRed:250/255.0 green:120/255.0 blue:134/255.0 alpha:1];
        case 1:return [UIColor colorWithRed:252/255.0 green:220/255.0 blue:54/255.0 alpha:1];
        case 2:return [UIColor colorWithRed:255/255.0 green:169/255.0 blue:65/255.0 alpha:1];
        case 3:return [UIColor colorWithRed:215/255.0 green:231/255.0 blue:243/255.0 alpha:1];
        case 4:return [UIColor colorWithRed:250/255.0 green:120/255.0 blue:134/255.0 alpha:1 ];
        case 5:return [UIColor colorWithRed:175/255.0 green:146/255.0 blue:215/255.0 alpha:1];
        case 6:return [UIColor colorWithRed:203/255.0 green:202/255.0 blue:199/255.0 alpha:1];
        case 7:return [UIColor colorWithRed:52/255.0 green:206/255.0 blue:217/255.0 alpha:1];
        case 8:return [UIColor colorWithRed:168/255.0 green:210/255.0 blue:65/255.0 alpha:1];
    }
    return [UIColor blackColor];
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
