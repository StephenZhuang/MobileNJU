//
//  ApiMSchedule
//
//  Created by ryan on 2014-06-04 18:30:33
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"


@interface ApiMSchedule : ApiUpdate


	/**
	 *  课程表
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MClassList_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select ;
	/**
	 *  课程表
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MClassList_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select ;

@end
