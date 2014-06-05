//
//  ApiMRoomSearch
//
//  Created by ryan on 2014-06-04 18:30:33
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"


@interface ApiMRoomSearch : ApiUpdate


	/**
	 *  空教室搜索
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MRoomList_Builder
	 * @param type * 1:仙1   2:仙2     3:逸夫楼
	 * @param day * 1~7
	 * @param begin * 1~10
	 * @param end * 1~10
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  type:(double)type day:(double)day begin:(double)begin end:(double)end;
	/**
	 *  空教室搜索
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param type * 1:仙1   2:仙2     3:逸夫楼
	 * @param day * 1~7
	 * @param begin * 1~10
	 * @param end * 1~10
	 * @callback MRoomList_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  type:(double)type day:(double)day begin:(double)begin end:(double)end;

@end
