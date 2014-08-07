//
//  ApiMTreeHoleList
//
//  Created by ryan on 2014-08-06 14:28:21
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"


@interface ApiMTreeHoleList : ApiUpdate


	/**
	 *  树洞首页 /mobile?methodno=MTreeHoleList&debug=1&deviceid=1&appid=1&userid=1&verify=1&begin=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MTreeHole_Builder
	 * @param type * 1:置顶+热门 2:按时间倒序分页
	 * @param begin  开始时间
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  type:(double)type begin:(NSString*)begin;
	/**
	 *  树洞首页 /mobile?methodno=MTreeHoleList&debug=1&deviceid=1&appid=1&userid=1&verify=1&begin=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param type * 1:置顶+热门 2:按时间倒序分页
	 * @param begin  开始时间
	 * @callback MTreeHole_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  type:(double)type begin:(NSString*)begin;

@end
