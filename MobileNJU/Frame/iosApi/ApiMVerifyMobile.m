//
//  ApiMVerifyMobile
//
//  Created by ryan on 2014-07-31 17:37:07
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiMVerifyMobile.h"

@implementation ApiMVerifyMobile


	/**
	 * 验证手机号 /mobile?methodno=MVerifyMobile&debug=1&deviceid=1&phone=&appid=&code=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param phone * 手机号
	 * @param code * 验证码
	 * @callback MRet_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  phone:(NSString*)phone code:(NSString*)code {
		NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
		[array addObject:[NSString stringWithFormat:@"phone=%@",phone==nil?@"":phone]];
		[array addObject:[NSString stringWithFormat:@"code=%@",code==nil?@"":code]];
		UpdateOne *updateone=[[UpdateOne alloc] init:@"MVerifyMobile" params:array  delegate:delegate selecter:select];
		return [self instanceUpdate:updateone];
	}

	/**
	 * 验证手机号 /mobile?methodno=MVerifyMobile&debug=1&deviceid=1&phone=&appid=&code=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param phone * 手机号
	 * @param code * 验证码
	 * @callback MRet_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  phone:(NSString*)phone code:(NSString*)code {
		UpdateOne *update=[self get:delegate selecter:select phone:phone code:code];
		[DataManager loadData:[[NSArray alloc]initWithObjects:update,nil] delegate:delegate];
		return update;
	}


@end
