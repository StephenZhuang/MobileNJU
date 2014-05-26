//
//  Lesson.h
//  MobileNJU
//
//  Created by luck-mac on 14-5-27.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Lesson : NSObject
@property (nonatomic,strong)NSString* lessonName;
@property (nonatomic,strong)NSString* lessonType;
@property (nonatomic)int score;
@property(nonatomic)double credit;
@end
