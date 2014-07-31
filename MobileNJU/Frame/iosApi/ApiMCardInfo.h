//
//  ApiMCardInfo
//
//  Created by ryan on 2014-07-31 17:37:07
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"


@interface ApiMCardInfo : ApiUpdate


	/**
	 *  一卡通余额 /mobile?methodno=MCardInfo&debug=1&deviceid=1&userid=&verify=&account=&password=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MCard_Builder
	 * @param code * 第一次登录时不需要，如果有验证码，则第二次请求时必须
	 * @param account * account
	 * @param password * password
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  code:(NSString*)code account:(NSString*)account password:(NSString*)password;
	/**
	 *  一卡通余额 /mobile?methodno=MCardInfo&debug=1&deviceid=1&userid=&verify=&account=&password=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param code * 第一次登录时不需要，如果有验证码，则第二次请求时必须
	 * @param account * account
	 * @param password * password
	 * @callback MCard_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  code:(NSString*)code account:(NSString*)account password:(NSString*)password;

@end
