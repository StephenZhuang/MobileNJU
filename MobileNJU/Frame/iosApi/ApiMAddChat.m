//
//  ApiMAddChat
//
//  Created by ryan on 2014-08-06 14:28:21
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiMAddChat.h"

@implementation ApiMAddChat


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
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  id:(NSString*)id topicid:(NSString*)topicid content:(NSString*)content image:(MImg_Builder*) image {
		NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
		[array addObject:[NSString stringWithFormat:@"id=%@",id==nil?@"":id]];
		[array addObject:[NSString stringWithFormat:@"topicid=%@",topicid==nil?@"":topicid]];
		[array addObject:[NSString stringWithFormat:@"content=%@",content==nil?@"":content]];
		UpdateOne *updateone=[[UpdateOne alloc] init:@"MAddChat" params:array  postparams:image delegate:delegate selecter:select];
		return [self instanceUpdate:updateone];
	}

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
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  id:(NSString*)id topicid:(NSString*)topicid content:(NSString*)content image:(MImg_Builder*) image {
		UpdateOne *update=[self get:delegate selecter:select id:id topicid:topicid content:content image:image];
		[DataManager loadData:[[NSArray alloc]initWithObjects:update,nil] delegate:delegate];
		return update;
	}


@end
