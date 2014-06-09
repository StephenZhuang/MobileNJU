//
//  ApiMTreeHoleList
//
//  Created by ryan on 2014-06-09 10:27:58
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiMTreeHoleList.h"

@implementation ApiMTreeHoleList


	/**
	 *  树洞首页 /mobile?methodno=MTreeHoleList&debug=1&deviceid=1&appid=1&userid=1&verify=1&type=0&begin=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param type * 0:首页 1:我的树洞
	 * @param begin * 开始时间
	 * @callback MTreeHole_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  type:(double)type begin:(NSString*)begin {
		NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
		[array addObject:[NSString stringWithFormat:@"type=%@",[Frame number2String:type]]];
		[array addObject:[NSString stringWithFormat:@"begin=%@",begin==nil?@"":begin]];
		UpdateOne *updateone=[[UpdateOne alloc] init:@"MTreeHoleList" params:array delegate:delegate selecter:select];
		return [self instanceUpdate:updateone];
	}

	/**
	 *  树洞首页 /mobile?methodno=MTreeHoleList&debug=1&deviceid=1&appid=1&userid=1&verify=1&type=0&begin=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param type * 0:首页 1:我的树洞
	 * @param begin * 开始时间
	 * @callback MTreeHole_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  type:(double)type begin:(NSString*)begin {
		UpdateOne *update=[self get:delegate selecter:select type:type begin:begin];
		[DataManager loadData:[[NSArray alloc]initWithObjects:update,nil] delegate:delegate];
		return update;
	}


@end
