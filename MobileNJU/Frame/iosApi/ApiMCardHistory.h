//
//  ApiMCardHistory
//
//  Created by ryan on 2014-07-29 20:12:07
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"

#import "ZsndTreehole.pb.h"

@interface ApiMCardHistory : ApiUpdate


	/**
	 *  一卡通消费记录  /mobile?methodno=MCardHistory&debug=1&deviceid=1&userid=&verify=&begin=&end=&account=&password=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MCardList_Builder
	 * @param begin * 起始
	 * @param end * 结束
	 * @param code * 第一次登录时不需要，如果有验证码，则第二次请求时必须
	 * @param isReInput * 是否是用户重新输入
	 * @param isV * 该用户是否已验证
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  begin:(NSString*)begin end:(NSString*)end code:(NSString*)code isreinput:(double)isReInput isv:(double)isV;
	/**
	 *  一卡通消费记录  /mobile?methodno=MCardHistory&debug=1&deviceid=1&userid=&verify=&begin=&end=&account=&password=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param begin * 起始
	 * @param end * 结束
	 * @param code * 第一次登录时不需要，如果有验证码，则第二次请求时必须
	 * @param isReInput * 是否是用户重新输入
	 * @param isV * 该用户是否已验证
	 * @callback MCardList_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  begin:(NSString*)begin end:(NSString*)end code:(NSString*)code isreinput:(double)isReInput isv:(double)isV;

@end
