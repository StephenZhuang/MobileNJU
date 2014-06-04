//
//  ScheduleView.h
//  MobileNJU
//
//  Created by luck-mac on 14-5-29.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScheduleLesson.h"
#import "LessonButton.h"
@interface ScheduleView : UIView
-(void)addLessons:(NSArray*)lessons delegate:(id<ScheduleViewDelegate>) delegate
;
@end
