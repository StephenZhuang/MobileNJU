//
//  ApiMMyLibrary
//
//  Created by ryan on 2014-06-04 18:30:33
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"


@interface ApiMMyLibrary : ApiUpdate


	/**
	 *  个人图书馆(分页) mobile?methodno=MMyLibrary&debug=1&userid=&verify=&deviceid=&appid=&account=&password=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MBookList_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select ;
	/**
	 *  个人图书馆(分页) mobile?methodno=MMyLibrary&debug=1&userid=&verify=&deviceid=&appid=&account=&password=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MBookList_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select ;

@end