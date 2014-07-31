//
//  ApiMMarketList
//
//  Created by ryan on 2014-07-31 17:37:06
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiMMarketList.h"

@implementation ApiMMarketList


	/**
	 * 
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param type * 0：全部跳蚤市场    1：我的跳蚤市场    默认为0,我的跳蚤市场虽然没有，但也预留一下
	 * @param sold * 0:全部列表    1：未售列表   2：已售列表
	 * @callback MMarketList_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  type:(double)type sold:(double)sold {
		NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
		[array addObject:[NSString stringWithFormat:@"type=%@",[Frame number2String:type]]];
		[array addObject:[NSString stringWithFormat:@"sold=%@",[Frame number2String:sold]]];
		UpdateOne *updateone=[[UpdateOne alloc] init:@"MMarketList" params:array  delegate:delegate selecter:select];
		return [self instanceUpdate:updateone];
	}

	/**
	 * 
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param type * 0：全部跳蚤市场    1：我的跳蚤市场    默认为0,我的跳蚤市场虽然没有，但也预留一下
	 * @param sold * 0:全部列表    1：未售列表   2：已售列表
	 * @callback MMarketList_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  type:(double)type sold:(double)sold {
		UpdateOne *update=[self get:delegate selecter:select type:type sold:sold];
		[DataManager loadData:[[NSArray alloc]initWithObjects:update,nil] delegate:delegate];
		return update;
	}


@end
