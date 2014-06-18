//
//  ApiMChat
//
//  Created by ryan on 2014-06-18 15:39:58
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiMChat.h"

@implementation ApiMChat


	/**
	 *  南呱详情 /mobile?methodno=MChat&debug=1&appid=nju&deviceid=1&userid=1&verify=1&id=&begin=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param id * 聊天对象id
	 * @param begin * 起始时间
	 * @callback MChats_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  id:(NSString*)id begin:(NSString*)begin {
		NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
		[array addObject:[NSString stringWithFormat:@"id=%@",id==nil?@"":id]];
		[array addObject:[NSString stringWithFormat:@"begin=%@",begin==nil?@"":begin]];
		UpdateOne *updateone=[[UpdateOne alloc] init:@"MChat" params:array  delegate:delegate selecter:select];
		return [self instanceUpdate:updateone];
	}

	/**
	 *  南呱详情 /mobile?methodno=MChat&debug=1&appid=nju&deviceid=1&userid=1&verify=1&id=&begin=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param id * 聊天对象id
	 * @param begin * 起始时间
	 * @callback MChats_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  id:(NSString*)id begin:(NSString*)begin {
		UpdateOne *update=[self get:delegate selecter:select id:id begin:begin];
		[DataManager loadData:[[NSArray alloc]initWithObjects:update,nil] delegate:delegate];
		return update;
	}


@end
