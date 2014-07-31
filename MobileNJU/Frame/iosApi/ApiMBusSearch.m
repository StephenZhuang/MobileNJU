//
//  ApiMBusSearch
//
//  Created by ryan on 2014-07-31 17:37:07
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiMBusSearch.h"

@implementation ApiMBusSearch


	/**
	 *  校车 /mobile?methodno=MBusSearch&debug=1&deviceid=1&userid=&verify=&type=&page=&limit=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param type * 1:鼓楼2:仙林
	 * @callback MBusList_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  type:(double)type {
		NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
		[array addObject:[NSString stringWithFormat:@"type=%@",[Frame number2String:type]]];
		UpdateOne *updateone=[[UpdateOne alloc] init:@"MBusSearch" params:array  delegate:delegate selecter:select];
		return [self instanceUpdate:updateone];
	}

	/**
	 *  校车 /mobile?methodno=MBusSearch&debug=1&deviceid=1&userid=&verify=&type=&page=&limit=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param type * 1:鼓楼2:仙林
	 * @callback MBusList_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  type:(double)type {
		UpdateOne *update=[self get:delegate selecter:select type:type];
		[DataManager loadData:[[NSArray alloc]initWithObjects:update,nil] delegate:delegate];
		return update;
	}


@end
