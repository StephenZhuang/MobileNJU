//
//  ScheduleLesson.m
//  MobileNJU
//
//  Created by luck-mac on 14-5-29.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "ScheduleLesson.h"

@implementation ScheduleLesson
- (NSDictionary *)getDic
{
    NSMutableDictionary* dic = [[NSMutableDictionary alloc]init];
    [dic setValue:[NSString stringWithFormat:@"%d",self.start] forKey:@"start"];
    
    [dic setValue:[NSString stringWithFormat:@"%d",self.length] forKey:@"length"];
    [dic setValue:[NSString stringWithFormat:@"%d",self.day] forKey:@"day"];
    [dic setValue:self.name forKey:@"name"];
    [dic setValue:self.location forKey:@"location"];
    [dic setValue:self.teacher forKey:@"teacher"];
    [dic setValue:self.week forKey:@"week"];
    [dic setValue:self.time forKey:@"time"];
    [dic setValue:self.busyweeks forKey:@"busyweeks"];
    [dic setValue:self.id forKey:@"id"];
    return dic;
}
- (void)loadDic:(NSDictionary *)dic
{
    self.start = [[dic objectForKey:@"start"]integerValue];
    self.length = [[dic objectForKey:@"length"]integerValue];
    self.day = [[dic objectForKey:@"day"]integerValue];
    self.name = [dic objectForKey:@"name"];
     
    self.location = [dic objectForKey:@"location"];
    self.teacher = [dic objectForKey:@"teacher"];
    self.week = [dic objectForKey:@"week"];
    self.time = [dic objectForKey:@"time"];
    self.busyweeks = [dic objectForKey:@"busyweeks"];
    self.id = [dic objectForKey:@"id"];
}
@end
