//
//  ApiMCardInfo
//
//  Created by ryan on 2014-06-04 18:30:34
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"


@interface ApiMCardInfo : ApiUpdate


	/**
	 *  一卡通余额
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MCard_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select ;
	/**
	 *  一卡通余额
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MCard_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select ;

@end