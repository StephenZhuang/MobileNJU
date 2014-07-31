//
//  ApiMMarketList
//
//  Created by ryan on 2014-07-31 09:18:59
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiMMarketList.h"

@implementation ApiMMarketList


	/**
	 *  获取商品详情 mobile?methodno=MMyLibrary&debug=1&userid=&verify=&deviceid=&appid=&account=&password=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param type * url
	 * @callback MMarketTypeList_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  type:(NSString*)type {
		NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
		[array addObject:[NSString stringWithFormat:@"type=%@",type==nil?@"":type]];
		UpdateOne *updateone=[[UpdateOne alloc] init:@"MMarketList" params:array  delegate:delegate selecter:select];
		return [self instanceUpdate:updateone];
	}

	/**
	 *  获取商品详情 mobile?methodno=MMyLibrary&debug=1&userid=&verify=&deviceid=&appid=&account=&password=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param type * url
	 * @callback MMarketTypeList_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  type:(NSString*)type {
		UpdateOne *update=[self get:delegate selecter:select type:type];
		[DataManager loadData:[[NSArray alloc]initWithObjects:update,nil] delegate:delegate];
		return update;
	}


@end
