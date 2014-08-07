//
//  ApiMTreeHoleQuery
//
//  Created by ryan on 2014-08-06 14:28:21
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiMTreeHoleQuery.h"

@implementation ApiMTreeHoleQuery


	/**
	 *  树洞查询 /mobile?methodno=MTreeHoleQuery&debug=1&deviceid=1&appid=1&userid=1&verify=1&type=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param type * 1:推荐 2:热门
	 * @callback MTreeHole_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  type:(double)type {
		NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
		[array addObject:[NSString stringWithFormat:@"type=%@",[Frame number2String:type]]];
		UpdateOne *updateone=[[UpdateOne alloc] init:@"MTreeHoleQuery" params:array  delegate:delegate selecter:select];
		return [self instanceUpdate:updateone];
	}

	/**
	 *  树洞查询 /mobile?methodno=MTreeHoleQuery&debug=1&deviceid=1&appid=1&userid=1&verify=1&type=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param type * 1:推荐 2:热门
	 * @callback MTreeHole_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  type:(double)type {
		UpdateOne *update=[self get:delegate selecter:select type:type];
		[DataManager loadData:[[NSArray alloc]initWithObjects:update,nil] delegate:delegate];
		return update;
	}


@end
