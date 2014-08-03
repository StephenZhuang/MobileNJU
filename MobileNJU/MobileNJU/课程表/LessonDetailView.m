//
//  LessonDetailView.m
//  MobileNJU
//
//  Created by luck-mac on 14-5-30.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "LessonDetailView.h"

@implementation LessonDetailView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-  (void)setMydelegate:(id<AlertCloseDelegate>)delegate
{
    myDelegate = delegate;
}
- (void)setLesson:(ScheduleLesson *)lesson
{
    _lesson = lesson;
    [self.lessonName setText:lesson.name];
    [self.teacher setText:lesson.teacher];
    [self.time setText:lesson.time];
    [self.week setText:lesson.week];
    [self.location setText:lesson.location];
    
}/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (IBAction)closeSelf:(id)sender {
    [myDelegate closeAlert];
}

- (IBAction)deleteLesson:(id)sender {
    [myDelegate deleteLesson:self.id];
}




@end
