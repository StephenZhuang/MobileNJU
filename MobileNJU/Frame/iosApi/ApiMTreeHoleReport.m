//
//  ApiMTreeHoleReport
//
//  Created by ryan on 2014-08-06 14:28:21
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiMTreeHoleReport.h"

@implementation ApiMTreeHoleReport


	/**
	 *  树洞举报 /mobile?methodno=MTreeHoleReport&debug=1&deviceid=1&appid=1&userid=1&verify=1&id=1
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param id * 话题id
	 * @callback MRet_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  id:(NSString*)id {
		NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
		[array addObject:[NSString stringWithFormat:@"id=%@",id==nil?@"":id]];
		UpdateOne *updateone=[[UpdateOne alloc] init:@"MTreeHoleReport" params:array  delegate:delegate selecter:select];
		return [self instanceUpdate:updateone];
	}

	/**
	 *  树洞举报 /mobile?methodno=MTreeHoleReport&debug=1&deviceid=1&appid=1&userid=1&verify=1&id=1
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param id * 话题id
	 * @callback MRet_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  id:(NSString*)id {
		UpdateOne *update=[self get:delegate selecter:select id:id];
		[DataManager loadData:[[NSArray alloc]initWithObjects:update,nil] delegate:delegate];
		return update;
	}


@end
