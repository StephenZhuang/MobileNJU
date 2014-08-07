//
//  ApiMTreeHoleComments
//
//  Created by ryan on 2014-08-06 14:28:21
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiMTreeHoleComments.h"

@implementation ApiMTreeHoleComments


	/**
	 *  树洞评论 /mobile?methodno=MTreeHoleComments&debug=1&deviceid=1&appid=1&userid=1&verify=1&id=1&begin=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param id * 话题id
	 * @param begin  开始时间
	 * @callback MCommentList_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  id:(NSString*)id begin:(NSString*)begin {
		NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
		[array addObject:[NSString stringWithFormat:@"id=%@",id==nil?@"":id]];
		[array addObject:[NSString stringWithFormat:@"begin=%@",begin==nil?@"":begin]];
		UpdateOne *updateone=[[UpdateOne alloc] init:@"MTreeHoleComments" params:array  delegate:delegate selecter:select];
		return [self instanceUpdate:updateone];
	}

	/**
	 *  树洞评论 /mobile?methodno=MTreeHoleComments&debug=1&deviceid=1&appid=1&userid=1&verify=1&id=1&begin=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param id * 话题id
	 * @param begin  开始时间
	 * @callback MCommentList_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  id:(NSString*)id begin:(NSString*)begin {
		UpdateOne *update=[self get:delegate selecter:select id:id begin:begin];
		[DataManager loadData:[[NSArray alloc]initWithObjects:update,nil] delegate:delegate];
		return update;
	}


@end
