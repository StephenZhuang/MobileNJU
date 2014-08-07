//
//  ApiMDelClass
//
//  Created by ryan on 2014-08-06 14:28:21
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"

#import "ZsndSystem.pb.h"

@interface ApiMDelClass : ApiUpdate


	/**
	 *   课程表-删除课程 /mobile?methodno=MSchedule&debug=1&deviceid=1&account=&password=&code=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MRet_Builder
	 * @param id * 课程id
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  id:(NSString*)id;
	/**
	 *   课程表-删除课程 /mobile?methodno=MSchedule&debug=1&deviceid=1&account=&password=&code=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param id * 课程id
	 * @callback MRet_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  id:(NSString*)id;

@end
