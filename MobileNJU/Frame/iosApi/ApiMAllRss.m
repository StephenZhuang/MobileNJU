//
//  ApiMAllRss
//
//  Created by ryan on 2014-08-06 14:28:21
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiMAllRss.h"

@implementation ApiMAllRss


	/**
	 *  全部订阅 /mobile?methodno=MAllRss&debug=1&deviceid=1&userid=&verify=&appid=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MRssList_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  {
		NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
		UpdateOne *updateone=[[UpdateOne alloc] init:@"MAllRss" params:array  delegate:delegate selecter:select];
		return [self instanceUpdate:updateone];
	}

	/**
	 *  全部订阅 /mobile?methodno=MAllRss&debug=1&deviceid=1&userid=&verify=&appid=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MRssList_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  {
		UpdateOne *update=[self get:delegate selecter:select];
		[DataManager loadData:[[NSArray alloc]initWithObjects:update,nil] delegate:delegate];
		return update;
	}


@end
