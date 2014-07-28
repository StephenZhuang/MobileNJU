//
//  GradeCell.h
//  MobileNJU
//
//  Created by luck-mac on 14-5-26.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GradeCellChooseDelegate.h"
@interface GradeCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIButton *tickButton;
@property (weak, nonatomic) IBOutlet UILabel *lessonNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lessonTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *creditLabel;
@property(nonatomic,assign) id<GradeCellChooseDelegate> delegate;
@property (nonatomic)BOOL isTicked;

- (void) addLineForLabel;
- (void)addBorder;
- (void)setTick:(BOOL)tick;
@end
