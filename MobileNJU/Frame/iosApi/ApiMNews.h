//
//  ApiMNews
//
//  Created by ryan on 2014-06-09 08:52:47
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"


@interface ApiMNews : ApiUpdate


	/**
	 *  新闻详情
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MNews_Builder
	 * @param id * id
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  id:(NSString*)id;
	/**
	 *  新闻详情
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param id * id
	 * @callback MNews_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  id:(NSString*)id;

@end
