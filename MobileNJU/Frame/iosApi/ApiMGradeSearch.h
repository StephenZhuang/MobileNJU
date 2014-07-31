//
//  ApiMGradeSearch
//
//  Created by ryan on 2014-07-31 17:37:07
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"


@interface ApiMGradeSearch : ApiUpdate


	/**
	 * 成绩查询  /mobile?methodno=MGradeSearch&debug=1&deviceid=1&userid=&verify=&account=&password=&url=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MCourseList_Builder
	 * @param url * url
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  url:(NSString*)url;
	/**
	 * 成绩查询  /mobile?methodno=MGradeSearch&debug=1&deviceid=1&userid=&verify=&account=&password=&url=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param url * url
	 * @callback MCourseList_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  url:(NSString*)url;

@end
