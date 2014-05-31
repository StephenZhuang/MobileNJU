//
//  GPAView.h
//  MobileNJU
//
//  Created by luck-mac on 14-5-27.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Lesson.h"
#import "AlertCloseDelegate.h"
@interface GPAView : UIView
{
    id<AlertCloseDelegate> myDelegate;
}
- (void) setDelegate:(id<AlertCloseDelegate>)delegate;

@property (nonatomic,strong)NSArray* lessonList;
@property (weak, nonatomic) IBOutlet UILabel *gpaLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@end
