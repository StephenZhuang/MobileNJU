//
//  ApiMSignInInfo
//
//  Created by ryan on 2014-06-18 15:39:59
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"


@interface ApiMSignInInfo : ApiUpdate


	/**
	 *  打卡信息 /mobile?methodno=MSignInInfo&debug=1&deviceid=1&userid=&verify=&account=&password=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MSignInList_Builder
	 * @param account * account
	 * @param password * password
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  account:(NSString*)account password:(NSString*)password;
	/**
	 *  打卡信息 /mobile?methodno=MSignInInfo&debug=1&deviceid=1&userid=&verify=&account=&password=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param account * account
	 * @param password * password
	 * @callback MSignInList_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  account:(NSString*)account password:(NSString*)password;

@end
