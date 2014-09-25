//
//  ScheduleView.m
//  MobileNJU
//
//  Created by luck-mac on 14-5-29.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "ScheduleView.h"
#import "LessonButton.h"

#import "VerticallyAlignedLabel.h"
#define STARTX 31
#define STARTY 27
#define WIDTH 41
#define HEIGHT 47.5
#define HEADBACKCOLOR  [UIColor colorWithRed:235/255.0 green:234/255.0 blue:231/255.0 alpha:1]
#define HEADTEXTCOLOR  [UIColor colorWithRed:129/255.0 green:129/255.0 blue:129/255.0 alpha:1]
@implementation ScheduleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
   
    return self;
}








- (void)initDate
{
    self.week = [ToolUtils getCurrentWeek];
    NSArray* dayLabels = [NSArray arrayWithObjects:self.dayOne,self.dayTwo,self.dayThree,self.dayFour,self.dayFive,self.daySex,self.daySeven, nil];
    
    NSCalendar*calendar = [NSCalendar currentCalendar];
    NSDate* date = [NSDate date];
    NSDateComponents* compos =[calendar components:(NSWeekCalendarUnit | NSWeekdayCalendarUnit |NSWeekdayOrdinalCalendarUnit)
                                          fromDate:date];
    //    NSInteger week = [compos week]; // 今年的第几周
    NSInteger weekday = [compos weekday]; // 星期几（注意，周日是“1”，周一是“2”。。。。）
    if (weekday>1) {
        self.currentWeek.transform = CGAffineTransformMakeTranslation(((weekday-2)%7)*WIDTH*2, 0);

    } else {
        self.currentWeek.transform = CGAffineTransformMakeTranslation(6*WIDTH*2, 0);

    }
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
    // 设置日期格式
    
    [dateFormatter setDateFormat:@"dd"];
    
    for (int i = 0; i< 7; i++) {
        NSDate *newDate = [[NSDate alloc] initWithTimeInterval:60*60*24*(i-((weekday-2)%7)) sinceDate:[NSDate date]];
        UILabel* label = [dayLabels objectAtIndex:i];
        [label setText:[dateFormatter stringFromDate:newDate]];

    }
    
    [dateFormatter setDateFormat:@"MM月"];
    NSString* month = [dateFormatter stringFromDate:[NSDate date]];
    [self.monthLabel setText:month];
  
    
    
}






- (BOOL) judge:(ScheduleLesson*) exitLesson newLesson:(ScheduleLesson*)newLesson
{
    if (exitLesson.day!=newLesson.day) {
        return NO;
    } else if (exitLesson.start<=newLesson.start&& (newLesson.start-exitLesson.start)<exitLesson.length)
    {
        return YES;
    } else if (newLesson.start<=exitLesson.start&&(exitLesson.start-newLesson.start)<newLesson.length)
    {
        return YES;
    } else if (exitLesson.start<=newLesson.start&&(exitLesson.start+exitLesson.length-1)>=(newLesson.start+newLesson.length-1))
    {
        return YES;
        
    } else if (exitLesson.start>=newLesson.start&&(exitLesson.start+exitLesson.length-1)<=(newLesson.start+newLesson.length-1))
    {
        return YES;
    }
    return NO;
}



