//
//  weekCellDelegate.h
//  MobileNJU
//
//  Created by luck-mac on 14-7-31.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol weekCellDelegate <NSObject>
- (void)chooseWeek:(NSInteger)num select:(BOOL)select;
@end
