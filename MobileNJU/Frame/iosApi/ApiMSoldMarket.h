//
//  ApiMSoldMarket
//
//  Created by ryan on 2014-08-06 14:28:21
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"

#import "ZsndMarket.pb.h"

@interface ApiMSoldMarket : ApiUpdate


	/**
	 * 
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MRet_Builder
	 * @param id * 商品的id
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  id:(NSString*)id;
	/**
	 * 
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param id * 商品的id
	 * @callback MRet_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  id:(NSString*)id;

@end
