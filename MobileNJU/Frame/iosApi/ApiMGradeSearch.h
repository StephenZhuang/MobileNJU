//
//  ApiMGradeSearch
//
//  Created by ryan on 2014-06-09 10:27:58
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
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  url:(NSString*)url account:(NSString*)account password:(NSString*)password;
	/**
	 * 成绩查询  /mobile?methodno=MGradeSearch&debug=1&deviceid=1&userid=&verify=&account=&password=&url=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param url * url
	 * @callback MCourseList_Builder
	*/
-(UpdateOne*)load:(id)delegate selecter:(SEL)select  url:(NSString*)url account:(NSString*)account password:(NSString*)password;

@end
