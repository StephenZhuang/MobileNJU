//
//  ScheduleLesson.h
//  MobileNJU
//
//  Created by luck-mac on 14-5-29.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScheduleLesson : NSObject
@property (nonatomic)NSInteger start;
@property (nonatomic)NSInteger length;
@property (nonatomic)NSInteger day;
@property (nonatomic,strong)NSString* name;
@property (nonatomic,strong)NSString* location;
@property (nonatomic,strong)NSString* teacher;
@property (nonatomic,strong)NSString* week;
@property (nonatomic,strong)NSString* time;
@property (nonatomic,strong)NSString* id;
-(NSDictionary*) getDic;
-(void)loadDic:(NSDictionary*)dic;
@end
