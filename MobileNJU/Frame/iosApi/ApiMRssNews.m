//
//  ApiMRssNews
//
//  Created by ryan on 2014-07-31 13:42:28
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiMRssNews.h"

@implementation ApiMRssNews


	/**
	 *  订阅新闻  /mobile?methodno=MMyRss&debug=1&deviceid=1&userid=&verify=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MMyRss_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  rssid:(NSString *)rssid{
		NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
        [array addObject:[NSString stringWithFormat:@"rssid=%@",rssid]];
		UpdateOne *updateone=[[UpdateOne alloc] init:@"MRssNews" params:array  delegate:delegate selecter:select];
		return [self instanceUpdate:updateone];
	}

	/**
	 *  订阅新闻  /mobile?methodno=MMyRss&debug=1&deviceid=1&userid=&verify=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MMyRss_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select rssid:(NSString *)rssid {
		UpdateOne *update=[self get:delegate selecter:select rssid:rssid];
		[DataManager loadData:[[NSArray alloc]initWithObjects:update,nil] delegate:delegate];
		return update;
	}


@end
