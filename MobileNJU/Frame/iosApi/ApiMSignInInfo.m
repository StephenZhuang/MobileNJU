//
//  ApiMSignInInfo
//
//  Created by ryan on 2014-08-06 14:28:21
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiMSignInInfo.h"

@implementation ApiMSignInInfo


	/**
	 *  打卡信息 /mobile?methodno=MSignInInfo&debug=1&deviceid=1&userid=&verify=&account=&password=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param account * account
	 * @param password * password
	 * @param isReInput * 是否是用户重新输入
	 * @param isV * 该用户是否已验证
	 * @callback MSignInList_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  account:(NSString*)account password:(NSString*)password isreinput:(double)isReInput isv:(double)isV {
		NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
		[array addObject:[NSString stringWithFormat:@"account=%@",account==nil?@"":account]];
		[array addObject:[NSString stringWithFormat:@"password=%@",password==nil?@"":password]];
		[array addObject:[NSString stringWithFormat:@"isReInput=%@",[Frame number2String:isReInput]]];
		[array addObject:[NSString stringWithFormat:@"isV=%@",[Frame number2String:isV]]];
		UpdateOne *updateone=[[UpdateOne alloc] init:@"MSignInInfo" params:array  delegate:delegate selecter:select];
		return [self instanceUpdate:updateone];
	}

	/**
	 *  打卡信息 /mobile?methodno=MSignInInfo&debug=1&deviceid=1&userid=&verify=&account=&password=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param account * account
	 * @param password * password
	 * @param isReInput * 是否是用户重新输入
	 * @param isV * 该用户是否已验证
	 * @callback MSignInList_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  account:(NSString*)account password:(NSString*)password isreinput:(double)isReInput isv:(double)isV {
		UpdateOne *update=[self get:delegate selecter:select account:account password:password isreinput:isReInput isv:isV];
		[DataManager loadData:[[NSArray alloc]initWithObjects:update,nil] delegate:delegate];
		return update;
	}


@end
