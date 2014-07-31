//
//  ApiMTreeHoleComment
//
//  Created by ryan on 2014-07-31 09:18:59
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiMTreeHoleComment.h"

@implementation ApiMTreeHoleComment


	/**
	 *  发布树洞评论 /mobile?methodno=MTreeHoleComment&debug=1&deviceid=1&appid=1&userid=1&verify=1&id=&content=&reply=&commentId=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param id * 话题id
	 * @param content * 内容
	 * @param reply  被回复人id
	 * @param commentId  评论id
	 * @callback MRet_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  id:(NSString*)id content:(NSString*)content reply:(NSString*)reply commentid:(NSString*)commentId {
		NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
		[array addObject:[NSString stringWithFormat:@"id=%@",id==nil?@"":id]];
		[array addObject:[NSString stringWithFormat:@"content=%@",content==nil?@"":content]];
		[array addObject:[NSString stringWithFormat:@"reply=%@",reply==nil?@"":reply]];
		[array addObject:[NSString stringWithFormat:@"commentId=%@",commentId==nil?@"":commentId]];
		UpdateOne *updateone=[[UpdateOne alloc] init:@"MTreeHoleComment" params:array  delegate:delegate selecter:select];
		return [self instanceUpdate:updateone];
	}

	/**
	 *  发布树洞评论 /mobile?methodno=MTreeHoleComment&debug=1&deviceid=1&appid=1&userid=1&verify=1&id=&content=&reply=&commentId=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param id * 话题id
	 * @param content * 内容
	 * @param reply  被回复人id
	 * @param commentId  评论id
	 * @callback MRet_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  id:(NSString*)id content:(NSString*)content reply:(NSString*)reply commentid:(NSString*)commentId {
		UpdateOne *update=[self get:delegate selecter:select id:id content:content reply:reply commentid:commentId];
		[DataManager loadData:[[NSArray alloc]initWithObjects:update,nil] delegate:delegate];
		return update;
	}


@end
