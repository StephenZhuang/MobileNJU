//
//  ApiMAddChat
//
//  Created by ryan on 2014-08-06 14:28:21
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"

#import "ZsndSystem.pb.h"

@interface ApiMAddChat : ApiUpdate


	/**
	 *  添加聊天(MImg)  /mobile?methodno=MAddChat&debug=1&appid=nju&deviceid=1&userid=1&verify=1&id=&content=&topicid=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MChat_Builder
	 * @param id * 聊天对象id
	 * @param topicid * 话题id
	 * @param content  文字
	 * @param image  null
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  id:(NSString*)id topicid:(NSString*)topicid content:(NSString*)content image:(MImg_Builder*) image;
	/**
	 *  添加聊天(MImg)  /mobile?methodno=MAddChat&debug=1&appid=nju&deviceid=1&userid=1&verify=1&id=&content=&topicid=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param id * 聊天对象id
	 * @param topicid * 话题id
	 * @param content  文字
	 * @param image  null
	 * @callback MChat_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  id:(NSString*)id topicid:(NSString*)topicid content:(NSString*)content image:(MImg_Builder*) image;

@end
