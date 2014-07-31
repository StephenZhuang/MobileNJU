//
//  ApiMSearchBook
//
//  Created by ryan on 2014-07-31 09:18:59
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"


@interface ApiMSearchBook : ApiUpdate


	/**
	 *  图书馆检索(分页)  /mobile?methodno=MSearchBook&debug=1&userid=&verify=&deviceid=&appid=&page=&limit=&keyword=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MBookList_Builder
	 * @param keyword * 关键字
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  keyword:(NSString*)keyword;
	/**
	 *  图书馆检索(分页)  /mobile?methodno=MSearchBook&debug=1&userid=&verify=&deviceid=&appid=&page=&limit=&keyword=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param keyword * 关键字
	 * @callback MBookList_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  keyword:(NSString*)keyword;

@end
