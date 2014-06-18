//
//  ApiMSchedule
//
//  Created by ryan on 2014-06-18 15:39:59
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiMSchedule.h"

@implementation ApiMSchedule


	/**
	 *  课程表 /mobile?methodno=MSchedule&debug=1&deviceid=1&account=&password=&code=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param code * 第一次登录时不需要，如果有验证码，则第二次请求时必须
	 * @param account * account
	 * @param password * password
	 * @callback MClassList_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  code:(NSString*)code account:(NSString*)account password:(NSString*)password {
		NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
		[array addObject:[NSString stringWithFormat:@"code=%@",code==nil?@"":code]];
		[array addObject:[NSString stringWithFormat:@"account=%@",account==nil?@"":account]];
		[array addObject:[NSString stringWithFormat:@"password=%@",password==nil?@"":password]];
		UpdateOne *updateone=[[UpdateOne alloc] init:@"MSchedule" params:array  delegate:delegate selecter:select];
		return [self instanceUpdate:updateone];
	}

	/**
	 *  课程表 /mobile?methodno=MSchedule&debug=1&deviceid=1&account=&password=&code=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param code * 第一次登录时不需要，如果有验证码，则第二次请求时必须
	 * @param account * account
	 * @param password * password
	 * @callback MClassList_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  code:(NSString*)code account:(NSString*)account password:(NSString*)password {
		UpdateOne *update=[self get:delegate selecter:select code:code account:account password:password];
		[DataManager loadData:[[NSArray alloc]initWithObjects:update,nil] delegate:delegate];
		return update;
	}


@end
