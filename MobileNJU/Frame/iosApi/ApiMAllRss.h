//
//  ApiMAllRss
//
//  Created by ryan on 2014-06-18 15:39:58
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"


@interface ApiMAllRss : ApiUpdate


	/**
	 *  全部订阅 /mobile?methodno=MAllRss&debug=1&deviceid=1&userid=&verify=&appid=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MRssList_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select ;
	/**
	 *  全部订阅 /mobile?methodno=MAllRss&debug=1&deviceid=1&userid=&verify=&appid=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MRssList_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select ;

@end
