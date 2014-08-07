//
//  ApiMChatReq
//
//  Created by ryan on 2014-08-06 14:28:21
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"

#import "ZsndSystem.pb.h"

@interface ApiMChatReq : ApiUpdate


	/**
	 *  树洞发起会话 /mobile?methodno=MChatReq&debug=1&appid=nju&deviceid=1&userid=1&verify=1&targetid=&topicid=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MView_Builder
	 * @param targetid * 聊天对象id
	 * @param topicid * 树洞id
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  targetid:(NSString*)targetid topicid:(NSString*)topicid;
	/**
	 *  树洞发起会话 /mobile?methodno=MChatReq&debug=1&appid=nju&deviceid=1&userid=1&verify=1&targetid=&topicid=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param targetid * 聊天对象id
	 * @param topicid * 树洞id
	 * @callback MView_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  targetid:(NSString*)targetid topicid:(NSString*)topicid;

@end
