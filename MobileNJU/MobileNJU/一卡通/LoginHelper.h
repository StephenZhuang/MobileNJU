//
//  LoginHelper.h
//  MobileNJU
//
//  Created by luck-mac on 14-8-15.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginHelper : NSObject

@property (nonatomic,strong)NSString* code;
- (NSString*)login :(NSString*) userName password:(NSString*)password;
- (NSString*) getHistory:(int)page;
@end
