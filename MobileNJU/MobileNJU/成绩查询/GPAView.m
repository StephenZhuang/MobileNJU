//
//  GPAView.m
//  MobileNJU
//
//  Created by luck-mac on 14-5-27.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "GPAView.h"
#import "ZsndSystem.pb.h"
@implementation GPAView
@synthesize lessonList = _lessonList;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (IBAction)close:(id)sender {
    [myDelegate closeAlert];
}

- (void)setDelegate:(id<AlertCloseDelegate>)delegate
{
    myDelegate = delegate;
}

- (void)setLessonList:(NSArray *)lessonList
{
    _lessonList = lessonList;
    double totalScore = 0.0;
    double credit = 0.0;
    for (MCourse* lesson in lessonList) {
        if (lesson.grade.integerValue==0) {
            continue;
        }
        totalScore = totalScore + lesson.grade.integerValue*lesson.point.integerValue;
        credit = credit + lesson.point.integerValue;
    }
    double GPA = totalScore/credit/20.0;
    [self.gpaLabel setText:[NSString stringWithFormat:@"%.2f",GPA]];
    
}


@end
