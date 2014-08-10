//
//  NewMessageCell.h
//  MobileNJU
//
//  Created by Stephen Zhuang on 14-6-6.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HBCoreLabel.h"
#import "SWTableViewCell.h"

@interface NewMessageCell : SWTableViewCell
@property (nonatomic , strong) IBOutlet UILabel *timeLabel;
@property (nonatomic , strong) IBOutlet HBCoreLabel *contentLabel;
@property (nonatomic , strong) IBOutlet UIImageView *logoImage;
@property (nonatomic , strong) IBOutlet UIView *tipView;
@property (nonatomic , strong) IBOutlet UILabel *smallLabel;
@property (nonatomic , strong) IBOutlet UIImageView *topicImage;
@property (weak, nonatomic) IBOutlet UILabel *adminLabel;

@end
