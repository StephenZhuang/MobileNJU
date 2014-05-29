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
@property (nonatomic)NSString* name;
@end
