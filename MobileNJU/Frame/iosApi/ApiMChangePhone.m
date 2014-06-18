//
//  ApiMChangePhone
//
//  Created by ryan on 2014-06-18 15:39:59
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiMChangePhone.h"

@implementation ApiMChangePhone


	/**
	 * 修改账号或密码 /mobile?methodno=MChangePhone&debug=1&deviceid=1&phone=&password=&nickname=&code=&appid=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param phone * 手机号
	 * @param password * 密码(需要加密)
	 * @param nickname * 昵称
	 * @param code * 短信验证码
	 * @callback MUser_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  phone:(NSString*)phone password:(NSString*)password nickname:(NSString*)nickname code:(NSString*)code {
		NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
		[array addObject:[NSString stringWithFormat:@"phone=%@",phone==nil?@"":phone]];
		[array addObject:[NSString stringWithFormat:@"password=%@",password==nil?@"":password]];
		[array addObject:[NSString stringWithFormat:@"nickname=%@",nickname==nil?@"":nickname]];
		[array addObject:[NSString stringWithFormat:@"code=%@",code==nil?@"":code]];
		UpdateOne *updateone=[[UpdateOne alloc] init:@"MChangePhone" params:array  delegate:delegate selecter:select];
		return [self instanceUpdate:updateone];
	}

	/**
	 * 修改账号或密码 /mobile?methodno=MChangePhone&debug=1&deviceid=1&phone=&password=&nickname=&code=&appid=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param phone * 手机号
	 * @param password * 密码(需要加密)
	 * @param nickname * 昵称
	 * @param code * 短信验证码
	 * @callback MUser_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  phone:(NSString*)phone password:(NSString*)password nickname:(NSString*)nickname code:(NSString*)code {
		UpdateOne *update=[self get:delegate selecter:select phone:phone password:password nickname:nickname code:code];
		[DataManager loadData:[[NSArray alloc]initWithObjects:update,nil] delegate:delegate];
		return update;
	}


@end
