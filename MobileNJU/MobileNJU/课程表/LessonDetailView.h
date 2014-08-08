//
//  LessonDetailView.h
//  MobileNJU
//
//  Created by luck-mac on 14-5-30.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlertCloseDelegate.h"
#import "ScheduleLesson.h"
@interface LessonDetailView : UIView<UIAlertViewDelegate>


{
    id<AlertCloseDelegate> myDelegate;
}
-(void)setMydelegate:(id<AlertCloseDelegate>) delegate;
@property (weak, nonatomic) IBOutlet UILabel *lessonName;
@property (weak, nonatomic) IBOutlet UILabel *teacher;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UILabel *week;
@property (strong,nonatomic)ScheduleLesson* lesson;
@property (nonatomic,strong)NSString* id;
@property (nonatomic)CGRect adjustFrame;
- (void) adjust;
@end
