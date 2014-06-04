//
//  ApiMBookRenew
//
//  Created by ryan on 2014-06-04 18:30:33
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"


@interface ApiMBookRenew : ApiUpdate


	/**
	 *  图书馆续借  mobile?methodno=MBookRenew&debug=&deviceid=&appid=1&userid=&verify=&account=&password=&id=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MRet_Builder
	 * @param id * 图书id
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  id:(NSString*)id;
	/**
	 *  图书馆续借  mobile?methodno=MBookRenew&debug=&deviceid=&appid=1&userid=&verify=&account=&password=&id=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param id * 图书id
	 * @callback MRet_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  id:(NSString*)id;

@end
