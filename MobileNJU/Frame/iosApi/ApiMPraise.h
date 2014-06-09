//
//  ApiMPraise
//
//  Created by ryan on 2014-06-09 10:27:58
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"


@interface ApiMPraise : ApiUpdate


	/**
	 *  树洞赞 /mobile?methodno=MPraise&debug=1&deviceid=1&appid=1&userid=1&verify=1&id=1&type=1
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MRet_Builder
	 * @param id * 话题id
	 * @param type * 1:赞 2:取消赞
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  id:(NSString*)id type:(double)type;
	/**
	 *  树洞赞 /mobile?methodno=MPraise&debug=1&deviceid=1&appid=1&userid=1&verify=1&id=1&type=1
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param id * 话题id
	 * @param type * 1:赞 2:取消赞
	 * @callback MRet_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  id:(NSString*)id type:(double)type;

@end
