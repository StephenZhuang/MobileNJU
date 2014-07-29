//
//  ApiMScheduleAuto
//
//  Created by ryan on 2014-07-29 20:12:07
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"

#import "ZsndTreehole.pb.h"

@interface ApiMScheduleAuto : ApiUpdate


	/**
	 *  课程表 /mobile?methodno=MSchedule&debug=1&deviceid=1&account=&password=&code=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MClassList_Builder
	 * @param account * account 
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  account:(NSString*)account;
	/**
	 *  课程表 /mobile?methodno=MSchedule&debug=1&deviceid=1&account=&password=&code=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param account * account 
	 * @callback MClassList_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  account:(NSString*)account;

@end
