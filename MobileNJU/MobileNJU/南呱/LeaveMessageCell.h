//
//  LeaveMessageCell.h
//  MobileNJU
//
//  Created by Stephen Zhuang on 14-6-10.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HBCoreLabel.h"

@interface LeaveMessageCell : UITableViewCell
@property (nonatomic , strong) IBOutlet UIImageView *logoImage;
@property (nonatomic , strong) IBOutlet HBCoreLabel *contentLabel;
@property (nonatomic , strong) IBOutlet UIButton *blackListButton;
@property (nonatomic , strong) IBOutlet UIButton *deleteButton;
@property (nonatomic , strong) IBOutlet UILabel *timeLabel;
@property (nonatomic , strong) IBOutlet UIView *hasMessgeView;
@end
