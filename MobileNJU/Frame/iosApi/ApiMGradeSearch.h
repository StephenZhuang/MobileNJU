//
//  ApiMGradeSearch
//
//  Created by ryan on 2014-06-04 18:30:33
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"


@interface ApiMGradeSearch : ApiUpdate


	/**
	 * 成绩查询
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MCourseList_Builder
	 * @param time * 学期：如2012-2013-1
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  time:(NSString*)time;
	/**
	 * 成绩查询
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param time * 学期：如2012-2013-1
	 * @callback MCourseList_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  time:(NSString*)time;

@end
