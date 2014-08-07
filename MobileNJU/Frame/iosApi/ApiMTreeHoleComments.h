//
//  ApiMTreeHoleComments
//
//  Created by ryan on 2014-08-06 14:28:21
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"


@interface ApiMTreeHoleComments : ApiUpdate


	/**
	 *  树洞评论 /mobile?methodno=MTreeHoleComments&debug=1&deviceid=1&appid=1&userid=1&verify=1&id=1&begin=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MCommentList_Builder
	 * @param id * 话题id
	 * @param begin  开始时间
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  id:(NSString*)id begin:(NSString*)begin;
	/**
	 *  树洞评论 /mobile?methodno=MTreeHoleComments&debug=1&deviceid=1&appid=1&userid=1&verify=1&id=1&begin=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param id * 话题id
	 * @param begin  开始时间
	 * @callback MCommentList_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  id:(NSString*)id begin:(NSString*)begin;

@end
