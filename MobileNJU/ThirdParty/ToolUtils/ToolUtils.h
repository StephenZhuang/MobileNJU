//
//  ToolUtils.h
//  udows hy
//
//  Created by Stephen Zhuang on 14-3-19.
//  Copyright (c) 2014年 ryan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToolUtils : NSObject
@property (nonatomic , strong) NSMutableArray *tagArray;

+ (instancetype) sharedToolUtils;
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;
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
+ (NSURL *)getImageUrlWtihString:(NSString *)urlString;
+ (NSURL *)getImageUrlWtihString:(NSString *)urlString width:(CGFloat)width height:(CGFloat)height;
+ (NSString *)getHeadImg;
+ (void)setHeadImg:(NSString *)headImg;


+ (BOOL) firstLogin:(NSString*) userId;
+ (void)setHasLogined:(NSString*) userId;


+ (NSString*)getTags;
+ (NSString*)getBirthday;
+ (NSString*)getBelong;
+ (NSString*)getSex;
+ (NSString*)getNickName;
+ (NSString*)getUserName;
+(NSInteger)getFlowerCount;
+(NSString*)getPhoneNum;
+(void)setPhoneNum:(NSString*)phoneNum;
+(void) setUserName:(NSString*)username;
+(void) setFlowerCount:(NSInteger)flowerCount;
+(void) setNickname:(NSString*)nickName;
+ (void)setBirthday:(NSString*)birthday;
+ (void)setSex:(NSString*)sex;
+ (void)setTags:(NSString*)tags;
+ (void)setBelong:(NSString*)belong;
+(void)setPassword:(NSString*)password;
+(NSString*)getPassword;
+ (NSString *)getPushid;
+ (NSString*)getSchId;
+ (void) setSchId:(NSString*) schId;
+(void)setJWId:(NSString*)jwId;
+(NSString*)getJWID;
+(NSString*)getJWPassword;
+(NSString*)getEcardId;
+(NSString*)getEcardPassword;
+(void)setEcardId:(NSString*) ecardId;
+(void)setEcardPassword:(NSString*) password;
+(void)setJWPassword:(NSString*)password;
+(void)setCurrentWeek:(int)week;
+(void)setMySchedule:(NSArray*)schedule;
+(NSArray*)getMySchedule;
+(NSInteger)getCurrentWeek;
+(NSArray*)getTermList;
+(void)setTermList:(NSArray*)termList;
+ (NSInteger)getIsVeryfy;
+(void)setIsVeryfy:(NSInteger)verify;
+ (NSString*)getAccount;
+ (void)setAccount:(NSString*)account;
+ (void)setButtonImage:(NSArray*)buttonImage;
+ (NSArray*)getButtonImage;
+ (void)setFunctionNames:(NSArray*)functionName;
+ (NSArray*)getFunctionName;
+ (void)setFunctionDetails:(NSArray*)details;
+ (NSArray*)getFunctionDetails;
+ (BOOL)compareArray:(NSArray*)oldArray newArray:(NSArray*)newArray;
+ (void)setImgList:(NSArray*)imgList;
+ (NSArray*)getImgList;
+(void)setLibraryId:(NSString*)libId;
+(NSString*)getLibraryId;
+(void)setLibraryPassword:(NSString*)password;
+(NSString*)getLibraryPassword;
+(void)setHasLogOut:(NSString*) hasLogout;
+(NSString*)getHasLogOut;
+(void)setScheduleAuto:(BOOL) isAuto;
                        +(BOOL)getScheduleAuto;
@end
