//
//  MMenu.h
//  protobufTest
//
//  Created by lu liu on 12-7-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMenu : NSObject <NSURLConnectionDelegate>

-(void)post:(NSString*)nid :(NSString*)url :(PBGeneratedMessage_Builder*)build :(PBGeneratedMessage_Builder*)nbuild delegate:(id)mdelegate :(NSString*)nmethod :(NSString*)nMd5;

-(void)stop;

@end
