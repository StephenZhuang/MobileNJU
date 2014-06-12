//
//  ApiMLogin
//
//  Created by ryan on 2014-06-12 13:12:48
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"


@interface ApiMLogin : ApiUpdate


	/**
	 * 登录 /mobile?methodno=MLogin&debug=1&phone=&password=&deviceid=&appid=&pushId=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MUser_Builder
	 * @param phone * 手机号
	 * @param password * 密码(需要加密)
	 * @param pushId * 百度推送的userId
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  phone:(NSString*)phone password:(NSString*)password pushid:(NSString*)pushId;
	/**
	 * 登录 /mobile?methodno=MLogin&debug=1&phone=&password=&deviceid=&appid=&pushId=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param phone * 手机号
	 * @param password * 密码(需要加密)
	 * @param pushId * 百度推送的userId
	 * @callback MUser_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  phone:(NSString*)phone password:(NSString*)password pushid:(NSString*)pushId;

@end
