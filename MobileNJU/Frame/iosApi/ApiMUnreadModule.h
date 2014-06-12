//
//  ApiMUnreadModule
//
//  Created by ryan on 2014-06-12 13:12:48
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"


@interface ApiMUnreadModule : ApiUpdate


	/**
	 *  未读消息  /mobile?methodno=MUnreadModule&debug=1&deviceid=1&userid=dffeda04-eb07-11e3-b696-ac853d9d52b1&verify=753bd4cd-590a-4fa2-b5b3-f390d3bc1d01&appid=nju
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MUnread_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select ;
	/**
	 *  未读消息  /mobile?methodno=MUnreadModule&debug=1&deviceid=1&userid=dffeda04-eb07-11e3-b696-ac853d9d52b1&verify=753bd4cd-590a-4fa2-b5b3-f390d3bc1d01&appid=nju
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MUnread_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select ;

@end
