//
//  ViewForIcaursel.h
//  MobileNJU
//
//  Created by luck-mac on 14-8-2.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScheduleLesson.h"
#import "VerticallyAlignedLabel.h"
@interface ViewForIcaursel : UIView
@property (weak, nonatomic) IBOutlet VerticallyAlignedLabel *LessonNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (nonatomic,strong)ScheduleLesson* lesson;
@property (nonatomic)UIColor *color;
@end
