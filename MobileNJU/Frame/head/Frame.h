//
//  Frame.h
//  protobufTest
//
//  Created by lu liu on 12-7-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
//data
#import "InitUrl.h"
#import "ErrMsg.h"
//base
#import "Mrequest.pb.h"
#import "Mretn.pb.h"
//server
#import "Son.h"
#import "IntenetRead.h"
#import "Http2Json.h"
#import "JsonData.h"
//commons
#import "mMD5.h"
#import "mDES.h"
#import "mBase64.h"
#import "MLog.h"
//dialog
#import "MsgDialog.h"
#import "Loading.h"
#import "MMenu.h"
//manage
#import "UpdateOne.h"
#import "Updateone2Json.h"
#import "UpdateOne2Top.h"
#import "DataManager.h"
//frame
#import "InitConfig.h"
#import "UpdateSelf.h"
#import "ApiUpdate.h"
//#import "TopIOSClient.h"
//#import "MobClick.h"

#define APPIDENTIFIER [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleIdentifierKey];
#define APPVERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];

@interface Frame : NSObject{

}

//LOADING_DILOG_DETECTOR
+(id)build;

-(id)init;

+(void)UpdateSelf:(BOOL)hasShow;

+(InitConfig*)INITCONFIG;

+(NSArray*)AUTOADDPARMS;

+(void)close;

+(void)setAutoAddParams:(NSArray*)params;

+(NSDictionary*)LOADINGDETECTOR;

+(void)AddLoading:(NSString*)nid :(int)i;

+(void)AddLoading:(NSString *)nid;

+(int)RemoveLoading:(NSString*)nid :(int)i;

+(int)RemoveLoading:(NSString *)nid;

+(int)getLoadingSize:(NSString*)nid;

+(void)putLoading:(id) obj key:(NSString*)nkey;

+(id)getLoading:(NSString*)nkey;

+(void)deleteLoading:(NSString *)nkey;

+(NSStringEncoding)getEncode:(NSString *)encodestr;

+(NSString*)number2String:(double)number;

+(NSString*)bool2String:(BOOL)bol;

//+(NSString*)getTopUserId;

//+(void)setTopUserId:(NSString*)userid;

//+(TopIOSClient*)getTopIosClient;

//+(void)setTopIosClient:(NSString*)iosclient;

//+(void)statStart:(NSString*)channelid;
//
//+(void)statEvent:(NSString*)event label:(NSString*)label attributes:(NSDictionary *)attributes;
//
//+(void)statEventStart:(NSString *)eventId primarykey:(NSString *)keyName attributes:(NSDictionary *)attributes;
//
//+(void)statEventEnd:(NSString *)eventId primarykey:(NSString *)keyName;

@end
