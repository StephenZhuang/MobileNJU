//
//  ApiMBusSearch
//
//  Created by ryan on 2014-06-04 18:30:34
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"


@interface ApiMBusSearch : ApiUpdate


	/**
	 *  校车
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MBusList_Builder
	 * @param type * 1:鼓楼2:仙林
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  type:(double)type;
	/**
	 *  校车
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param type * 1:鼓楼2:仙林
	 * @callback MBusList_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  type:(double)type;

@end
