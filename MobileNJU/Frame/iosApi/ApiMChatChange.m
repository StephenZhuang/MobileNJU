//
//  ApiMChatChange
//
//  Created by ryan on 2014-06-18 15:39:59
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiMChatChange.h"

@implementation ApiMChatChange


	/**
	 *  南呱换人 /mobile?methodno=MChatChange&debug=1&appid=nju&deviceid=1&userid=1&verify=1&id=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param id * 聊天对象id
	 * @callback MRet_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  id:(NSString*)id {
		NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
		[array addObject:[NSString stringWithFormat:@"id=%@",id==nil?@"":id]];
		UpdateOne *updateone=[[UpdateOne alloc] init:@"MChatChange" params:array  delegate:delegate selecter:select];
		return [self instanceUpdate:updateone];
	}

	/**
	 *  南呱换人 /mobile?methodno=MChatChange&debug=1&appid=nju&deviceid=1&userid=1&verify=1&id=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param id * 聊天对象id
	 * @callback MRet_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  id:(NSString*)id {
		UpdateOne *update=[self get:delegate selecter:select id:id];
		[DataManager loadData:[[NSArray alloc]initWithObjects:update,nil] delegate:delegate];
		return update;
	}


@end
