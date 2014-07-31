//
//  ApiMBookDetail
//
//  Created by ryan on 2014-07-31 17:37:06
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"


@interface ApiMBookDetail : ApiUpdate


	/**
	 *  图书详情查询  /mobile?methodno=MBookDetail&debug=1&userid=&verify=&deviceid=&appid=&id=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MBook_Builder
	 * @param id * url
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  id:(NSString*)id;
	/**
	 *  图书详情查询  /mobile?methodno=MBookDetail&debug=1&userid=&verify=&deviceid=&appid=&id=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param id * url
	 * @callback MBook_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  id:(NSString*)id;

@end
