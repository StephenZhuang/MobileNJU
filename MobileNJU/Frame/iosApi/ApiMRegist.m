//
//  ApiMRegist
//
//  Created by ryan on 2014-08-06 14:28:21
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiMRegist.h"

@implementation ApiMRegist


	/**
	 * 注册或忘记密码 /mobile?methodno=MRegist&debug=1&deviceid=1&phone=&password=&nickname=&code=&appid=&device=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param phone * 手机号
	 * @param password * 密码(需要加密)
	 * @param nickname * 昵称
	 * @param code * 短信验证码
	 * @param device * 设备类型  android或ios
	 * @callback MUser_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  phone:(NSString*)phone password:(NSString*)password nickname:(NSString*)nickname code:(NSString*)code device:(NSString*)device {
		NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
		[array addObject:[NSString stringWithFormat:@"phone=%@",phone==nil?@"":phone]];
		[array addObject:[NSString stringWithFormat:@"password=%@",password==nil?@"":password]];
		[array addObject:[NSString stringWithFormat:@"nickname=%@",nickname==nil?@"":nickname]];
		[array addObject:[NSString stringWithFormat:@"code=%@",code==nil?@"":code]];
		[array addObject:[NSString stringWithFormat:@"device=%@",device==nil?@"":device]];
		UpdateOne *updateone=[[UpdateOne alloc] init:@"MRegist" params:array  delegate:delegate selecter:select];
		return [self instanceUpdate:updateone];
	}

	/**
	 * 注册或忘记密码 /mobile?methodno=MRegist&debug=1&deviceid=1&phone=&password=&nickname=&code=&appid=&device=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param phone * 手机号
	 * @param password * 密码(需要加密)
	 * @param nickname * 昵称
	 * @param code * 短信验证码
	 * @param device * 设备类型  android或ios
	 * @callback MUser_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  phone:(NSString*)phone password:(NSString*)password nickname:(NSString*)nickname code:(NSString*)code device:(NSString*)device {
		UpdateOne *update=[self get:delegate selecter:select phone:phone password:password nickname:nickname code:code device:device];
		[DataManager loadData:[[NSArray alloc]initWithObjects:update,nil] delegate:delegate];
		return update;
	}


@end
