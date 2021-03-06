//
//  ApiMTreeHoleReport
//
//  Created by ryan on 2014-08-06 14:28:21
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"

#import "ZsndTreehole.pb.h"

@interface ApiMTreeHoleReport : ApiUpdate


	/**
	 *  树洞举报 /mobile?methodno=MTreeHoleReport&debug=1&deviceid=1&appid=1&userid=1&verify=1&id=1
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MRet_Builder
	 * @param id * 话题id
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  id:(NSString*)id;
	/**
	 *  树洞举报 /mobile?methodno=MTreeHoleReport&debug=1&deviceid=1&appid=1&userid=1&verify=1&id=1
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param id * 话题id
	 * @callback MRet_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  id:(NSString*)id;

@end
