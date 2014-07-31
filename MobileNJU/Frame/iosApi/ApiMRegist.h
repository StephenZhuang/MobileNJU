//
//  ApiMRegist
//
//  Created by ryan on 2014-07-31 09:18:59
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"


@interface ApiMRegist : ApiUpdate


	/**
	 * 注册或忘记密码 /mobile?methodno=MRegist&debug=1&deviceid=1&phone=&password=&nickname=&code=&appid=&pushId=&device=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MUser_Builder
	 * @param phone * 手机号
	 * @param password * 密码(需要加密)
	 * @param nickname * 昵称
	 * @param code * 短信验证码
	 * @param pushId * 百度推送的userId
	 * @param device * 设备类型  android或ios
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  phone:(NSString*)phone password:(NSString*)password nickname:(NSString*)nickname code:(NSString*)code pushid:(NSString*)pushId device:(NSString*)device;
	/**
	 * 注册或忘记密码 /mobile?methodno=MRegist&debug=1&deviceid=1&phone=&password=&nickname=&code=&appid=&pushId=&device=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param phone * 手机号
	 * @param password * 密码(需要加密)
	 * @param nickname * 昵称
	 * @param code * 短信验证码
	 * @param pushId * 百度推送的userId
	 * @param device * 设备类型  android或ios
	 * @callback MUser_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  phone:(NSString*)phone password:(NSString*)password nickname:(NSString*)nickname code:(NSString*)code pushid:(NSString*)pushId device:(NSString*)device;

@end
