//
//  LessonButton.m
//  MobileNJU
//
//  Created by luck-mac on 14-5-29.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "LessonButton.h"

@implementation LessonButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.lessonArr = [[NSMutableArray alloc]init];
    }
    return self;
}



- (void) showDetail
{
    if (self.lessonArr.count==1) {
        [self.delegate showSchedule:self.myLesson];
    } else {
        [self.delegate showSchedules:self.lessonArr  color: [self getColor]];
    }
}


- (UIColor*)getColor
{
    switch (self.lessonId%10) {
        case 0:return [UIColor colorWithRed:216/255.0 green:216/255.0 blue:216/255.0 alpha:1];
        case 1:return [UIColor colorWithRed:255/255.0 green:169/255.0 blue:165/255.0 alpha:1];
        case 2:return [UIColor colorWithRed:118/255.0 green:233/255.0 blue:188/255.0 alpha:1];
        case 3:return [UIColor colorWithRed:0/255.0 green:196/255.0 blue:231/255.0 alpha:1];
        case 4:return [UIColor colorWithRed:255/255.0 green:219/255.0 blue:255/255.0 alpha:1 ];
        case 5:return [UIColor colorWithRed:255/255.0 green:202/255.0 blue:133/255.0 alpha:1];
        case 6:return [UIColor colorWithRed:156/255.0 green:216/255.0 blue:123/255.0 alpha:1];
        case 7:return [UIColor colorWithRed:75/255.0 green:168/255.0 blue:255/255.0 alpha:1];
        case 8:return [UIColor colorWithRed:143/255.0 green:128/255.0 blue:255/255.0 alpha:1];
        case 9:return [UIColor colorWithRed:255/255.0 green:98/255.0 blue:150/255.0 alpha:1];

    }
    return [UIColor blackColor];
}

- (void)setMyButton:(UIButton *)myButton
{
    [myButton addTarget:self action:@selector(showDetail) forControlEvents:UIControlEventTouchUpInside];

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
