//
//  ApiMRoomSearch
//
//  Created by ryan on 2014-07-29 20:12:07
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiMRoomSearch.h"

@implementation ApiMRoomSearch


	/**
	 *  空教室搜索 /mobile?methodno=MRoomSearch&debug=1&deviceid=1&userid=&verify=&type=&day=&begin=&end=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param type * 1:仙1   2:仙2     3:逸夫楼
	 * @param day * 1~7
	 * @param begin * 1~10
	 * @param end * 1~10
	 * @callback MRoomList_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  type:(double)type day:(double)day begin:(double)begin end:(double)end {
		NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
		[array addObject:[NSString stringWithFormat:@"type=%@",[Frame number2String:type]]];
		[array addObject:[NSString stringWithFormat:@"day=%@",[Frame number2String:day]]];
		[array addObject:[NSString stringWithFormat:@"begin=%@",[Frame number2String:begin]]];
		[array addObject:[NSString stringWithFormat:@"end=%@",[Frame number2String:end]]];
		UpdateOne *updateone=[[UpdateOne alloc] init:@"MRoomSearch" params:array  delegate:delegate selecter:select];
		return [self instanceUpdate:updateone];
	}

	/**
	 *  空教室搜索 /mobile?methodno=MRoomSearch&debug=1&deviceid=1&userid=&verify=&type=&day=&begin=&end=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param type * 1:仙1   2:仙2     3:逸夫楼
	 * @param day * 1~7
	 * @param begin * 1~10
	 * @param end * 1~10
	 * @callback MRoomList_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  type:(double)type day:(double)day begin:(double)begin end:(double)end {
		UpdateOne *update=[self get:delegate selecter:select type:type day:day begin:begin end:end];
		[DataManager loadData:[[NSArray alloc]initWithObjects:update,nil] delegate:delegate];
		return update;
	}


@end
