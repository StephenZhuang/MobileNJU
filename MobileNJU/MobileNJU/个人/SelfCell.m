//
//  SelfCell.m
//  MobileNJU
//
//  Created by luck-mac on 14-5-23.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "SelfCell.h"

@implementation SelfCell
- (void)setImageName:(NSString *)imageName
{
    _imageName = imageName;
    [self.typeLabel setText:imageName];
}

- (void)setContent:(NSString *)content
{
    _content = content;
    [self.contentLabel setText:content];
}
@end
