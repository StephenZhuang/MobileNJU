//
//  ApiMMyRss
//
//  Created by ryan on 2014-06-09 10:27:58
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiMMyRss.h"

@implementation ApiMMyRss


	/**
	 *  我的订阅 /mobile?methodno=MMyRss&debug=1&deviceid=1&userid=&verify=&appid=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MMyRssList_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  {
		NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
		UpdateOne *updateone=[[UpdateOne alloc] init:@"MMyRss" params:array delegate:delegate selecter:select];
		return [self instanceUpdate:updateone];
	}

	/**
	 *  我的订阅 /mobile?methodno=MMyRss&debug=1&deviceid=1&userid=&verify=&appid=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MMyRssList_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  {
		UpdateOne *update=[self get:delegate selecter:select];
		[DataManager loadData:[[NSArray alloc]initWithObjects:update,nil] delegate:delegate];
		return update;
	}


@end
