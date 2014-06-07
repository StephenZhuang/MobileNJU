//
//  ApiMVerifyUser
//
//  Created by ryan on 2014-06-04 18:30:33
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiMVerifyUser.h"

@implementation ApiMVerifyUser


	/**
	 * 用户身份认证
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param num * 学号
	 * @param pwd * 密码
	 * @param code  验证码
	 * @callback MRet_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  num:(NSString*)num pwd:(NSString*)pwd code:(NSString*)code {
		NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
		[array addObject:[NSString stringWithFormat:@"num=%@",num==nil?@"":num]];
		[array addObject:[NSString stringWithFormat:@"pwd=%@",pwd==nil?@"":pwd]];
		[array addObject:[NSString stringWithFormat:@"code=%@",code==nil?@"":code]];
		UpdateOne *updateone=[[UpdateOne alloc] init:@"MVerifyUser" params:array delegate:delegate selecter:select];
		return [self instanceUpdate:updateone];
	}

	/**
	 * 用户身份认证
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param num * 学号
	 * @param pwd * 密码
	 * @param code  验证码
	 * @callback MRet_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  num:(NSString*)num pwd:(NSString*)pwd code:(NSString*)code {
		UpdateOne *update=[self get:delegate selecter:select num:num pwd:pwd code:code];
		[DataManager loadData:[[NSArray alloc]initWithObjects:update,nil] delegate:delegate];
		return update;
	}


@end