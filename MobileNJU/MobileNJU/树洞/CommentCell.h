//
//  CommentCell.h
//  MobileNJU
//
//  Created by Stephen Zhuang on 14-5-29.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FaceAndTextLabel.h"

@interface CommentCell : UITableViewCell
@property (nonatomic , strong) IBOutlet FaceAndTextLabel *commentLabel;
@end
