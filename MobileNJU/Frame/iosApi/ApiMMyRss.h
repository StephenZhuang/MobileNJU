//
//  ApiMMyRss
//
//  Created by ryan on 2014-06-04 18:30:33
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"


@interface ApiMMyRss : ApiUpdate


	/**
	 *  我的订阅
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MMyRssList_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select ;
	/**
	 *  我的订阅
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MMyRssList_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select ;

@end
