//
//  ApiMTreeHoleNews
//
//  Created by ryan on 2014-06-12 13:12:48
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"


@interface ApiMTreeHoleNews : ApiUpdate


	/**
	 *  树洞新消息 /mobile?methodno=MTreeHoleNews&debug=1&deviceid=1&appid=1&userid=1&verify=1&begin=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MNewComments_Builder
	 * @param begin * 开始时间
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  begin:(NSString*)begin;
	/**
	 *  树洞新消息 /mobile?methodno=MTreeHoleNews&debug=1&deviceid=1&appid=1&userid=1&verify=1&begin=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param begin * 开始时间
	 * @callback MNewComments_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  begin:(NSString*)begin;

@end
