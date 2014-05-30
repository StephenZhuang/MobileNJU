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
@end

@interface LessonButton : UIButton
@property (nonatomic,strong)ScheduleLesson* myLesson;
@property (nonatomic , assign) IBOutlet id<ScheduleViewDelegate> delegate;
@end
