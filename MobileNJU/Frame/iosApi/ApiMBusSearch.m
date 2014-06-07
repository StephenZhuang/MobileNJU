//
//  ApiMBusSearch
//
//  Created by ryan on 2014-06-04 18:30:34
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiMBusSearch.h"

@implementation ApiMBusSearch


	/**
	 *  校车
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param type * 1:鼓楼2:仙林
	 * @callback MBusList_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  type:(double)type {
		NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
		[array addObject:[NSString stringWithFormat:@"type=%@",[Frame number2String:type]]];
		UpdateOne *updateone=[[UpdateOne alloc] init:@"MBusSearch" params:array delegate:delegate selecter:select];
		return [self instanceUpdate:updateone];
	}

	/**
	 *  校车
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