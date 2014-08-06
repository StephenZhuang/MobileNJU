//
//  ApiMAddMarket
//
//  Created by ryan on 2014-08-06 14:28:21
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiMAddMarket.h"

@implementation ApiMAddMarket


	/**
	 * 
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param market * null
	 * @callback MMarketList_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  market:(MAddMarket_Builder*) market {
		NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
		UpdateOne *updateone=[[UpdateOne alloc] init:@"MAddMarket" params:array  postparams:market delegate:delegate selecter:select];
		return [self instanceUpdate:updateone];
	}

	/**
	 * 
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param market * null
	 * @callback MMarketList_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  market:(MAddMarket_Builder*) market {
		UpdateOne *update=[self get:delegate selecter:select market:market];
		[DataManager loadData:[[NSArray alloc]initWithObjects:update,nil] delegate:delegate];
		return update;
	}


@end
