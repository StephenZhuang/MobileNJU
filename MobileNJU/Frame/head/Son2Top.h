//
//  Son2Top.h
//  Iso_Frame
//
//  Created by ryan on 13-2-22.
//
//

#import <Foundation/Foundation.h>
#import "Son.h"
#import "JsonData.h"
#import "TopApiResponse.h"

@interface Son2Top : Son

- (void) build:(int)error msg:(NSString*)msg method:(NSString*)method build:(JsonData*)build;

-(void)build:(TopApiResponse*) response method:(NSString*)method md5:(NSString*)md5 build:(JsonData*)build map:(NSDictionary*)mapParams;

-(void)setBuild:(JsonData*)build;

-(NSObject*)getBuild;
@end