- (void)addLessons:(NSArray *)lessons delegate:(id<ScheduleViewDelegate>) delegate
{
    int lessonId=0;
    self.buttonList = [[NSMutableArray alloc]init];
    for (ScheduleLesson* lesson in lessons) {
        NSMutableArray* removeButtonList = [[NSMutableArray alloc]init];
        int flag = 1;
        for (LessonButton* button in self.buttonList) {
            ScheduleLesson* buttonLesson = button.myLesson;
            if ([self judge:buttonLesson newLesson:lesson]  ) {
                [button.lessonArr addObject:lesson];
                if (buttonLesson.length<lesson.length) {
                    button.myLesson = lesson;
                }
                int currentStart = buttonLesson.start;
                int currentEnd = buttonLesson.start+buttonLesson.length-1;
                int currentLength = buttonLesson.length;
                if (buttonLesson.start > lesson.start) {
                    currentStart = lesson.start;
                }
                if (currentEnd < lesson.start+lesson.length-1) {
                    currentEnd = lesson.start+lesson.length-1;
                }
                ScheduleLesson* virtualLesson =  [[ScheduleLesson alloc]init];
                virtualLesson.day = lesson.day;
                virtualLesson.start = currentStart;
                virtualLesson.length = currentLength;
                currentLength = currentEnd-currentStart+1;
                for (LessonButton* checkButton in self.buttonList) {
                    if (checkButton!=button) {
                        ScheduleLesson* checkLesson = checkButton.myLesson;
                        if ([self judge:virtualLesson newLesson:checkLesson]) {
                            if (button.myLesson.length<checkLesson.length) {
                                button.myLesson = checkLesson;
                            }
                            [removeButtonList addObject:checkButton];
                            [checkButton removeFromSuperview];
                            for (ScheduleLesson* lesson in button.lessonArr) {
                                if ([checkButton.lessonArr indexOfObject:lesson]==NSNotFound) {
                                    [checkButton.lessonArr addObject:lesson];
                                }
                            }
                            [button.lessonArr addObjectsFromArray:checkButton.lessonArr];
                            if (currentStart > checkLesson.start) {
                                currentStart = lesson.start;
                            }
                            if (currentEnd < checkLesson.start+checkLesson.length-1) {
                                currentEnd = lesson.start+lesson.length-1;
                            }
                            currentLength = currentEnd-currentStart+1;                    }
                    } else {
                        NSLog(@"重复");
                    }
             
                }
                [button.lessonNameLabel removeFromSuperview];
                [button.locationLabel removeFromSuperview];
                [button removeFromSuperview];
                CGRect frame = CGRectMake(STARTX+(lesson.day-1)*WIDTH, STARTY+(currentStart
                                                                            -1)*HEIGHT, WIDTH, HEIGHT*currentLength);
                button.frame  = frame;
                UIButton *touchButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT*currentLength)];
                [touchButton setTitle:@"" forState:UIControlStateNormal];
                [touchButton setBackgroundColor:[UIColor clearColor]];
                touchButton.backgroundColor = [button getColor];
                CGRect nameFrame = CGRectMake(3, 0, WIDTH-6, HEIGHT*lesson.length-22);
                VerticallyAlignedLabel *lessonNameLabel = [[VerticallyAlignedLabel alloc]initWithFrame:nameFrame];
                [lessonNameLabel setFont:[UIFont fontWithName:@"Helvetica" size:11]];
                [lessonNameLabel setText:lesson.name];
                [lessonNameLabel setTextColor:[UIColor whiteColor]];
                // 0代表不限制行数
                [lessonNameLabel setNumberOfLines:3];
                [lessonNameLabel setVerticalAlignment:VerticalAlignmentTop];
                // 因为行数不限制，所以这里在宽度不变的基础上(实际宽度会略为缩小)，高度会自动扩充
                //    self.titleLabel.lineBreakMode= NSLineBreakByCharWrapping;
                
                CGRect loactionFrame = CGRectMake(3, 50, WIDTH-6, 60);
                VerticallyAlignedLabel *locationLabel = [[VerticallyAlignedLabel alloc]initWithFrame:loactionFrame];
                
                
                [locationLabel setFont:[UIFont fontWithName:@"Helvetica" size:9]];
                [locationLabel setNumberOfLines:0];
                [locationLabel setVerticalAlignment:VerticalAlignmentTop];
                [locationLabel setText:[NSString stringWithFormat:@"@%@",lesson.location]];
                [locationLabel setTextColor:[UIColor whiteColor]];
                [button addSubview:touchButton];
                [button setMyButton:touchButton];
                [button addSubview:lessonNameLabel];
                [button addSubview:locationLabel];
                button.locationLabel = locationLabel;
                button.lessonNameLabel = lessonNameLabel;
                button.touchButton = touchButton;
                [button setNeedsDisplay];
                [self addSubview:button];
                
                if (button.lessonArr.count>=2) {
                    CGRect frame = CGRectMake(button.frame.size.width-8.5, 0, 8.5, 7.5);
                    UIImageView* img1 = [[UIImageView alloc]initWithFrame:frame];
                    [img1 setImage:[UIImage imageNamed:@"09课程表-折叠课程表-右上角三角2"]];
                    [button addSubview:img1];
                    UIImageView* img2 = [[UIImageView alloc]initWithFrame:frame];
                    [img2 setImage:[UIImage imageNamed:@"09课程表-折叠课程表-右上角三角1"]];
                    [button addSubview:img2];
                }
                flag=0;
            }
        }
        [self.buttonList removeObjectsInArray:removeButtonList];

        if (flag==1) {
            CGRect frame = CGRectMake(STARTX+(lesson.day-1)*WIDTH, STARTY+(lesson.start-1)*HEIGHT, WIDTH, HEIGHT*lesson.length);
            LessonButton* lessonBt = [[LessonButton alloc]initWithFrame:frame];
            lessonBt.delegate = delegate;
            lessonBt.lessonId=lessonId;
            lessonId++;
            [lessonBt setMyLesson:lesson];
            [lessonBt.lessonArr addObject:lesson];
            UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT*lesson.length)];
            [button setTitle:@"" forState:UIControlStateNormal];
            [button setBackgroundColor:[UIColor clearColor]];
            lessonBt.backgroundColor = [lessonBt getColor];
            CGRect nameFrame = CGRectMake(3, 0, WIDTH-6, HEIGHT*lesson.length-22);
            VerticallyAlignedLabel *lessonNameLabel = [[VerticallyAlignedLabel alloc]initWithFrame:nameFrame];
            [lessonNameLabel setFont:[UIFont fontWithName:@"Helvetica" size:11]];
            [lessonNameLabel setText:lesson.name];
            [lessonNameLabel setTextColor:[UIColor whiteColor]];
            // 0代表不限制行数
            [lessonNameLabel setNumberOfLines:3];
            [lessonNameLabel setVerticalAlignment:VerticalAlignmentTop];
            // 因为行数不限制，所以这里在宽度不变的基础上(实际宽度会略为缩小)，高度会自动扩充
            //    self.titleLabel.lineBreakMode= NSLineBreakByCharWrapping;
            
            CGRect loactionFrame = CGRectMake(3, 50, WIDTH-6, 60);
            VerticallyAlignedLabel *locationLabel = [[VerticallyAlignedLabel alloc]initWithFrame:loactionFrame];
            
            
            [locationLabel setFont:[UIFont fontWithName:@"Helvetica" size:9]];
            [locationLabel setNumberOfLines:0];
            [locationLabel setVerticalAlignment:VerticalAlignmentTop];
            [locationLabel setText:[NSString stringWithFormat:@"@%@",lesson.location]];
            [locationLabel setTextColor:[UIColor whiteColor]];
            
            
            [lessonBt addSubview:button];
            [lessonBt setMyButton:button];
            [lessonBt addSubview:lessonNameLabel];
            [lessonBt addSubview:locationLabel];
            lessonBt.locationLabel = locationLabel;
            lessonBt.lessonNameLabel = lessonNameLabel;
            lessonBt.touchButton = button;
            
            if (lesson.length==1) {
                [locationLabel setHidden:YES];
            }
            [self.buttonList addObject:lessonBt];
            [self addSubview:lessonBt];

        }
    }
    
    
    for (LessonButton* button in self.buttonList) {
        if (button.lessonArr.count==1) {
            if (![self judgeHasLesson:button.myLesson]) {
                button.backgroundColor =  [UIColor colorWithRed:216/255.0 green:216/255.0 blue:216/255.0 alpha:1];
                [button.locationLabel setText:@"@本周无课程"];
            }
        } else {
            BOOL hasLesson = NO;
            for (ScheduleLesson* lesson in button.lessonArr) {
                if ([self judgeHasLesson:lesson]) {
                    [button.lessonNameLabel setText:lesson.name];
                    [button.locationLabel setText:[NSString stringWithFormat:@"@%@",lesson.location]];
                    hasLesson = YES;
                }
            }
            if (!hasLesson) {
                button.backgroundColor =  [UIColor colorWithRed:216/255.0 green:216/255.0 blue:216/255.0 alpha:1];
                [button.locationLabel setText:@"@本周无课程"];
            }
        }
    }
    
    
}

