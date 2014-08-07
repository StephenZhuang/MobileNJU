//
//  ApiMTreeHoleQuery
//
//  Created by ryan on 2014-08-06 14:28:21
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"


@interface ApiMTreeHoleQuery : ApiUpdate


	/**
	 *  树洞查询 /mobile?methodno=MTreeHoleQuery&debug=1&deviceid=1&appid=1&userid=1&verify=1&type=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MTreeHole_Builder
	 * @param type * 1:推荐 2:热门
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  type:(double)type;
	/**
	 *  树洞查询 /mobile?methodno=MTreeHoleQuery&debug=1&deviceid=1&appid=1&userid=1&verify=1&type=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param type * 1:推荐 2:热门
	 * @callback MTreeHole_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  type:(double)type;

@end
