//
//  ExerciseCell.h
//  MobileNJU
//
//  Created by luck-mac on 14-5-24.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExerciseCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *recordId;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *startTime;
@property (weak, nonatomic) IBOutlet UILabel *endTime;
@end
