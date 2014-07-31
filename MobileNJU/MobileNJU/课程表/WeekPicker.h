//
//  WeekPicker.h
//  CreateLesson
//
//  Created by luck-mac on 14-7-27.
//  Copyright (c) 2014年 nju.excalibur. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "weekPickerDelegate.h"
#import "weekCellDelegate.h"

@interface WeekPicker : UIView<weekCellDelegate>
@property (nonatomic,strong) NSArray *weekButtons;
@property (weak, nonatomic) IBOutlet UIView *chooseArea;
@property (weak, nonatomic) IBOutlet UIButton *chooseSingleBt;
@property (weak, nonatomic) IBOutlet UIButton *chooseDoubleBt;
@property (weak, nonatomic) IBOutlet UIButton *chooseAllBt;
@property (nonatomic) id<weekPickerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;
- (void)addWeek;
@end
