//
//  ApiMMarketType
//
//  Created by ryan on 2014-07-31 13:42:28
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiMMarketType.h"

@implementation ApiMMarketType


	/**
	 *  商品分类 mobile?methodno=MMyLibrary&debug=1&userid=&verify=&deviceid=&appid=&account=&password=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MMarketTypeList_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  {
		NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
		UpdateOne *updateone=[[UpdateOne alloc] init:@"MMarketType" params:array  delegate:delegate selecter:select];
		return [self instanceUpdate:updateone];
	}

	/**
	 *  商品分类 mobile?methodno=MMyLibrary&debug=1&userid=&verify=&deviceid=&appid=&account=&password=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MMarketTypeList_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  {
		UpdateOne *update=[self get:delegate selecter:select];
		[DataManager loadData:[[NSArray alloc]initWithObjects:update,nil] delegate:delegate];
		return update;
	}


@end
