//
//  ApiMRss
//
//  Created by ryan on 2014-08-06 14:28:21
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"


@interface ApiMRss : ApiUpdate


	/**
	 *  订阅 /mobile?methodno=MRss&debug=1&deviceid=1&userid=&verify=&rssid=&appid=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MRet_Builder
	 * @param rssid * id
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  rssid:(NSString*)rssid;
	/**
	 *  订阅 /mobile?methodno=MRss&debug=1&deviceid=1&userid=&verify=&rssid=&appid=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param rssid * id
	 * @callback MRet_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  rssid:(NSString*)rssid;

@end
