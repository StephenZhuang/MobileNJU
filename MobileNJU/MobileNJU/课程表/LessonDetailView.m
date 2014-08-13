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
    if (lesson.week.length>10) {
        [self.week setFont:[UIFont fontWithName:@"Helvetica" size:9]];
    }
    if (lesson.teacher.length==0)
    {
        [self.teacher setText:@"   "];
    }
    if (lesson.location.length==0) {
        lesson.location = @"   ";
    }
    [self.location setText:lesson.location];
    [self adjust];
}

- (void)adjust
{
    CGRect myFrame = CGRectMake(30, 80, 260, 219+16*(self.lessonName.text.length/9+self.teacher.text.length/9+self.time.text.length/9+self.location.text.length/9+self.week.text.length/28));
    self.frame = myFrame;
    self.adjustFrame = myFrame;
    [self setNeedsDisplay];
}

/*
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
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您是否确定删除" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    alert.delegate = self;
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        return;
    } else {
        [myDelegate deleteLesson:self.id];
 
    }
}


@end
