//
//  ApiMLostAndFound
//
//  Created by ryan on 2014-06-04 18:30:33
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"


@interface ApiMLostAndFound : ApiUpdate


	/**
	 *  失物招领(分页)
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MLostAndFoundList_Builder
	 * @param type * 1：捡到 2：丢失
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  type:(double)type;
	/**
	 *  失物招领(分页)
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param type * 1：捡到 2：丢失
	 * @callback MLostAndFoundList_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  type:(double)type;

@end