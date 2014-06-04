//
//  Son.h
//  protobufTest
//
//  Created by lu liu on 12-7-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProtocolBuffers.h"
#import "Mretn.pb.h"
#import "Mrequest.pb.h"
#import "mDES.h"

@interface Son : NSObject

- (void) build:(int)error :(NSString*)msg :(NSString*)method;
- (void) build:(NSData*)ins :(NSString*)method :(NSString*)buildMd5 :(PBGeneratedMessage_Builder*)build;

-(void)setMethod:(NSString*)method;
-(void)setError:(int)error;
-(void)setMsg:(NSString*)msg;
-(void)setServerMethod:(NSString*)getmethod;
-(void)setBuild:(PBGeneratedMessage_Builder*)build;

-(NSString*)getMethod;
-(int)getError;
-(NSString*)getMsg;
-(NSString*)getServerMethod;
-(PBGeneratedMessage_Builder*)getBuild;

-(id)getParam:(NSString*)key;
-(void)setParams:(NSDictionary*)dictionary;

-(void)setErrorType:(int)error;
-(int)getErrorType;

-(void)setSubMsg:(NSString*)submsg;
-(NSString*)getSubMsg;

@end
