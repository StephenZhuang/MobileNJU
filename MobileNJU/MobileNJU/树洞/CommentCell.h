//
//  CommentCell.h
//  MobileNJU
//
//  Created by Stephen Zhuang on 14-5-29.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HBCoreLabel.h"
#import "ZsndTreehole.pb.h"

@interface CommentCell : UITableViewCell
//@property (nonatomic , strong) IBOutlet HBCoreLabel *commentLabel;
@property (nonatomic , strong) IBOutlet UILabel *floorLabel;
@property (nonatomic , strong) IBOutlet UILabel *replyLabel;
@property (nonatomic , strong) IBOutlet UILabel *contentLabel;
@property (nonatomic , strong) IBOutlet UILabel *timeLabel;
@property (nonatomic , strong) IBOutlet UIButton *messageButton;
- (void)setComment:(MComment *)comment author:(NSString *)author;
- (CGFloat)matchContent:(MComment *)comment author:(NSString *)author;

+ (CGFloat)getHeightByComment:(MComment *)comment;
@end
