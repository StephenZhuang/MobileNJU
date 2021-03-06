//
//  ApiMTermList
//
//  Created by ryan on 2014-08-06 14:28:21
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"

#import "ZsndSystem.pb.h"

@interface ApiMTermList : ApiUpdate


	/**
	 *  获取学期列表  /mobile?methodno=MTermList&debug=1&deviceid=1&userid=&verify=&account=&password=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MTermList_Builder
	 * @param code * 第一次登录时不需要，如果有验证码，则第二次请求时必须
	 * @param account * account
	 * @param password * password
	 * @param isReInput * 是否是用户重新输入
	 * @param isV * 该用户是否已验证
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  code:(NSString*)code account:(NSString*)account password:(NSString*)password isreinput:(double)isReInput isv:(double)isV;
	/**
	 *  获取学期列表  /mobile?methodno=MTermList&debug=1&deviceid=1&userid=&verify=&account=&password=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param code * 第一次登录时不需要，如果有验证码，则第二次请求时必须
	 * @param account * account
	 * @param password * password
	 * @param isReInput * 是否是用户重新输入
	 * @param isV * 该用户是否已验证
	 * @callback MTermList_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  code:(NSString*)code account:(NSString*)account password:(NSString*)password isreinput:(double)isReInput isv:(double)isV;

@end
