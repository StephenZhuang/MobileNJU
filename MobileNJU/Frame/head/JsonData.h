//
//  JsonData.h
//  Iso_Frame
//
//  Created by lu liu on 12-12-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonData : NSObject

- (id) init:(NSDictionary*)json;

- (void) build:(NSDictionary*)json;

-(int)getError;

-(NSString*)getErrorMsg;

+(NSString*) getJsonString:(NSDictionary*)json key:(NSString*)key;

+(double) getJsonDouble:(NSDictionary *)json key:(NSString *)key;

+(BOOL) getJsonBool:(NSDictionary *)json key:(NSString *)key;

+(int) getJsonInt:(NSDictionary *)json key:(NSString *)key;

+(NSMutableArray*) getJsonArray:(NSArray*)json clas:(NSString*)clas msg:(NSMutableArray*)msg;

+(NSMutableArray*) getJsonArray:(NSDictionary*)json key:(NSString*)key clas:(NSString*)clas msg:(NSMutableArray*)msg;

+(NSMutableArray*) getJsonArray:(NSArray*)json msg:(NSMutableArray*)msg;

+(NSMutableArray*) getJsonArray:(NSDictionary*)json key:(NSString*)key msg:(NSMutableArray*)msg;

+(id)getJsonObject:(NSDictionary *)json clas:(NSString *)clas key:(NSString *)key;
@end
