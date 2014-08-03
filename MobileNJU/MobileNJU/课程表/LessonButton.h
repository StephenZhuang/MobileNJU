//
//  LessonButton.h
//  MobileNJU
//
//  Created by luck-mac on 14-5-29.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScheduleLesson.h"

@protocol ScheduleViewDelegate<NSObject>
@required
- (void) showSchedule:(ScheduleLesson*)lesson;
- (void) showSchedules:(NSArray*)lessons color:(UIColor*) color;
@end

@interface LessonButton : UIView
@property (nonatomic)int lessonId;
@property (nonatomic,strong)ScheduleLesson* myLesson;
@property(nonatomic,strong)NSMutableArray* lessonArr;
@property (nonatomic , assign) IBOutlet id<ScheduleViewDelegate> delegate;
- (UIColor*)getColor;
- (void)setMyButton:(UIButton *)myButton;
@end
