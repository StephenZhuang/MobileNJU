//
//  ApiMNewsList
//
//  Created by ryan on 2014-06-04 18:30:33
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"


@interface ApiMNewsList : ApiUpdate


	/**
	 * 新闻列表(分页)
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MNewsList_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select ;
	/**
	 * 新闻列表(分页)
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MNewsList_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select ;

@end
