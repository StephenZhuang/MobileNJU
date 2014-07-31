//
//  ApiMMarketList
//
//  Created by ryan on 2014-07-31 09:18:59
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"


@interface ApiMMarketList : ApiUpdate


	/**
	 *  获取商品详情 mobile?methodno=MMyLibrary&debug=1&userid=&verify=&deviceid=&appid=&account=&password=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MMarketTypeList_Builder
	 * @param type * url
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  type:(NSString*)type;
	/**
	 *  获取商品详情 mobile?methodno=MMyLibrary&debug=1&userid=&verify=&deviceid=&appid=&account=&password=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param type * url
	 * @callback MMarketTypeList_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  type:(NSString*)type;

@end
