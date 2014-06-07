//
//  ApiMUpdateHeadImg
//
//  Created by ryan on 2014-06-04 18:30:33
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"


@interface ApiMUpdateHeadImg : ApiUpdate


	/**
	 * 修改头像:MImg   /mobile?methodno=UpdateHeadImg&debug=1&deviceid=1&userid=&verify=&appid=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MRet_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select ;
	/**
	 * 修改头像:MImg   /mobile?methodno=UpdateHeadImg&debug=1&deviceid=1&userid=&verify=&appid=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MRet_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select ;

@end