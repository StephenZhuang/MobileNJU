//
//  UpdateOne2Top.h
//  Iso_Frame
//
//  Created by ryan on 13-2-22.
//
//

#import <Foundation/Foundation.h>
#import "JsonData.h"
#import "UpdateOne.h"
#import "Son.h"

@interface UpdateOne2Top : UpdateOne
-(id)init;


-(id)init:(NSObject*)postdata type:(int)type build:(JsonData*)build delegate:(id)ndelegate;

-(id)init:(NSObject*)postdata params:(NSMutableDictionary*)params type:(int)type errorType:(int)errortype build:(JsonData*)build delegate:(id)ndelegate;

-(id)init:(NSObject*)postdata build:(JsonData*)build delegate:(id)ndelegate;

-(id)init:(NSObject*)postdata errorType:(int)errortype build:(JsonData*)build delegate:(id)ndelegate;

-(id)init:(NSObject*)postdata type:(int)type build:(JsonData*)build ;

-(id)init:(NSObject*)postdata params:(NSMutableDictionary*)params type:(int)type errorType:(int)errortype build:(JsonData*)build ;

-(id)init:(NSObject*)postdata build:(JsonData*)build;

-(id)init:(NSObject*)postdata errorType:(int)errortype build:(JsonData*)build;

-(id)init:(NSObject*)postdata type:(int)type ;

-(id)init:(NSObject*)postdata params:(NSMutableDictionary*)params type:(int)type errorType:(int)errortype  ;

-(id)init:(NSObject*)postdata ;

-(id)init:(NSObject*)postdata errorType:(int)errortype ;

-(id)init:(NSString*)method fileds:(NSString*)fileds params:(NSMutableDictionary*)params build:(JsonData*)build delegate:(id)ndelegate;

-(id)init:(NSString*)method fileds:(NSString*)fileds params:(NSMutableDictionary*)params build:(JsonData*)build;

-(id)init:(NSString*)method fileds:(NSString*)fileds params:(NSMutableDictionary*)params;

-(id)init:(NSString*)method fileds:(NSString*)fileds params:(NSMutableDictionary*)params type:(int)type errorType:(int)errortype build:(JsonData*)build delegate:(id)ndelegate;

-(void)getSon;

-(void)disposMessage:(Son*)son;
@end
