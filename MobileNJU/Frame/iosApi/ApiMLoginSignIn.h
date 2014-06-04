//
//  ApiMLoginSignIn
//
//  Created by ryan on 2014-06-04 18:30:34
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"


@interface ApiMLoginSignIn : ApiUpdate


	/**
	 *  打卡登录
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MRet_Builder
	 * @param account * 学号
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  account:(NSString*)account;
	/**
	 *  打卡登录
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param account * 学号
	 * @callback MRet_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  account:(NSString*)account;

@end
