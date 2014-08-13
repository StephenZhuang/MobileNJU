//
//  ToolUtils.m
//  udows hy
//
//  Created by Stephen Zhuang on 14-3-19.
//  Copyright (c) 2014年 ryan. All rights reserved.
//

#import "ToolUtils.h"

@implementation ToolUtils

+ (instancetype) sharedToolUtils
{
    static id _sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}


+ (BOOL)checkTel:(NSString *)str

{
    
    if ([str length] == 0) {
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"请输入正确的电话号码", nil) message:NSLocalizedString(@"电话号码不能为空", nil) delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        
        return NO;
        
    }
    
    //1[0-9]{10}
    
    //^((13[0-9])|(15[^4,\\D])|(18[0,5-9]))\\d{8}$
    
    //    NSString *regex = @"[0-9]{11}";
    
    NSString *regex = @"^0{0,1}(13[0-9]|15[0-9]|18[0-9])[0-9]{8}|(?:0(?:10|2[0-57-9]|[3-9]\\d{2}))?\\d{7,8}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:str];
    
    if (!isMatch) {
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的电话号码" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        
        return NO;
        
    }
    
    
    
    return YES;
    
}

+ (void)showMessage:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

+ (BOOL)checkTextRange:(NSString *)text min:(NSInteger)min max:(NSInteger)max
{
    if (text.length < min || text.length > max) {
        //        NSString *message = [NSString stringWithFormat:@"长度应在%i-%i位之间", min , max];
        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        //        [alert show];
        return NO;
    } else {
        return YES;
    }
}

+ (BOOL)checkEmail:(NSString *)email
{
    NSString *emailRegex=@"^\\w+((\\-\\w+)|(\\.\\w+))*@[A-Za-z0-9]+((\\.|\\-)[A-Za-z0-9]+)*.[A-Za-z0-9]+$";
    NSPredicate *emailTest=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailRegex];
    BOOL isEmail=[emailTest evaluateWithObject:email];
    return isEmail;
}

+ (NSString *)getLoginId
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"LoginId"];
}

+ (void)setLoginId:(NSString *)loginId
{
    [[NSUserDefaults standardUserDefaults] setObject:loginId forKey:@"LoginId"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//+ (NSString *)getUsername
//{
//    return [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
//}
//
//+ (void)setUsername:(NSString *)username
//{
//    [[NSUserDefaults standardUserDefaults] setObject:username forKey:@"username"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//}
//
//+ (NSString *)getPassword
//{
//    return [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
//}
//
//+ (void)setPassword:(NSString *)password
//{
//    [[NSUserDefaults standardUserDefaults] setObject:password forKey:@"password"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//}

+ (NSString *)getVerify
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"verify"];
}

+ (void)setVerify:(NSString *)verify
{
    [[NSUserDefaults standardUserDefaults] setObject:verify forKey:@"verify"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getDeviceid
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceid"];
}

+ (BOOL)isLogin
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"];
}

+ (void)setIsLogin:(BOOL)isLogin
{
    [[NSUserDefaults standardUserDefaults] setBool:isLogin forKey:@"isLogin"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)hasResume
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"hasResume"];
}

+ (void)setHasResume:(BOOL)hasResume
{
    [[NSUserDefaults standardUserDefaults] setBool:hasResume forKey:@"hasResume"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)isFirstOpen
{
    return ![[NSUserDefaults standardUserDefaults] boolForKey:@"isFirstOpen"];
}

+ (void)setIsFirstOpen:(BOOL)isFirstOpen
{
    [[NSUserDefaults standardUserDefaults] setBool:!isFirstOpen forKey:@"isFirstOpen"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getVersion
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"version"];
}

+ (void)setVersion:(NSString *)version
{
    [[NSUserDefaults standardUserDefaults] setObject:version forKey:@"version"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getHeadImg
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"headImg"];
}

+ (void)setHeadImg:(NSString *)headImg
{
    [[NSUserDefaults standardUserDefaults] setObject:headImg forKey:@"headImg"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)removeUserInfo
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"verify"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"LoginId"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"isLogin"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)checkUrl:(NSString *)url
{
    
    if (url.length >= 4 && [[url substringToIndex:4] isEqualToString:@"http"]) {
        return url;
    } else {
        url = [NSString stringWithFormat:@"http://%@" ,url];
        return url;
    }
}



#pragma mark addedForMobileNJU

+ (NSString*)getNickName
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"nickname"];
    
}
+ (NSString*)getUserName
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"name"];
    
}
+(NSInteger)getFlowerCount
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"flower"];
    
}


