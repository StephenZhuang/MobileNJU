//
//  Son2Json.h
//  Iso_Frame
//
//  Created by lu liu on 12-12-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Son.h"
#import "JsonData.h"

@interface Son2Json : Son

- (void) build:(NSData*)ins method:(NSString*)method md5:(NSString*)buildMd5 build:(JsonData*)build encode:(NSStringEncoding)encode;

-(void)setBuild:(JsonData*)build;
-(NSObject*)getBuild;
@end
