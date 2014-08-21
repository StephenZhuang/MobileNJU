//
//  LoginHelper.m
//  MobileNJU
//
//  Created by luck-mac on 14-8-15.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "LoginHelper.h"

@implementation LoginHelper
static NSString* initUrl = @"http://10.80.34.137/default.aspx";
static NSString* codeUrl = @"http://10.80.34.137/CheckCode.aspx";
static NSString* remainUrl = @"http://10.80.34.137/Web/Student/AccountInfo.aspx";
static NSString* loginUrl = @"http://10.80.34.137/default.aspx";
static NSString* historyUrl = @"http://10.80.34.137/Web/Student/Voucher.aspx";
/*获取验证码*/
- (void) getCodeImage
{
    
//    [self gotoInitWeb];
    NSURL* url = [NSURL URLWithString:codeUrl];
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc]init];
    [request setURL:url];
    [request addValue:@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_2) AppleWebKit/537.75.14 (KHTML, like Gecko) Version/7.0.3 Safari/537.75.14" forHTTPHeaderField:@"User-Agent"];
    [request addValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8" forHTTPHeaderField:@"Accept"];
    [request addValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request setHTTPMethod:@"GET"];
    NSHTTPURLResponse* response ;
    [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response error:nil];
//    UIImage* image = [[UIImage alloc]initWithData:data];
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    for (int i = 0; i < [cookies count]; i++) {
        NSHTTPCookie *cookie = (NSHTTPCookie *)[cookies objectAtIndex:i];
//        NSLog(@"%@,%@",cookie.name,cookie.value);
        if ([cookie.name isEqualToString:@"CheckCode"])
        {
            self.code = cookie.value;
        }
    }
//    NSLog(@"--------------------------");
//    return image;
}

- (NSString*) getHistory:(int)page
{
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?page=%d",historyUrl,page]];
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc]init];
    [request setURL:url];
    [request setHTTPMethod:@"GET"];
    NSHTTPURLResponse *response;
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    NSString *str = [[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
    return str;
    
}

/*登陆*/
- (NSString*)login:(NSString*)userName password:(NSString *)password{
    [self getCodeImage];
    NSString *postString = [NSString stringWithFormat:@"bCheckCode=1&imgBtn.x=96&imgBtn.y=34&returnUrl=Web/Auths/Index.aspx&UserName=%@&UserPwd=%@&InputCode=%@&__EVENTVALIDATION=%@&__VIEWSTATE=%@",userName,password,self.code,@"%2FwEWBQLO0dBIAq%2Bu6rYIAoTOnYUHAsKAo%2FkOArDJ%2FbQC6qjden08ITUO%2FdKQ9HUpHrMqhVM%3D",@"%2FwEPDwULLTEwNDc4NjU1NDZkGAEFHl9fQ29udHJvbHNSZXF1aXJlUG9zdEJhY2tLZXlfXxYBBQZpbWdCdG6NS6KwmwZCH1Dgj4NV2VW%2B2H5jQg%3D%3D"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSString *contentType = [NSString stringWithFormat:@"application/x-www-form-urlencoded"];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    [request setHTTPMethod:@"POST"];
    [request setURL:[NSURL URLWithString:loginUrl]];
    [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    NSHTTPURLResponse *response;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
//    NSString *str = [[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
    NSString* content = [self gotoRemainWeb];
    
    if ( [content rangeOfString:@"手机号码登陆仅支持已在校园卡帐户登记手机号的用户"].length>0)
    {
        return nil;
    } else {
        return content;
    }
//    return [self judgeResult:str];
}


- (NSString*)gotoRemainWeb
{
    NSURL* url = [NSURL URLWithString:remainUrl];
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc]init];
    [request setURL:url];
    [request setHTTPMethod:@"GET"];
    NSHTTPURLResponse *response;
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    NSString *str = [[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
    return str;
}





@end
