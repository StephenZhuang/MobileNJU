//
//  ScheduleView.m
//  MobileNJU
//
//  Created by luck-mac on 14-5-29.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "ScheduleView.h"
#import "LessonButton.h"
#define HEADBACKCOLOR  [UIColor colorWithRed:235/255.0 green:234/255.0 blue:231/255.0 alpha:1]
#define HEADTEXTCOLOR  [UIColor colorWithRed:129/255.0 green:129/255.0 blue:129/255.0 alpha:1]
@implementation ScheduleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
   
    return self;
}
- (void)addLessons:(NSArray *)lessons delegate:(id<ScheduleViewDelegate>) delegate
{
    int lessonId=0;
    for (ScheduleLesson* lesson in lessons) {
        LessonButton* button = [[LessonButton alloc]init];
        button.lessonId=lessonId;
        lessonId++;
        [button setMyLesson:lesson];
        [button setDelegate:delegate];
        [self addSubview:button];
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
