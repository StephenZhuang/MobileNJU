//
//  DetailView.h
//  MobileNJU
//
//  Created by Stephen Zhuang on 14-6-13.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZsndTreehole.pb.h"

typedef void(^DetailBlock)(void);

@interface DetailView : UIView
@property (nonatomic , strong) IBOutlet UILabel *titleLabel;
@property (nonatomic , strong) IBOutlet UILabel *timeLabel;
@property (nonatomic , strong) IBOutlet UILabel *contentLabel;
@property (nonatomic , strong) IBOutlet UIButton *zanButton;
@property (nonatomic , strong) IBOutlet UIButton *commentButton;
@property (nonatomic , strong) NSMutableArray *imageArray;
@property (nonatomic , copy) DetailBlock detailBlcok;
- (void)setTopic:(MTopic_Builder *)topic;
@end
