//
//  DES.h
//  protobufTest
//
//  Created by lu liu on 12-7-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@interface mDES : NSObject

+ (NSData *) doCipher:(NSData*)sTextIn key:(NSString *)sKey context:(CCOperation)encryptOrDecrypt;
+ (NSData *) encryptStr:(NSData*) str;
+ (NSData *) decryptStr:(NSData*) str;


@end
