//
//  ApiMChat
//
//  Created by ryan on 2014-08-06 14:28:21
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"


@interface ApiMChat : ApiUpdate


	/**
	 *  详情 /mobile?methodno=MChat&debug=1&appid=nju&deviceid=1&userid=1&verify=1&id=&begin=&topicid=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MChats_Builder
	 * @param id * 聊天对象id
	 * @param topicid * 话题id
	 * @param begin * 起始时间
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  id:(NSString*)id topicid:(NSString*)topicid begin:(NSString*)begin;
	/**
	 *  详情 /mobile?methodno=MChat&debug=1&appid=nju&deviceid=1&userid=1&verify=1&id=&begin=&topicid=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param id * 聊天对象id
	 * @param topicid * 话题id
	 * @param begin * 起始时间
	 * @callback MChats_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  id:(NSString*)id topicid:(NSString*)topicid begin:(NSString*)begin;

@end
