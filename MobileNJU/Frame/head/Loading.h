//
//  Loading.h
//  protobufTest
//
//  Created by lu liu on 12-7-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UpdateOne.h"

@interface Loading : NSObject

-(id)init:(id)context;

+(id)build:(id)ncontext;

-(void)show;

-(void)dismiss;

-(id)getContext;

-(void)addUpdateOne:(UpdateOne *) upon;

-(void)stop;
@end
