//
//  CheckViewController.h
//  MobileNJU
//
//  Created by Stephen Zhuang on 14-6-7.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^CheckBlock)(void);

@interface CheckViewController : BaseViewController
@property (nonatomic , copy) CheckBlock checkBlock;
@end
