//
//  MLog.h
//  Iso_Frame
//
//  Created by lu liu on 12-9-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MLog : NSObject

+(void)Log:(NSString*)str obj:(NSObject*)obj;

+(void)Log:(NSString*)str obj:(NSObject*)obj obj2:(NSObject*)obj2;

@end
