//
//  ApiMChatMatch
//
//  Created by ryan on 2014-06-12 13:12:48
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"


@interface ApiMChatMatch : ApiUpdate


	/**
	 *  南呱匹配 /mobile?methodno=MChatMatch&debug=1&appid=nju&deviceid=1&userid=1&verify=1
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MMatch_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select ;
	/**
	 *  南呱匹配 /mobile?methodno=MChatMatch&debug=1&appid=nju&deviceid=1&userid=1&verify=1
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MMatch_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select ;

@end
