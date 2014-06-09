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
@property (nonatomic , strong) IBOutlet HBCoreLabel *commentLabel;
- (void)setComment:(MComment *)comment;
- (CGFloat)matchContent:(MComment *)comment;
@end
