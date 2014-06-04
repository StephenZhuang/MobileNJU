//
//  ApiMChatCallBack
//
//  Created by ryan on 2014-06-04 18:30:33
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"


@interface ApiMChatCallBack : ApiUpdate


	/**
	 *  南呱呼叫应答 /mobile?methodno=MChatCallBack&debug=1&appid=nju&deviceid=1&userid=1&verify=1&id=&type=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MRet_Builder
	 * @param id * 聊天对象id
	 * @param type * 0:取消 1:接受
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  id:(NSString*)id type:(double)type;
	/**
	 *  南呱呼叫应答 /mobile?methodno=MChatCallBack&debug=1&appid=nju&deviceid=1&userid=1&verify=1&id=&type=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param id * 聊天对象id
	 * @param type * 0:取消 1:接受
	 * @callback MRet_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  id:(NSString*)id type:(double)type;

@end