+(void) setUserName:(NSString*)username
{
    NSUserDefaults* userDefaults =[NSUserDefaults standardUserDefaults];
    [ userDefaults setObject:username forKey:@"name"];
    [userDefaults synchronize];
}

+ (void)setFlowerCount:(NSInteger)flowerCount
{
    NSUserDefaults* userDefaults =[NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:flowerCount forKey:@"flower"];
    [userDefaults synchronize];
}

+ (NSURL *)getImageUrlWtihString:(NSString *)urlString
{
    if (urlString == nil || [urlString isEqualToString:@""]) {
        return [NSURL URLWithString:@""];
    }
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[[Frame INITCONFIG] getDUrl],urlString]];
}

+ (NSURL *)getImageUrlWtihString:(NSString *)urlString width:(CGFloat)width height:(CGFloat)height
{
    if (urlString == nil || [urlString isEqualToString:@""]) {
        return [NSURL URLWithString:@""];
    }
//    NSLog(@"%@",[NSString stringWithFormat:@"%@%@&w=%.0f&h=%.0f",[[Frame INITCONFIG] getDUrl],urlString , width , height]);
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@&w=%.0f&h=%.0f",[[Frame INITCONFIG] getDUrl],urlString , width , height]];
}


+ (BOOL)firstLogin:(NSString*) userId
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:userId];
}

+ (void)setHasLogined:(NSString*) userId
{
    NSUserDefaults* userDefaults =[NSUserDefaults standardUserDefaults];
    [userDefaults setBool:YES forKey:userId];
    [userDefaults synchronize];
    
}
+ (void)setSex:(NSString *)sex
{
    NSUserDefaults* userDefaults =[NSUserDefaults standardUserDefaults];
    [userDefaults setObject:sex forKey:@"sex"];
    [userDefaults synchronize];
}
+ (void)setBirthday:(NSString *)birthday
{
    NSUserDefaults* userDefaults =[NSUserDefaults standardUserDefaults];
    [userDefaults setObject:birthday forKey:@"birthday"];
    [userDefaults synchronize];
}
+(void)setTags:(NSString *)tags
{
    NSUserDefaults* userDefaults =[NSUserDefaults standardUserDefaults];
    [userDefaults setObject:tags forKey:@"tags"];
    [userDefaults synchronize];
}
+(void)setBelong:(NSString *)belong
{
    NSUserDefaults* userDefaults =[NSUserDefaults standardUserDefaults];
    [userDefaults setObject:belong forKey:@"belong"];
    [userDefaults synchronize];
}
+ (NSString *)getBelong
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"belong"];
}
+ (NSString *)getTags
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"tags"];
}
+ (NSString *)getBirthday
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"birthday"];
}
+ (NSString *)getSex
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"sex"];
}
+ (void)setNickname:(NSString *)nickName
{
    NSUserDefaults* userDefaults =[NSUserDefaults standardUserDefaults];
    [userDefaults setObject:nickName forKey:@"nickname"];
    [userDefaults synchronize];
    
}

+(NSString*)getPhoneNum {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"phone"];
}
+ (void)setPhoneNum:(NSString *)phoneNum
{
    NSUserDefaults* userDefaults =[NSUserDefaults standardUserDefaults];
    [userDefaults setObject:phoneNum forKey:@"phoneNum"];
    [userDefaults synchronize];
    
}

+(void)setPassword:(NSString*)password
{
    NSUserDefaults* userDefaults =[NSUserDefaults standardUserDefaults];
    [userDefaults setObject:password forKey:@"password"];
    [userDefaults synchronize];
    
}

+(NSString *)getPassword
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
}
+ (NSString *)getPushid
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"pushId"];
}
+ (void)setSchId:(NSString *)schId
{
    NSUserDefaults* userDefaults =[NSUserDefaults standardUserDefaults];
    [userDefaults setObject:schId forKey:@"schId"];
    [userDefaults synchronize];
}

+ (NSString *)getSchId
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"schId"];

}

+ (void)setJWId:(NSString *)jwId
{
    NSUserDefaults* userDefaults =[NSUserDefaults standardUserDefaults];
    [userDefaults setObject:jwId forKey:@"jwId"];
    [userDefaults synchronize];

}

+ (void)setJWPassword:(NSString *)password
{
    NSUserDefaults* userDefaults =[NSUserDefaults standardUserDefaults];
    [userDefaults setObject:password forKey:@"jwPassword"];
    [userDefaults synchronize];

}

+ (NSString *)getJWID
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"jwId"];
    

}
+ (NSString *)getJWPassword
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"jwPassword"];
    

}

