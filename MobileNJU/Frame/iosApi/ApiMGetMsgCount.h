//
//  ApiMGetMsgCount
//
//  Created by ryan on 2014-08-06 14:28:21
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"


@interface ApiMGetMsgCount : ApiUpdate


	/**
	 *  获取消息数 /mobile?methodno=MGetMsgCount&debug=1&deviceid=1&appid=1&userid=1&verify=1
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MMsgCount_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select ;
	/**
	 *  获取消息数 /mobile?methodno=MGetMsgCount&debug=1&deviceid=1&appid=1&userid=1&verify=1
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MMsgCount_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select ;

@end