- (BOOL)judgeHasLesson:(ScheduleLesson*)lesson
{
    NSArray* busyweeks = [lesson.busyweeks componentsSeparatedByString:@","];
    for (NSString* week in busyweeks) {
        if (week.integerValue == self.week) {
            return YES;
        }
    }
    return NO;
//    NSString* week = lesson.week;
//    if ([week isEqualToString:@"双周"]) {
//        if (self.week%2!=0) {
//            return NO;
//        }
//    } else if ([week isEqualToString:@"单周"]){
//        if (self.week%2==0) {
//            return NO;
//        }
//    } else if ([week rangeOfString:@"-"].length>0)
//    {
//        NSArray* range = [week componentsSeparatedByString:@"-"];
//        NSString* end = [[[range objectAtIndex:1] componentsSeparatedByString:@"周"] firstObject];
//        
//        if ([[range firstObject] integerValue] > self.week|| [end integerValue] < self.week) {
//            return NO;
//        }
//    } else if ([week rangeOfString:@" "].length>0)
//    {
//        NSArray* range = [week componentsSeparatedByString:@" "];
//        BOOL has = NO;
//        for (NSString* day in range) {
//            if ( [day integerValue]==self.week) {
//                has = YES;
//                break;
//            }
//        }
//        if (!has) {
//            return NO;
//        }
//    }
//    return YES;
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
