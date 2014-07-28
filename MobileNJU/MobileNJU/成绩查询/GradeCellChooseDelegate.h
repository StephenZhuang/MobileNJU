//
//  GradeCellChooseDelegate.h
//  MobileNJU
//
//  Created by luck-mac on 14-7-13.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GradeCellChooseDelegate <NSObject>
- (void) chooseLesson:(NSString*)select lesson:(NSString*)lesson;
@end
