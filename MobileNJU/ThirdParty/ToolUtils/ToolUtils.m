//
//  ToolUtils.m
//  udows hy
//
//  Created by Stephen Zhuang on 14-3-19.
//  Copyright (c) 2014年 ryan. All rights reserved.
//

#import "ToolUtils.h"

@implementation ToolUtils

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
    
    NSString *regex = @"^0{0,1}(13[0-9]|15[1-9]|18[1-9])[0-9]{8}|(?:0(?:10|2[0-57-9]|[3-9]\\d{2}))?\\d{7,8}$";
    
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

+ (NSDictionary*) getUserInfo
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"selfInfo" ofType:@"plist"];
    NSDictionary *data = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    NSArray* keys = [data objectForKey:@"infoKeys"];
    NSMutableArray* values = [[NSMutableArray alloc]init];
    for (NSString* key in keys) {
        NSString* value =[userDefaults objectForKey:key];
        if (!value) {
            value = [NSString stringWithFormat:@""];
        }
        [values addObject:value];
    }
    NSDictionary* info = [[NSDictionary alloc]initWithObjects:values forKeys:keys];
    return info;
}


+ (void)setUserInfo:(NSDictionary*)dic
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    for (NSString* key in dic.keyEnumerator) {
        [userDefaults setObject:[dic objectForKey:key] forKey:key];
    }
    [userDefaults synchronize];
}

+ (NSString*)getNickName
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"nickname"];

}
+ (NSString*)getUserName
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"name"];

}
+(NSString*)getFlowerCount
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"flower"];

}


+(void) setUserName:(NSString*)username
{
    NSUserDefaults* userDefaults =[NSUserDefaults standardUserDefaults];
    [ userDefaults setObject:username forKey:@"name"];
    [userDefaults synchronize];
}
+(void) addFlowerCount;
{
    NSNumber* flowerCount =  [[NSUserDefaults standardUserDefaults] objectForKey:@"flower"];
    if (!flowerCount) {
        flowerCount = [[NSNumber alloc]initWithInt:1];
    } else {
        int count = flowerCount.intValue+1;
        flowerCount = [[NSNumber alloc]initWithInt:count];
    }
    NSUserDefaults* userDefaults =[NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:flowerCount forKey:@"flower"];
    [userDefaults synchronize];

}
@end
