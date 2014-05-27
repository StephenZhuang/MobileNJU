//
//  NSString+unicode.h
//  MobileNJU
//
//  Created by Stephen Zhuang on 14-5-27.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (unicode)
- (NSString*)replaceUnicode;
- (NSString *)utf8ToUnicode;
@end
