//
//  ApiMCardHistory
//
//  Created by ryan on 2014-06-04 18:30:34
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"


@interface ApiMCardHistory : ApiUpdate


	/**
	 *  一卡通消费记录
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MCardList_Builder
	 * @param begin * 起始
	 * @param end * 结束
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  begin:(NSString*)begin end:(NSString*)end;
	/**
	 *  一卡通消费记录
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param begin * 起始
	 * @param end * 结束
	 * @callback MCardList_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  begin:(NSString*)begin end:(NSString*)end;

@end