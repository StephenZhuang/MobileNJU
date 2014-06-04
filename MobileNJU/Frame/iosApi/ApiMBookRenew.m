//
//  ApiMBookRenew
//
//  Created by ryan on 2014-06-04 18:30:33
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiMBookRenew.h"

@implementation ApiMBookRenew


	/**
	 *  图书馆续借  mobile?methodno=MBookRenew&debug=&deviceid=&appid=1&userid=&verify=&account=&password=&id=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param id * 图书id
	 * @callback MRet_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  id:(NSString*)id {
		NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
		[array addObject:[NSString stringWithFormat:@"id=%@",id==nil?@"":id]];
		UpdateOne *updateone=[[UpdateOne alloc] init:@"MBookRenew" params:array delegate:delegate selecter:select];
		return [self instanceUpdate:updateone];
	}

	/**
	 *  图书馆续借  mobile?methodno=MBookRenew&debug=&deviceid=&appid=1&userid=&verify=&account=&password=&id=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param id * 图书id
	 * @callback MRet_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  id:(NSString*)id {
		UpdateOne *update=[self get:delegate selecter:select id:id];
		[DataManager loadData:[[NSArray alloc]initWithObjects:update,nil] delegate:delegate];
		return update;
	}


@end
