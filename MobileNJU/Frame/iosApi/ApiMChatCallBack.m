//
//  ApiMChatCallBack
//
//  Created by ryan on 2014-07-31 17:37:07
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiMChatCallBack.h"

@implementation ApiMChatCallBack


	/**
	 *  南呱呼叫应答 /mobile?methodno=MChatCallBack&debug=1&appid=nju&deviceid=1&userid=1&verify=1&id=&type=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param id * 聊天对象id
	 * @param type * 0:取消 1:接受
	 * @callback MRet_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  id:(NSString*)id type:(double)type {
		NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
		[array addObject:[NSString stringWithFormat:@"id=%@",id==nil?@"":id]];
		[array addObject:[NSString stringWithFormat:@"type=%@",[Frame number2String:type]]];
		UpdateOne *updateone=[[UpdateOne alloc] init:@"MChatCallBack" params:array  delegate:delegate selecter:select];
		return [self instanceUpdate:updateone];
	}

	/**
	 *  南呱呼叫应答 /mobile?methodno=MChatCallBack&debug=1&appid=nju&deviceid=1&userid=1&verify=1&id=&type=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param id * 聊天对象id
	 * @param type * 0:取消 1:接受
	 * @callback MRet_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  id:(NSString*)id type:(double)type {
		UpdateOne *update=[self get:delegate selecter:select id:id type:type];
		[DataManager loadData:[[NSArray alloc]initWithObjects:update,nil] delegate:delegate];
		return update;
	}


@end
