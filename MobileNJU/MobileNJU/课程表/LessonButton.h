//
//  LessonButton.h
//  MobileNJU
//
//  Created by luck-mac on 14-5-29.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScheduleLesson.h"
@interface LessonButton : UIButton
@property (nonatomic,strong)ScheduleLesson* myLesson;
@end
