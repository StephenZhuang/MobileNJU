//
//  ApiMAddClass
//
//  Created by ryan on 2014-07-31 13:42:28
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"

#import "ZsndTreehole.pb.h"

@interface ApiMAddClass : ApiUpdate


	/**
	 *   课程表-添加课程 /mobile?methodno=MSchedule&debug=1&deviceid=1&account=&password=&code=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MRet_Builder
	 * @param clas * 添加的课程表 
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  ;
	/**
	 *   课程表-添加课程 /mobile?methodno=MSchedule&debug=1&deviceid=1&account=&password=&code=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param clas * 添加的课程表 
	 * @callback MRet_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  ;

@end
