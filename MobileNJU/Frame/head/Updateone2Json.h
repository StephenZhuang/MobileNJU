//
//  Updateone2Json.h
//  Iso_Frame
//
//  Created by lu liu on 12-12-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JsonData.h"
#import "UpdateOne.h"

@interface Updateone2Json : UpdateOne
-(id)init;

-(id)init:(NSString*)nid params:(NSArray*)postdata;

-(id)init:(NSString*)nid params:(NSArray*)postdata type:(int)type;

-(id)init:(NSString*)nid params:(NSArray*)postdata delegate:(id)ndelegate;

-(id)init:(NSString*)nid params:(NSArray*)postdata type:(int)type jsondata:(JsonData*)build;

-(id)init:(NSString*)nid params:(NSArray*)postdata type:(int)type delegate:(id)ndelegate;

-(id)init:(NSString*)nid params:(NSArray*)postdata type:(int)type jsondata:(JsonData*)build delegate:(id)ndelegate;


-(id)init:(NSString*)nid params:(NSArray*)postdata selecter:(SEL) selecter;

-(id)init:(NSString*)nid params:(NSArray*)postdata type:(int)type selecter:(SEL) selecter;

-(id)init:(NSString*)nid params:(NSArray*)postdata delegate:(id)ndelegate selecter:(SEL) selecter;

-(id)init:(NSString*)nid params:(NSArray*)postdata type:(int)type jsondata:(JsonData*)build selecter:(SEL) selecter;

-(id)init:(NSString*)nid params:(NSArray*)postdata type:(int)type delegate:(id)ndelegate selecter:(SEL) selecter;

-(id)init:(NSString*)nid params:(NSArray*)postdata type:(int)type jsondata:(JsonData*)build delegate:(id)ndelegate selecter:(SEL) selecter;

@end
