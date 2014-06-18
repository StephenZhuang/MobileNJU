//
//  ApiMTreeHoleComment
//
//  Created by ryan on 2014-06-18 15:39:59
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"


@interface ApiMTreeHoleComment : ApiUpdate


	/**
	 *  发布树洞评论 /mobile?methodno=MTreeHoleComment&debug=1&deviceid=1&appid=1&userid=1&verify=1&id=&content=&reply=&commentId=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MRet_Builder
	 * @param id * 话题id
	 * @param content * 内容
	 * @param reply  被回复人id
	 * @param commentId  评论id
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  id:(NSString*)id content:(NSString*)content reply:(NSString*)reply commentid:(NSString*)commentId;
	/**
	 *  发布树洞评论 /mobile?methodno=MTreeHoleComment&debug=1&deviceid=1&appid=1&userid=1&verify=1&id=&content=&reply=&commentId=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param id * 话题id
	 * @param content * 内容
	 * @param reply  被回复人id
	 * @param commentId  评论id
	 * @callback MRet_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  id:(NSString*)id content:(NSString*)content reply:(NSString*)reply commentid:(NSString*)commentId;

@end
