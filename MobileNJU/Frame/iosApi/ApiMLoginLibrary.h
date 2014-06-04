//
//  ApiMLoginLibrary
//
//  Created by ryan on 2014-06-04 18:30:33
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"


@interface ApiMLoginLibrary : ApiUpdate


	/**
	 *  图书馆登录 
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MRet_Builder
	 * @param account * 学号
	 * @param password * 密码
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  account:(NSString*)account password:(NSString*)password;
	/**
	 *  图书馆登录 
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param account * 学号
	 * @param password * 密码
	 * @callback MRet_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  account:(NSString*)account password:(NSString*)password;

@end
