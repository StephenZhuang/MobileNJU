//
//  ToolUtils.h
//  udows hy
//
//  Created by Stephen Zhuang on 14-3-19.
//  Copyright (c) 2014年 ryan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToolUtils : NSObject
+ (BOOL)checkTel:(NSString *)str;
+ (BOOL)checkEmail:(NSString *)email;
+ (void)showMessage:(NSString *)message;
+ (BOOL)checkTextRange:(NSString *)text min:(NSInteger)min max:(NSInteger)max;
+ (NSString *)getLoginId;
+ (void)setLoginId:(NSString *)loginId;
//+ (NSString *)getUsername;
//+ (void)setUsername:(NSString *)username;
//+ (NSString *)getPassword;
//+ (void)setPassword:(NSString *)password;
+ (BOOL)isLogin;
+ (void)setIsLogin:(BOOL)isLogin;
+ (BOOL)isFirstOpen;
+ (void)setIsFirstOpen:(BOOL)isFirstOpen;
+ (NSString *)getVersion;
+ (void)setVersion:(NSString *)version;
+ (NSString *)checkUrl:(NSString *)url;
+ (BOOL)hasResume;
+ (void)setHasResume:(BOOL)hasResume;
+ (void)removeUserInfo;


+ (NSString *)getVerify;
+ (void)setVerify:(NSString *)verify;
+ (NSString *)getDeviceid;
//+ (NSURL *)getImageUrlWtihString:(NSString *)urlString;
+ (NSString *)getHeadImg;
+ (void)setHeadImg:(NSString *)headImg;



+ (NSDictionary*) getUserInfo;
+ (void)setUserInfo:(NSDictionary*)dic;

+ (NSString*)getNickName;
+ (NSString*)getUserName;
+(NSString*)getFlowerCount;


+(void) setUserName:(NSString*)username;
+(void) addFlowerCount;

@end
