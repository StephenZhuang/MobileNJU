//
//  TreeHoleListHeader.h
//  MobileNJU
//
//  Created by Stephen Zhuang on 14-6-18.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TreeHoleListHeader : UIView
@property (nonatomic , strong) IBOutlet UIButton *myTreeHoleButton;
@property (nonatomic , strong) IBOutlet UIButton *messageButton;
- (void)setMyTreeHoleButtonHidden;
- (void)setMessageButtonHidden:(BOOL)hidden;
@end
