//
//  InitConfig.h
//  protobufTest
//
//  Created by lu liu on 12-7-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InitConfig : NSObject

-(id)init;

-(InitUrl*)getUrl:(NSString*)uid;

-(NSString*)getUri;

-(NSString*)getUrl;

-(NSString*)getDUrl;

-(BOOL)getLog;

-(PBGeneratedMessage_Builder*)getRequest:(InitUrl*)url;

-(JsonData*)getJsonRequest:(InitUrl*)url;

-(PBGeneratedMessage*)getGMsg:(NSString*)mid;

-(MsgDialog*)getMsgDialog:(id)mcontext;

-(Loading*)getLoading:(id)mcontext;

-(ErrMsg*)getError:(NSString *)mid msg:(NSString*)msg;

-(NSString*)getTempPath;

-(NSString*)getIconUrl;

-(NSString*)getUurl;

-(NSString*)getStatKey;

-(NSString*)getChannel;

-(MMenu*)getMenu;

-(NSString*)getAppid;

-(NSStringEncoding)getEncode;

@end
