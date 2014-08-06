//
//  ApiMDelClass
//
//  Created by ryan on 2014-08-06 14:28:21
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiMDelClass.h"

@implementation ApiMDelClass


	/**
	 *   课程表-删除课程 /mobile?methodno=MSchedule&debug=1&deviceid=1&account=&password=&code=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param id * 课程id
	 * @callback MRet_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  id:(NSString*)id {
		NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
		[array addObject:[NSString stringWithFormat:@"id=%@",id==nil?@"":id]];
		UpdateOne *updateone=[[UpdateOne alloc] init:@"MDelClass" params:array  delegate:delegate selecter:select];
		return [self instanceUpdate:updateone];
	}

	/**
	 *   课程表-删除课程 /mobile?methodno=MSchedule&debug=1&deviceid=1&account=&password=&code=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param id * 课程id
	 * @callback MRet_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  id:(NSString*)id {
		UpdateOne *update=[self get:delegate selecter:select id:id];
		[DataManager loadData:[[NSArray alloc]initWithObjects:update,nil] delegate:delegate];
		return update;
	}


@end
