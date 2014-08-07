//
//  TreeHoleCell.h
//  MobileNJU
//
//  Created by Stephen Zhuang on 14-5-27.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZsndTreehole.pb.h"

@interface TreeHoleCell : UITableViewCell
@property (nonatomic , strong) IBOutlet UIImageView *logoImage;
@property (nonatomic , strong) IBOutlet UIButton *topicButton;
@property (nonatomic , strong) IBOutlet UILabel *contentLabel;
@property (nonatomic , strong) IBOutlet UIButton *zanButton;
@property (nonatomic , strong) IBOutlet UIButton *commentButton;
@property (nonatomic , strong) IBOutlet UIButton *messageButton;
@property (nonatomic , strong) IBOutlet UIButton *moreButton;

+ (CGFloat)getHeightByTopic:(MTopic *)topic;
+ (CGFloat)getDetailHeightByTopic:(MTopic_Builder *)topic;
@end
