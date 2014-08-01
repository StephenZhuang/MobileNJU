//
//  WeekCell.h
//  CreateLesson
//
//  Created by luck-mac on 14-7-27.
//  Copyright (c) 2014年 nju.excalibur. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "weekCellDelegate.h"
@interface WeekCell : UIView
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (nonatomic)NSInteger number;
@property (nonatomic)NSInteger select;
@property (nonatomic,strong)id<weekCellDelegate> myDelegate;

- (void)setFlag:(int)flag;


-(void)setNum:(int)num;

@end
