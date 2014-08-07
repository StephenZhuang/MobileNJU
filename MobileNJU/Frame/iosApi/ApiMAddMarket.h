//
//  ApiMAddMarket
//
//  Created by ryan on 2014-08-06 14:28:21
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"

#import "ZsndMarket.pb.h"

@interface ApiMAddMarket : ApiUpdate


	/**
	 * 
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MMarketList_Builder
	 * @param market * null
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  market:(MAddMarket_Builder*) market;
	/**
	 * 
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param market * null
	 * @callback MMarketList_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  market:(MAddMarket_Builder*) market;

@end
