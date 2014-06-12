//
//  ApiMNews
//
//  Created by ryan on 2014-06-12 13:12:48
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiMNews.h"

@implementation ApiMNews


	/**
	 *  新闻详情
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param id * id
	 * @callback MNews_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  id:(NSString*)id {
		NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
		[array addObject:[NSString stringWithFormat:@"id=%@",id==nil?@"":id]];
		UpdateOne *updateone=[[UpdateOne alloc] init:@"MNews" params:array delegate:delegate selecter:select];
		return [self instanceUpdate:updateone];
	}

	/**
	 *  新闻详情
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param id * id
	 * @callback MNews_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  id:(NSString*)id {
		UpdateOne *update=[self get:delegate selecter:select id:id];
		[DataManager loadData:[[NSArray alloc]initWithObjects:update,nil] delegate:delegate];
		return update;
	}


@end
