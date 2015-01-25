//
//  CCPHelper.h
//  MobileNJU_2.5
//
//  Created by luck-mac on 14/11/7.
//  Copyright (c) 2014年 nju.excalibur. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCPHelperDelegate.h"
#define BASEURL @"https://sandboxapp.cloopen.com:8883/2013-12-26/Accounts/aaf98f89495b3f38014974ce274b0fab/"
#define MAIN_ACCOUNT @"aaf98f89495b3f38014974ce274b0fab"
#define MAIN_TOKEN @"e229141e5b3b499095a7bb93c34d2005"
#define APP_ID @"aaf98f89495b3f38014974d03faa0fac"
#define SERVER_IP @"sandboxapp.cloopen.com"
#define SERVER_PORT 8883
@interface CCPHelper : NSObject<NSURLConnectionDataDelegate>
- (void) getMainAccount;
- (void) createSubAccount:(NSString*) userId;
-(void) querySubAccount:(NSString*) userId;
@property (nonatomic,strong)NSString* method;
@property (nonatomic,strong) id<CCPHelperDelegate> delegate;
@end
