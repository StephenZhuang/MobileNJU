//
//  ApiMRssNews
//
//  Created by ryan on 2014-07-29 20:12:07
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"


@interface ApiMRssNews : ApiUpdate


	/**
	 *  订阅新闻  /mobile?methodno=MMyRss&debug=1&deviceid=1&userid=&verify=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MMyRss_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select ;
	/**
	 *  订阅新闻  /mobile?methodno=MMyRss&debug=1&deviceid=1&userid=&verify=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MMyRss_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select ;

@end
