//
//  ApiMTagTreeHole
//
//  Created by ryan on 2014-08-06 14:28:21
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiMTagTreeHole.h"

@implementation ApiMTagTreeHole


	/**
	 *  话题树洞 /mobile?methodno=MTagTreeHole&debug=1&deviceid=1&appid=1&userid=1&verify=1&tagid=&begin=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param tagid * 话题id
	 * @param begin  开始时间
	 * @callback MTreeHole_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  tagid:(NSString*)tagid begin:(NSString*)begin {
		NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
		[array addObject:[NSString stringWithFormat:@"tagid=%@",tagid==nil?@"":tagid]];
		[array addObject:[NSString stringWithFormat:@"begin=%@",begin==nil?@"":begin]];
		UpdateOne *updateone=[[UpdateOne alloc] init:@"MTagTreeHole" params:array  delegate:delegate selecter:select];
		return [self instanceUpdate:updateone];
	}

	/**
	 *  话题树洞 /mobile?methodno=MTagTreeHole&debug=1&deviceid=1&appid=1&userid=1&verify=1&tagid=&begin=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param tagid * 话题id
	 * @param begin  开始时间
	 * @callback MTreeHole_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  tagid:(NSString*)tagid begin:(NSString*)begin {
		UpdateOne *update=[self get:delegate selecter:select tagid:tagid begin:begin];
		[DataManager loadData:[[NSArray alloc]initWithObjects:update,nil] delegate:delegate];
		return update;
	}


@end
