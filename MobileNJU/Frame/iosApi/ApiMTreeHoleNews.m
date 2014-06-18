//
//  ApiMTreeHoleNews
//
//  Created by ryan on 2014-06-18 15:39:59
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiMTreeHoleNews.h"

@implementation ApiMTreeHoleNews


	/**
	 *  树洞新消息 /mobile?methodno=MTreeHoleNews&debug=1&deviceid=1&appid=1&userid=1&verify=1&begin=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param begin * 开始时间
	 * @callback MNewComments_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  begin:(NSString*)begin {
		NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
		[array addObject:[NSString stringWithFormat:@"begin=%@",begin==nil?@"":begin]];
		UpdateOne *updateone=[[UpdateOne alloc] init:@"MTreeHoleNews" params:array  delegate:delegate selecter:select];
		return [self instanceUpdate:updateone];
	}

	/**
	 *  树洞新消息 /mobile?methodno=MTreeHoleNews&debug=1&deviceid=1&appid=1&userid=1&verify=1&begin=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param begin * 开始时间
	 * @callback MNewComments_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  begin:(NSString*)begin {
		UpdateOne *update=[self get:delegate selecter:select begin:begin];
		[DataManager loadData:[[NSArray alloc]initWithObjects:update,nil] delegate:delegate];
		return update;
	}


@end
