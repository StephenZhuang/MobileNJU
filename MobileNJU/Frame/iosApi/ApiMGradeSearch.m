//
//  ApiMGradeSearch
//
//  Created by ryan on 2014-08-06 14:28:21
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiMGradeSearch.h"

@implementation ApiMGradeSearch


	/**
	 * 成绩查询  /mobile?methodno=MGradeSearch&debug=1&deviceid=1&userid=&verify=&account=&password=&url=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param url * url
	 * @callback MCourseList_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  url:(NSString*)url {
		NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
		[array addObject:[NSString stringWithFormat:@"url=%@",url==nil?@"":url]];
		UpdateOne *updateone=[[UpdateOne alloc] init:@"MGradeSearch" params:array  delegate:delegate selecter:select];
		return [self instanceUpdate:updateone];
	}

	/**
	 * 成绩查询  /mobile?methodno=MGradeSearch&debug=1&deviceid=1&userid=&verify=&account=&password=&url=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param url * url
	 * @callback MCourseList_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  url:(NSString*)url {
		UpdateOne *update=[self get:delegate selecter:select url:url];
		[DataManager loadData:[[NSArray alloc]initWithObjects:update,nil] delegate:delegate];
		return update;
	}


@end
