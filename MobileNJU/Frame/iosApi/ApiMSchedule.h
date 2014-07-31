//
//  ApiMSchedule
//
//  Created by ryan on 2014-07-31 09:18:59
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"

#import "ZsndTreehole.pb.h"

@interface ApiMSchedule : ApiUpdate


	/**
	 *   课程表-教务处全新抓取 /mobile?methodno=MSchedule&debug=1&deviceid=1&account=&password=&code=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MClassList_Builder
	 * @param account * account 
	 * @param password * password 
	 * @param code * code 
	 * @param isReInput * isReInput 
	 * @param isV * isV 
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  account:(NSString*)account password:(NSString*)password code:(NSString*)code isreinput:(NSString*)isReInput isv:(NSString*)isV;
	/**
	 *   课程表-教务处全新抓取 /mobile?methodno=MSchedule&debug=1&deviceid=1&account=&password=&code=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param account * account 
	 * @param password * password 
	 * @param code * code 
	 * @param isReInput * isReInput 
	 * @param isV * isV 
	 * @callback MClassList_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  account:(NSString*)account password:(NSString*)password code:(NSString*)code isreinput:(NSString*)isReInput isv:(NSString*)isV;

@end
