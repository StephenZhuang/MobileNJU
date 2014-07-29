//
//  ApiMChat
//
//  Created by ryan on 2014-07-29 20:12:07
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"


@interface ApiMChat : ApiUpdate


	/**
	 *  南呱详情 /mobile?methodno=MChat&debug=1&appid=nju&deviceid=1&userid=1&verify=1&id=&begin=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MChats_Builder
	 * @param id * 聊天对象id
	 * @param begin * 起始时间
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  id:(NSString*)id begin:(NSString*)begin;
	/**
	 *  南呱详情 /mobile?methodno=MChat&debug=1&appid=nju&deviceid=1&userid=1&verify=1&id=&begin=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param id * 聊天对象id
	 * @param begin * 起始时间
	 * @callback MChats_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  id:(NSString*)id begin:(NSString*)begin;

@end
