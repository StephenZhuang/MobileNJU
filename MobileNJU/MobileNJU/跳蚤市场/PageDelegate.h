//
//  PageDelegate.h
//  MobileNJU
//
//  Created by luck-mac on 14-7-30.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PageDelegate <NSObject>
- (void) showView:(UIViewController*)view;
@end
