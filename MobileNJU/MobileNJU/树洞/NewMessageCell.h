//
//  NewMessageCell.h
//  MobileNJU
//
//  Created by Stephen Zhuang on 14-6-6.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HBCoreLabel.h"

@interface NewMessageCell : UITableViewCell
@property (nonatomic , strong) IBOutlet UILabel *titleLabel;
@property (nonatomic , strong) IBOutlet HBCoreLabel *contentLabel;
@end
