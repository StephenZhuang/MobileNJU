//
//  ApiMGradeSearch
//
//  Created by ryan on 2014-06-12 13:12:48
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
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  url:(NSString*)url account:(NSString *)account password:(NSString *)password{
		NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
		[array addObject:[NSString stringWithFormat:@"url=%@",url==nil?@"":url]];
        [array addObject:[NSString stringWithFormat:@"account=%@",url==nil?@"":account]];
		[array addObject:[NSString stringWithFormat:@"password=%@",url==nil?@"":password]];

		UpdateOne *updateone=[[UpdateOne alloc] init:@"MGradeSearch" params:array delegate:delegate selecter:select];
		return [self instanceUpdate:updateone];
	}

	/**
	 * 成绩查询  /mobile?methodno=MGradeSearch&debug=1&deviceid=1&userid=&verify=&account=&password=&url=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param url * url
	 * @callback MCourseList_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  url:(NSString*)url account:(NSString *)account password:(NSString *)password{
		UpdateOne *update=[self get:delegate selecter:select url:url account:account password:password];
		[DataManager loadData:[[NSArray alloc]initWithObjects:update,nil] delegate:delegate];
		return update;
	}


@end
