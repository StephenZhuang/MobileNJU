//
//  VerticallyAlignedLabel.h
//  MobileNJU
//
//  Created by luck-mac on 14-7-31.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum VerticalAlignment {
    VerticalAlignmentTop,
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom,
} VerticalAlignment;

@interface VerticallyAlignedLabel : UILabel {
@private
    VerticalAlignment verticalAlignment_;
}

@property (nonatomic, assign) VerticalAlignment verticalAlignment;

@end
