//
//  InitUrl.h
//  protobufTest
//
//  Created by lu liu on 12-7-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InitUrl : NSObject

-(InitUrl*)init:(NSString*)url :(NSString*)className :(int)type errortype:(int)errorype;

-(void)setUrl:(NSString*)url;

-(void)setClassName:(NSString*)className;

-(void)setType:(int)type;

-(void)setErrortype:(int)errorype;

-(NSString*)getUrl;

-(NSString*)getClassName;

-(int)getType;

-(int)getErrortype;

-(void)setEncode:(NSStringEncoding)encode;

-(NSStringEncoding)getEncode;

-(void)setUpEncode:(NSStringEncoding)encode;

-(NSStringEncoding)getUpEncode;

-(BOOL)hasEncode;
@end
