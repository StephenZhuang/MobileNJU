//
//  GPAView.h
//  MobileNJU
//
//  Created by luck-mac on 14-5-27.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Lesson.h"
#import "GPAClose.h"
@interface GPAView : UIView
{
    id<GPAClose> myDelegate;
}
@property (nonatomic,strong)NSArray* lessonList;
@property (weak, nonatomic) IBOutlet UILabel *gpaLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
- (void) setDelegate:(id<GPAClose>)delegate;
@end
