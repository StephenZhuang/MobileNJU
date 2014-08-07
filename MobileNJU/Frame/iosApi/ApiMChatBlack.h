//
//  ApiMChatBlack
//
//  Created by ryan on 2014-08-06 14:28:21
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"

#import "ZsndSystem.pb.h"

@interface ApiMChatBlack : ApiUpdate


	/**
	 *  南呱黑名单 /mobile?methodno=MChatBlack&debug=1&appid=nju&deviceid=1&userid=1&verify=1&viewid=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MRet_Builder
	 * @param viewid * 会话id
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  viewid:(NSString*)viewid;
	/**
	 *  南呱黑名单 /mobile?methodno=MChatBlack&debug=1&appid=nju&deviceid=1&userid=1&verify=1&viewid=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param viewid * 会话id
	 * @callback MRet_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  viewid:(NSString*)viewid;

@end
