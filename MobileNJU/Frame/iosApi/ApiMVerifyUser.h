//
//  ApiMVerifyUser
//
//  Created by ryan on 2014-06-04 18:30:33
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"


@interface ApiMVerifyUser : ApiUpdate


	/**
	 * 用户身份认证
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MRet_Builder
	 * @param num * 学号
	 * @param pwd * 密码
	 * @param code  验证码
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  num:(NSString*)num pwd:(NSString*)pwd code:(NSString*)code;
	/**
	 * 用户身份认证
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param num * 学号
	 * @param pwd * 密码
	 * @param code  验证码
	 * @callback MRet_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  num:(NSString*)num pwd:(NSString*)pwd code:(NSString*)code;

@end