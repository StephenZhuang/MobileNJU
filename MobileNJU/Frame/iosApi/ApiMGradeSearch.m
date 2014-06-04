//
//  ApiMGradeSearch
//
//  Created by ryan on 2014-06-04 18:30:33
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiMGradeSearch.h"

@implementation ApiMGradeSearch


	/**
	 * 成绩查询
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param time * 学期：如2012-2013-1
	 * @callback MCourseList_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  time:(NSString*)time {
		NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
		[array addObject:[NSString stringWithFormat:@"time=%@",time==nil?@"":time]];
		UpdateOne *updateone=[[UpdateOne alloc] init:@"MGradeSearch" params:array delegate:delegate selecter:select];
		return [self instanceUpdate:updateone];
	}

	/**
	 * 成绩查询
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param time * 学期：如2012-2013-1
	 * @callback MCourseList_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  time:(NSString*)time {
		UpdateOne *update=[self get:delegate selecter:select time:time];
		[DataManager loadData:[[NSArray alloc]initWithObjects:update,nil] delegate:delegate];
		return update;
	}


@end
