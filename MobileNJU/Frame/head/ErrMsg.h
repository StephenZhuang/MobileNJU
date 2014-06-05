//
//  ErrMsg.h
//  protobufTest
//
//  Created by lu liu on 12-7-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ErrMsg : NSObject

-(ErrMsg*)init:(NSString *)Value type:(int)type msg:(NSString*)msg;

-(void)setValue:(NSString*)value;

-(void)setType:(int)type;

-(NSString*)getValue;

-(int)getType;
    
-(NSString*)getMsg;
    
-(void)setMsg:(NSString*)msg;

@end
