//
//  ApiMRss
//
//  Created by ryan on 2014-07-31 09:18:59
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiMRss.h"

@implementation ApiMRss


	/**
	 *  订阅 /mobile?methodno=MRss&debug=1&deviceid=1&userid=&verify=&rssid=&appid=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param rssid * id
	 * @callback MRet_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  rssid:(NSString*)rssid {
		NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
		[array addObject:[NSString stringWithFormat:@"rssid=%@",rssid==nil?@"":rssid]];
		UpdateOne *updateone=[[UpdateOne alloc] init:@"MRss" params:array  delegate:delegate selecter:select];
		return [self instanceUpdate:updateone];
	}

	/**
	 *  订阅 /mobile?methodno=MRss&debug=1&deviceid=1&userid=&verify=&rssid=&appid=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param rssid * id
	 * @callback MRet_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  rssid:(NSString*)rssid {
		UpdateOne *update=[self get:delegate selecter:select rssid:rssid];
		[DataManager loadData:[[NSArray alloc]initWithObjects:update,nil] delegate:delegate];
		return update;
	}


@end
