//
//  ApiMGetWelcomePage
//
//  Created by ryan on 2014-06-12 13:12:48
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"


@interface ApiMGetWelcomePage : ApiUpdate


	/**
	 * 获取欢迎页   /mobile?methodno=MGetWelcomePage&debug=&deviceid=&appid=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MRet_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select ;
	/**
	 * 获取欢迎页   /mobile?methodno=MGetWelcomePage&debug=&deviceid=&appid=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MRet_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select ;

@end
