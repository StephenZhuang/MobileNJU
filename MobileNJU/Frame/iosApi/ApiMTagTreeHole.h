//
//  ApiMTagTreeHole
//
//  Created by ryan on 2014-08-06 14:28:21
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"


@interface ApiMTagTreeHole : ApiUpdate


	/**
	 *  话题树洞 /mobile?methodno=MTagTreeHole&debug=1&deviceid=1&appid=1&userid=1&verify=1&tagid=&begin=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MTreeHole_Builder
	 * @param tagid * 话题id
	 * @param begin  开始时间
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  tagid:(NSString*)tagid begin:(NSString*)begin;
	/**
	 *  话题树洞 /mobile?methodno=MTagTreeHole&debug=1&deviceid=1&appid=1&userid=1&verify=1&tagid=&begin=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param tagid * 话题id
	 * @param begin  开始时间
	 * @callback MTreeHole_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  tagid:(NSString*)tagid begin:(NSString*)begin;

@end
