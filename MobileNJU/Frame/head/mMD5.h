//
//  MD5.h
//  protobufTest
//
//  Created by lu liu on 12-7-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@interface mMD5 : NSObject

+ (NSString *) md5:(NSData *)data;

+ (NSString *) md5s:(NSString*)data;

+ (NSString *) md5d:(Byte[])data;

@end
