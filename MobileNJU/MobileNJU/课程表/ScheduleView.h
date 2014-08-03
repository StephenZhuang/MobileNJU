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
@property (weak, nonatomic) IBOutlet UILabel *dayOne;
@property (weak, nonatomic) IBOutlet UILabel *dayTwo;
@property (weak, nonatomic) IBOutlet UILabel *dayThree;
@property (weak, nonatomic) IBOutlet UILabel *dayFour;
@property (weak, nonatomic) IBOutlet UILabel *dayFive;
@property (weak, nonatomic) IBOutlet UILabel *daySex;
@property (weak, nonatomic) IBOutlet UILabel *daySeven;
@property (weak, nonatomic) IBOutlet UIView *currentWeek;
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property (nonatomic,strong)NSMutableArray* buttonList;
- (void)initDate;
@end
