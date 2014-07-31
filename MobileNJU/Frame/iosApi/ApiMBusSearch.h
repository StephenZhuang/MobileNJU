//
//  ApiMBusSearch
//
//  Created by ryan on 2014-07-31 09:18:59
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"

#import "ZsndTreehole.pb.h"

@interface ApiMBusSearch : ApiUpdate


	/**
	 *  校车 /mobile?methodno=MBusSearch&debug=1&deviceid=1&userid=&verify=&type=&page=&limit=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MBusList_Builder
	 * @param type * 1:鼓楼2:仙林
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  type:(double)type;
	/**
	 *  校车 /mobile?methodno=MBusSearch&debug=1&deviceid=1&userid=&verify=&type=&page=&limit=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param type * 1:鼓楼2:仙林
	 * @callback MBusList_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  type:(double)type;

@end
