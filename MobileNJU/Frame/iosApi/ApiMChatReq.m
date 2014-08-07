//
//  ApiMChatReq
//
//  Created by ryan on 2014-08-06 14:28:21
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiMChatReq.h"

@implementation ApiMChatReq


	/**
	 *  树洞发起会话 /mobile?methodno=MChatReq&debug=1&appid=nju&deviceid=1&userid=1&verify=1&targetid=&topicid=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param targetid * 聊天对象id
	 * @param topicid * 树洞id
	 * @callback MView_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  targetid:(NSString*)targetid topicid:(NSString*)topicid {
		NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
		[array addObject:[NSString stringWithFormat:@"targetid=%@",targetid==nil?@"":targetid]];
		[array addObject:[NSString stringWithFormat:@"topicid=%@",topicid==nil?@"":topicid]];
		UpdateOne *updateone=[[UpdateOne alloc] init:@"MChatReq" params:array  delegate:delegate selecter:select];
		return [self instanceUpdate:updateone];
	}

	/**
	 *  树洞发起会话 /mobile?methodno=MChatReq&debug=1&appid=nju&deviceid=1&userid=1&verify=1&targetid=&topicid=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param targetid * 聊天对象id
	 * @param topicid * 树洞id
	 * @callback MView_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  targetid:(NSString*)targetid topicid:(NSString*)topicid {
		UpdateOne *update=[self get:delegate selecter:select targetid:targetid topicid:topicid];
		[DataManager loadData:[[NSArray alloc]initWithObjects:update,nil] delegate:delegate];
		return update;
	}


@end
