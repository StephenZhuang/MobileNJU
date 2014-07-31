//
//  ApiMRssNews
//
//  Created by ryan on 2014-07-31 13:42:28
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
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  rssid:(NSString *)rssid;
	/**
	 *  订阅新闻  /mobile?methodno=MMyRss&debug=1&deviceid=1&userid=&verify=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MMyRss_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  rssid:(NSString *)rssid;

@end
