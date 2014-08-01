//
//  ApiMMarketList
//
//  Created by ryan on 2014-07-31 17:37:06
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"


@interface ApiMMarketList : ApiUpdate


	/**
	 * 
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MMarketList_Builder
	 * @param type * 0：全部跳蚤市场    1：我的跳蚤市场    默认为0,我的跳蚤市场虽然没有，但也预留一下
	 * @param sold * 0:全部列表    1：未售列表   2：已售列表
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  type:(NSString*)type ;
	/**
	 * 
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param type * 0：全部跳蚤市场    1：我的跳蚤市场    默认为0,我的跳蚤市场虽然没有，但也预留一下
	 * @param sold * 0:全部列表    1：未售列表   2：已售列表
	 * @callback MMarketList_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  type:(NSString*)type ;

@end
