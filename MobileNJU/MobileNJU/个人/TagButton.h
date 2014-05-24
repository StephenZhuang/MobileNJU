//
//  TagButton.h
//  MobileNJU
//
//  Created by luck-mac on 14-5-24.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TagButton : UIButton
@property (nonatomic,strong)NSString* tagContent;
- (void)setChoose:(BOOL)choose;
@end
