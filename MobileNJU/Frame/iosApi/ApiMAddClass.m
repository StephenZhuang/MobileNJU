//
//  ApiMAddClass
//
//  Created by ryan on 2014-08-06 14:28:21
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiMAddClass.h"

@implementation ApiMAddClass


	/**
	 *   课程表-添加课程 /mobile?methodno=MSchedule&debug=1&deviceid=1&account=&password=&code=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param clas * 添加的课程表 
	 * @callback MRet_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  clas:(MAddClass_Builder*) clas {
		NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
		UpdateOne *updateone=[[UpdateOne alloc] init:@"MAddClass" params:array  postparams:clas delegate:delegate selecter:select];
		return [self instanceUpdate:updateone];
	}

	/**
	 *   课程表-添加课程 /mobile?methodno=MSchedule&debug=1&deviceid=1&account=&password=&code=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param clas * 添加的课程表 
	 * @callback MRet_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  clas:(MAddClass_Builder*) clas {
		UpdateOne *update=[self get:delegate selecter:select clas:clas];
		[DataManager loadData:[[NSArray alloc]initWithObjects:update,nil] delegate:delegate];
		return update;
	}


@end
