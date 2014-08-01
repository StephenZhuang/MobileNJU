//
//  weekPickerDelegate.h
//  CreateLesson
//
//  Created by luck-mac on 14-7-28.
//  Copyright (c) 2014年 nju.excalibur. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol weekPickerDelegate <NSObject>
- (void) cancel;
- (void) done:(NSArray*) result;
@end
