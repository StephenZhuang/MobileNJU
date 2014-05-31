//
//  BookChooseDelegate.h
//  MobileNJU
//
//  Created by luck-mac on 14-5-27.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Book.h"
@protocol BookChooseDelegate <NSObject>
- (void) chooseBook:(Book*) book;
@end
