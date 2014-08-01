//
//  ApiMSoldMarket
//
//  Created by ryan on 2014-07-31 17:37:07
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiMSoldMarket.h"

@implementation ApiMSoldMarket


	/**
	 * 
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param id * 商品的id
	 * @callback MRet_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  id:(NSString*)id {
		NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
		[array addObject:[NSString stringWithFormat:@"id=%@",id==nil?@"":id]];
		UpdateOne *updateone=[[UpdateOne alloc] init:@"MSoldMarket" params:array  delegate:delegate selecter:select];
		return [self instanceUpdate:updateone];
	}

	/**
	 * 
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param id * 商品的id
	 * @callback MRet_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  id:(NSString*)id {
		UpdateOne *update=[self get:delegate selecter:select id:id];
		[DataManager loadData:[[NSArray alloc]initWithObjects:update,nil] delegate:delegate];
		return update;
	}


@end
