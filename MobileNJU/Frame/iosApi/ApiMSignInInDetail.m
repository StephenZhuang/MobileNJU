//
//  ApiMSignInInDetail
//
//  Created by ryan on 2014-08-06 14:28:21
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiMSignInInDetail.h"

@implementation ApiMSignInInDetail


	/**
	 *  打卡详情 /mobile?methodno= MSignInInDetail&debug=1&deviceid=1&userid=&verify=&account=&password=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param account * account
	 * @param password * password
	 * @callback MSignInList_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  account:(NSString*)account password:(NSString*)password {
		NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
		[array addObject:[NSString stringWithFormat:@"account=%@",account==nil?@"":account]];
		[array addObject:[NSString stringWithFormat:@"password=%@",password==nil?@"":password]];
		UpdateOne *updateone=[[UpdateOne alloc] init:@"MSignInInDetail" params:array  delegate:delegate selecter:select];
		return [self instanceUpdate:updateone];
	}

	/**
	 *  打卡详情 /mobile?methodno= MSignInInDetail&debug=1&deviceid=1&userid=&verify=&account=&password=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param account * account
	 * @param password * password
	 * @callback MSignInList_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  account:(NSString*)account password:(NSString*)password {
		UpdateOne *update=[self get:delegate selecter:select account:account password:password];
		[DataManager loadData:[[NSArray alloc]initWithObjects:update,nil] delegate:delegate];
		return update;
	}


@end
