//
//  Http2Json.h
//  Iso_Frame
//
//  Created by lu liu on 12-12-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JsonData.h"

@interface Http2Json : IntenetRead

-(void)post:(NSString*)nid :(NSString*)url :(NSArray*)params :(JsonData*)nbuild delegate:(id)mdelegate :(NSString*)nmethod :(NSString*)nMd5 encode:(NSStringEncoding)encode upencode:(NSStringEncoding)upencode;

@end
