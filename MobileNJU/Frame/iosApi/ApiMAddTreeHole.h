//
//  ApiMAddTreeHole
//
//  Created by ryan on 2014-07-31 17:37:07
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"


@interface ApiMAddTreeHole : ApiUpdate


	/**
	 *  发布树洞:MAddTopic     /mobile?methodno=MAddTreeHole&debug=1&deviceid=1&userid=1&verify=1
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MRet_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select ;
	/**
	 *  发布树洞:MAddTopic     /mobile?methodno=MAddTreeHole&debug=1&deviceid=1&userid=1&verify=1
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MRet_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select ;

@end
