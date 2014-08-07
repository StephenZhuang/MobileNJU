//
//  ApiMChatDel
//
//  Created by ryan on 2014-08-06 14:28:21
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiMChatDel.h"

@implementation ApiMChatDel


	/**
	 *  南呱记录删除  /mobile?methodno=MChatDel&debug=1&appid=nju&deviceid=1&userid=1&verify=1&viewid=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param viewid * 会话id
	 * @callback MRet_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  viewid:(NSString*)viewid {
		NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
		[array addObject:[NSString stringWithFormat:@"viewid=%@",viewid==nil?@"":viewid]];
		UpdateOne *updateone=[[UpdateOne alloc] init:@"MChatDel" params:array  delegate:delegate selecter:select];
		return [self instanceUpdate:updateone];
	}

	/**
	 *  南呱记录删除  /mobile?methodno=MChatDel&debug=1&appid=nju&deviceid=1&userid=1&verify=1&viewid=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param viewid * 会话id
	 * @callback MRet_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  viewid:(NSString*)viewid {
		UpdateOne *update=[self get:delegate selecter:select viewid:viewid];
		[DataManager loadData:[[NSArray alloc]initWithObjects:update,nil] delegate:delegate];
		return update;
	}


@end
