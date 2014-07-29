//
//  ApiMAddMarket
//
//  Created by ryan on 2014-07-29 20:12:07
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"

#import "ZsndMarket.pb.h"

@interface ApiMAddMarket : ApiUpdate


	/**
	 *  添加商品 mobile?methodno=MMyLibrary&debug=1&userid=&verify=&deviceid=&appid=&account=&password=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MRet_Builder
	 * @param product * url
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  product:(MAddMarket_Builder*) product;
	/**
	 *  添加商品 mobile?methodno=MMyLibrary&debug=1&userid=&verify=&deviceid=&appid=&account=&password=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param product * url
	 * @callback MRet_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  product:(MAddMarket_Builder*) product;

@end
