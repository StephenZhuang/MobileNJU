//
//  DataManager.h
//  protobufTest
//
//  Created by lu liu on 12-9-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Son.h"
#import "UpdateOne.h"

@interface DataManager : NSObject

+(void)loadData:(NSArray*)mupdateones delegate:(id)mdelegate;

+(void)removeUpo:(UpdateOne*)upo;

+(void)stopUpo:(id)delegate;
@end
