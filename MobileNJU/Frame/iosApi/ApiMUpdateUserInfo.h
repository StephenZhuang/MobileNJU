//
//  ApiMUpdateUserInfo
//
//  Created by ryan on 2014-06-18 15:39:59
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"


@interface ApiMUpdateUserInfo : ApiUpdate


	/**
	 * 用户信息修改 /mobile?methodno=MUpdateUserInfo&debug=1&appid=nju&deviceid=1&userid=&verify=&nickname=&belong=&sex=&birthday=tags=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MUser_Builder
	 * @param nickname * 昵称
	 * @param belong * 院系
	 * @param sex * 0:女 1:男
	 * @param birthday * 生日
	 * @param tags  标签(逗号分隔)
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  nickname:(NSString*)nickname belong:(NSString*)belong sex:(double)sex birthday:(NSString*)birthday tags:(NSString*)tags;
	/**
	 * 用户信息修改 /mobile?methodno=MUpdateUserInfo&debug=1&appid=nju&deviceid=1&userid=&verify=&nickname=&belong=&sex=&birthday=tags=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param nickname * 昵称
	 * @param belong * 院系
	 * @param sex * 0:女 1:男
	 * @param birthday * 生日
	 * @param tags  标签(逗号分隔)
	 * @callback MUser_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  nickname:(NSString*)nickname belong:(NSString*)belong sex:(double)sex birthday:(NSString*)birthday tags:(NSString*)tags;

@end
