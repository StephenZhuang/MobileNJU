//
//  ApiMPushClear
//
//  Created by ryan on 2014-07-31 17:37:07
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"


@interface ApiMPushClear : ApiUpdate


	/**
	 * 清空推送   /mobile?methodno=MPushClear&debug=1&deviceid=&appid=&userid=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MRet_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select ;
	/**
	 * 清空推送   /mobile?methodno=MPushClear&debug=1&deviceid=&appid=&userid=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MRet_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select ;

@end
