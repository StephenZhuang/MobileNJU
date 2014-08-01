//
//  ApiMChangePhone
//
//  Created by ryan on 2014-07-31 17:37:07
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"


@interface ApiMChangePhone : ApiUpdate


	/**
	 * 修改账号或密码 /mobile?methodno=MChangePhone&debug=1&deviceid=1&phone=&password=&nickname=&code=&appid=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MUser_Builder
	 * @param phone * 手机号
	 * @param password * 密码(需要加密)
	 * @param nickname * 昵称
	 * @param code * 短信验证码
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  phone:(NSString*)phone password:(NSString*)password nickname:(NSString*)nickname code:(NSString*)code;
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
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  phone:(NSString*)phone password:(NSString*)password nickname:(NSString*)nickname code:(NSString*)code;

@end
