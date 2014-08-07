//
//  ApiMTreeHoleComment
//
//  Created by ryan on 2014-08-06 14:28:21
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiMTreeHoleComment.h"

@implementation ApiMTreeHoleComment


	/**
	 *  发布树洞评论 /mobile?methodno=MTreeHoleComment&debug=1&deviceid=1&appid=1&userid=1&verify=1&id=&content=&reply=&floor=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param id * 话题id
	 * @param content * 内容
	 * @param reply  被回复人id
	 * @param floor  被回复人楼层
	 * @param isLz  是否为楼主
	 * @callback MRet_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  id:(NSString*)id content:(NSString*)content reply:(NSString*)reply floor:(double)floor islz:(double)isLz {
		NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
		[array addObject:[NSString stringWithFormat:@"id=%@",id==nil?@"":id]];
		[array addObject:[NSString stringWithFormat:@"content=%@",content==nil?@"":content]];
		[array addObject:[NSString stringWithFormat:@"reply=%@",reply==nil?@"":reply]];
		[array addObject:[NSString stringWithFormat:@"floor=%@",[Frame number2String:floor]]];
		[array addObject:[NSString stringWithFormat:@"isLz=%@",[Frame number2String:isLz]]];
		UpdateOne *updateone=[[UpdateOne alloc] init:@"MTreeHoleComment" params:array  delegate:delegate selecter:select];
		return [self instanceUpdate:updateone];
	}

	/**
	 *  发布树洞评论 /mobile?methodno=MTreeHoleComment&debug=1&deviceid=1&appid=1&userid=1&verify=1&id=&content=&reply=&floor=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param id * 话题id
	 * @param content * 内容
	 * @param reply  被回复人id
	 * @param floor  被回复人楼层
	 * @param isLz  是否为楼主
	 * @callback MRet_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  id:(NSString*)id content:(NSString*)content reply:(NSString*)reply floor:(double)floor islz:(double)isLz {
		UpdateOne *update=[self get:delegate selecter:select id:id content:content reply:reply floor:floor islz:isLz];
		[DataManager loadData:[[NSArray alloc]initWithObjects:update,nil] delegate:delegate];
		return update;
	}


@end
