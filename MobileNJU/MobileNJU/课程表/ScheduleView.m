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
#define WIDTH 41.4
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
    NSArray* dayLabels = [NSArray arrayWithObjects:self.dayOne,self.dayTwo,self.dayThree,self.dayFour,self.dayFive,self.daySex,self.daySeven, nil];

    
    NSCalendar*calendar = [NSCalendar currentCalendar];
    NSDate* date = [NSDate date];
    NSDateComponents* compos =[calendar components:(NSWeekCalendarUnit | NSWeekdayCalendarUnit |NSWeekdayOrdinalCalendarUnit)
                                          fromDate:date];
    //    NSInteger week = [compos week]; // 今年的第几周
    NSInteger weekday = [compos weekday]; // 星期几（注意，周日是“1”，周一是“2”。。。。）
    self.currentWeek.transform = CGAffineTransformMakeTranslation(((weekday-2)%7)*WIDTH*2, 0);
    
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









- (void)addLessons:(NSArray *)lessons delegate:(id<ScheduleViewDelegate>) delegate
{
    int lessonId=0;
    self.buttonList = [[NSMutableArray alloc]init];
    for (ScheduleLesson* lesson in lessons) {
        int flag = 1;
        for (LessonButton* button in self.buttonList) {
            ScheduleLesson* buttonLesson = button.myLesson;
            if (buttonLesson.day==lesson.day&&buttonLesson.start<=lesson.start&&(buttonLesson.start+buttonLesson.length)>lesson.start) {
                if (button.lessonArr.count==1) {
                    CGRect frame = CGRectMake(button.frame.size.width-8.5, 0, 8.5, 7.5);
                    UIImageView* img1 = [[UIImageView alloc]initWithFrame:frame];
                    [img1 setImage:[UIImage imageNamed:@"09课程表-折叠课程表-右上角三角2"]];
                    [button addSubview:img1];
                    
                    UIImageView* img2 = [[UIImageView alloc]initWithFrame:frame];
                    [img2 setImage:[UIImage imageNamed:@"09课程表-折叠课程表-右上角三角1"]];
                    [button addSubview:img2];

                }
                [button.lessonArr addObject:lesson];
                flag=0;
                
                break;
            }
            
        }
        if (flag) {
            
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
            CGRect nameFrame = CGRectMake(3, 7, WIDTH-6, HEIGHT*lesson.length-22);
            VerticallyAlignedLabel *lessonNameLabel = [[VerticallyAlignedLabel alloc]initWithFrame:nameFrame];
            [lessonNameLabel setFont:[UIFont fontWithName:@"Helvetica" size:9]];
            [lessonNameLabel setText:lesson.name];
            [lessonNameLabel setTextColor:[UIColor whiteColor]];
            // 0代表不限制行数
            [lessonNameLabel setNumberOfLines:0];
            [lessonNameLabel setVerticalAlignment:VerticalAlignmentTop];
            // 因为行数不限制，所以这里在宽度不变的基础上(实际宽度会略为缩小)，高度会自动扩充
            //    self.titleLabel.lineBreakMode= NSLineBreakByCharWrapping;
            
            
            CGRect loactionFrame = CGRectMake(3, HEIGHT*lesson.length-15, WIDTH-6, 15);
            UILabel *locationLabel = [[UILabel alloc]initWithFrame:loactionFrame];
            [locationLabel setFont:[UIFont fontWithName:@"Helvetica" size:9]];
            [locationLabel setText:lesson.location];
            [locationLabel setTextColor:[UIColor whiteColor]];
            
            
            [lessonBt addSubview:button];
            [lessonBt setMyButton:button];
            [lessonBt addSubview:lessonNameLabel];
            [lessonBt addSubview:locationLabel];
            [self.buttonList addObject:lessonBt];
            [self addSubview:lessonBt];

        }
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
