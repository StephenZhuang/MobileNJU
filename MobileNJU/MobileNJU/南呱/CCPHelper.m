//
//  CCPHelper.m
//  MobileNJU_2.5
//
//  Created by luck-mac on 14/11/7.
//  Copyright (c) 2014年 nju.excalibur. All rights reserved.
//

#import "CCPHelper.h"
#import <CommonCrypto/CommonDigest.h>
#import "GTMBase64.h"
@implementation CCPHelper
- (void) getMainAccount
{
    NSString* timestamp = [self getTimestamp];
    NSString* sig = [self getSig:MAIN_ACCOUNT token:MAIN_TOKEN timestamp:timestamp];
    NSString* urlStr = [NSString stringWithFormat:@"%@AccountInfo?sig=%@",BASEURL,sig];
    NSURL* url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:15];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:[self getMainAuthorization:timestamp] forHTTPHeaderField:@"Authorization"];
    [NSURLConnection connectionWithRequest:request delegate:self];
}

- (void) createSubAccount:(NSString*) userId
{
    if ([userId isEqualToString:[ToolUtils getLoginId]]) {
        _method = @"createSubAccount";
    } else {
        _method = @"createAnotherSubAccount";
    }
    NSString* timestamp = [self getTimestamp];
    NSString* sig = [self getSig:MAIN_ACCOUNT token:MAIN_TOKEN timestamp:timestamp];
    NSString* urlStr = [NSString stringWithFormat:@"%@SubAccounts?sig=%@",BASEURL,sig];
    NSURL* url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:15];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:[self getMainAuthorization:timestamp] forHTTPHeaderField:@"Authorization"];
    NSDictionary* dic = [[NSDictionary alloc]initWithObjectsAndKeys:APP_ID,@"appId",userId,@"friendlyName" ,nil];
    NSError* error;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    NSData* postData = jsonData;
    [request setHTTPBody:postData];
    [NSURLConnection connectionWithRequest:request delegate:self];

}

-(void) querySubAccount:(NSString*) userId
{
    if ([userId isEqualToString:[ToolUtils getLoginId]]) {
        _method = @"querySubAccount";

    } else {
        _method = @"queryAnotherSubAccount";
    }
    NSString* timestamp = [self getTimestamp];
    NSString* sig = [self getSig:MAIN_ACCOUNT token:MAIN_TOKEN timestamp:timestamp];
    NSString* urlStr = [NSString stringWithFormat:@"%@QuerySubAccountByName?sig=%@",BASEURL,sig];
    NSURL* url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:15];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:[self getMainAuthorization:timestamp] forHTTPHeaderField:@"Authorization"];
    NSDictionary* dic = [[NSDictionary alloc]initWithObjectsAndKeys:APP_ID,@"appId",userId,@"friendlyName" ,nil];
    NSError* error;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    NSData* postData = jsonData;
    [request setHTTPBody:postData];
    [NSURLConnection connectionWithRequest:request delegate:self];
}
//根据sid和当前时间字符串获取一个Authorization编码
//- (NSString *)getAuthorization:(NSString *)timestamp
//{
//    NSString *authorizationString = [NSString stringWithFormat:@"%@:%@",self.subAccountSid,timestamp];
//    return [ASIHTTPRequest base64forData:[authorizationString dataUsingEncoding:NSUTF8StringEncoding]];
//}

//根据sid和当前时间字符串获取一个Authorization编码
- (NSString *)getMainAuthorization:(NSString *)timestamp
{
    NSString *authorizationString = [NSString stringWithFormat:@"%@:%@",MAIN_ACCOUNT,timestamp];
    NSData* data = [authorizationString dataUsingEncoding:NSUTF8StringEncoding];
    NSData* encodeData = [GTMBase64 encodeData:data];
    NSString* encodeResult = [[NSString alloc] initWithData:encodeData encoding:NSUTF8StringEncoding];
    return encodeResult;
}


//得到当前时间的字符串
- (NSString *)getTimestamp
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    return currentDateStr;
}

//获取sig编码
- (NSString *)getSig:(NSString*) account  token:(NSString*) token timestamp:(NSString *)timestamp
{
    NSString *sigString = [NSString stringWithFormat:@"%@%@%@", account, token, timestamp];
    const char *cStr = [sigString UTF8String];
	unsigned char result[16];
	CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
	return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],result[8], result[9], result[10], result[11],result[12], result[13], result[14], result[15]];
}



- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (!data) {
        return;
    }
    NSError* error;
    NSDictionary *resultDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    if (resultDict) {
        [_delegate reveiveData:resultDict method:_method];
        NSLog(@"%@",resultDict.description);
    }
}




- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
    NSLog(@"response");
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
}

@end
