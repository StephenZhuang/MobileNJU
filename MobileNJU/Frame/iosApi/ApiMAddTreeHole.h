//
//  ApiMAddTreeHole
//
//  Created by ryan on 2014-08-06 14:28:21
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"

#import "ZsndTreehole.pb.h"

@interface ApiMAddTreeHole : ApiUpdate


	/**
	 *  发布树洞:MAddTopic   /mobile?methodno=MAddTreeHole&debug=1&deviceid=1&userid=1&verify=1
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MRet_Builder
	 * @param topic * null
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  topic:(MAddTopic_Builder*) topic;
	/**
	 *  发布树洞:MAddTopic   /mobile?methodno=MAddTreeHole&debug=1&deviceid=1&userid=1&verify=1
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param topic * null
	 * @callback MRet_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  topic:(MAddTopic_Builder*) topic;

@end
