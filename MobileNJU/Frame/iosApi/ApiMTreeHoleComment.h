//
//  ApiMTreeHoleComment
//
//  Created by ryan on 2014-08-06 14:28:21
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"

#import "ZsndTreehole.pb.h"

@interface ApiMTreeHoleComment : ApiUpdate


	/**
	 *  发布树洞评论 /mobile?methodno=MTreeHoleComment&debug=1&deviceid=1&appid=1&userid=1&verify=1&id=&content=&reply=&floor=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MRet_Builder
	 * @param id * 话题id
	 * @param content * 内容
	 * @param reply  被回复人id
	 * @param floor  被回复人楼层
	 * @param isLz  是否为楼主
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  id:(NSString*)id content:(NSString*)content reply:(NSString*)reply floor:(double)floor islz:(double)isLz;
	/**
	 *  发布树洞评论 /mobile?methodno=MTreeHoleComment&debug=1&deviceid=1&appid=1&userid=1&verify=1&id=&content=&reply=&floor=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param id * 话题id
	 * @param content * 内容
	 * @param reply  被回复人id
	 * @param floor  被回复人楼层
	 * @param isLz  是否为楼主
	 * @callback MRet_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  id:(NSString*)id content:(NSString*)content reply:(NSString*)reply floor:(double)floor islz:(double)isLz;

@end
