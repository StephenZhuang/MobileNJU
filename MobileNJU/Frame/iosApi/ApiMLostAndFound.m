//
//  ApiMLostAndFound
//
//  Created by ryan on 2014-06-12 13:12:48
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiMLostAndFound.h"

@implementation ApiMLostAndFound


	/**
	 *  失物招领(分页) /mobile?methodno=MLostAndFound&debug=1&deviceid=1&userid=&verify=&type=&page=&limit=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param type * 1：捡到 2：丢失
	 * @callback MLostAndFoundList_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  type:(double)type {
		NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
		[array addObject:[NSString stringWithFormat:@"type=%@",[Frame number2String:type]]];
		UpdateOne *updateone=[[UpdateOne alloc] init:@"MLostAndFound" params:array delegate:delegate selecter:select];
		return [self instanceUpdate:updateone];
	}

	/**
	 *  失物招领(分页) /mobile?methodno=MLostAndFound&debug=1&deviceid=1&userid=&verify=&type=&page=&limit=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param type * 1：捡到 2：丢失
	 * @callback MLostAndFoundList_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  type:(double)type {
		UpdateOne *update=[self get:delegate selecter:select type:type];
		[DataManager loadData:[[NSArray alloc]initWithObjects:update,nil] delegate:delegate];
		return update;
	}


@end