+ (void)setCurrentWeek:(int)week
{
    NSUserDefaults* userDefaults =[NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:week forKey:@"currentWeek"];
    [userDefaults synchronize];
    

}
+ (NSInteger)getCurrentWeek
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"currentWeek"];
    
}
+(NSArray *)getMySchedule
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"mySchedule"];
    
}
+ (void)setMySchedule:(NSArray *)schedule
{
    NSUserDefaults* userDefaults =[NSUserDefaults standardUserDefaults];
    [userDefaults setObject:schedule  forKey:@"mySchedule"];
    [userDefaults synchronize];
    
}


+(void)setIsVeryfy:(NSInteger)verify
{
    NSUserDefaults* userDefaults =[NSUserDefaults standardUserDefaults];
    [userDefaults setInteger: verify  forKey:@"isVeryfy"];
    [userDefaults synchronize];
    
}
+ (NSInteger)getIsVeryfy
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"isVeryfy"];
}
+ (NSString*)getAccount
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"account"];

}

+ (void)setAccount:(NSString*)account
{
    NSUserDefaults* userDefaults =[NSUserDefaults standardUserDefaults];
    [userDefaults setObject: account  forKey:@"account"];
    [userDefaults synchronize];
}

+(NSString *)getEcardId
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"ecardId"];
}

+(NSString *)getEcardPassword
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"ecardPassword"];
}


+(void)setEcardId:(NSString*) ecardId
{
    NSUserDefaults* userDefaults =[NSUserDefaults standardUserDefaults];
    [userDefaults setObject: ecardId  forKey:@"ecardId"];
    [userDefaults synchronize];
}
+(void)setEcardPassword:(NSString*) password
{
    NSUserDefaults* userDefaults =[NSUserDefaults standardUserDefaults];
    [userDefaults setObject: password  forKey:@"ecardPassword"];
    [userDefaults synchronize];
}
+ (void)setButtonImage:(NSArray *)buttonImage
{
    NSUserDefaults* userDefaults =[NSUserDefaults standardUserDefaults];
    [userDefaults setObject: buttonImage  forKey:@"buttonImage"];
    [userDefaults synchronize];

}
+ (NSArray *)getButtonImage
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"buttonImage"];
}
+ (NSArray *)getFunctionName
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"functionName"];
}
+ (NSArray *)getFunctionDetails
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"functionDetail"];
}
+ (void)setFunctionDetails:(NSArray *)details
{
    NSUserDefaults* userDefaults =[NSUserDefaults standardUserDefaults];
    [userDefaults setObject: details  forKey:@"functionDetail"];
    [userDefaults synchronize];
}
+(void)setFunctionNames:(NSArray *)functionName
{
    NSUserDefaults* userDefaults =[NSUserDefaults standardUserDefaults];
    [userDefaults setObject: functionName  forKey:@"functionName"];
    [userDefaults synchronize];
}
+(BOOL)compareArray:(NSArray *)oldArray newArray:(NSArray *)newArray
{
    for (int i = 0 ; i < oldArray.count; i++) {
        if (![[oldArray objectAtIndex:i] isEqualToString:[newArray objectAtIndex:i]]) {
            return NO;
        }
    }
    return YES;
}

+ (void)setImgList:(NSArray*)imgList;
{
    NSUserDefaults* userDefaults =[NSUserDefaults standardUserDefaults];
    [userDefaults setObject: imgList  forKey:@"newsImg"];
    [userDefaults synchronize];

    
}
+ (NSArray*)getImgList
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"newsImg"];

}

+ (NSString *)getLibraryId
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"libId"];
}

+(NSString*)getLibraryPassword
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"libPassword"];

}

+ (void)setLibraryId:(NSString *)libId
{
    NSUserDefaults* userDefaults =[NSUserDefaults standardUserDefaults];
    [userDefaults setObject: libId  forKey:@"libId"];
    [userDefaults synchronize];
}
+ (void)setLibraryPassword:(NSString *)password
{
    NSUserDefaults* userDefaults =[NSUserDefaults standardUserDefaults];
    [userDefaults setObject: password  forKey:@"libPassword"];
    [userDefaults synchronize];

}

+(void)setHasLogOut:(NSString*) hasLogout
{
    NSUserDefaults* userDefaults =[NSUserDefaults standardUserDefaults];
    [userDefaults setObject: hasLogout  forKey:@"haslogout"];
    [userDefaults synchronize];

}
+(NSString*)getHasLogOut
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"haslogout"];

}

+(void)setScheduleAuto:(BOOL) isAuto
{
    NSUserDefaults* userDefaults =[NSUserDefaults standardUserDefaults];
    [userDefaults setBool: isAuto  forKey:@"scheduleAuto"];
    [userDefaults synchronize];
}
                        


+(BOOL)getScheduleAuto;
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"scheduleAuto"];
}

@end
