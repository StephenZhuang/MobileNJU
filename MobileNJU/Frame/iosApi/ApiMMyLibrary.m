//
//  ApiMMyLibrary
//
//  Created by ryan on 2014-07-31 09:18:59
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiMMyLibrary.h"

@implementation ApiMMyLibrary


	/**
	 *  个人图书馆(分页) mobile?methodno=MMyLibrary&debug=1&userid=&verify=&deviceid=&appid=&account=&password=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param account * account
	 * @param password * password
	 * @param isReInput * 是否是用户重新输入
	 * @param isV * 该用户是否已验证
	 * @callback MBookList_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  account:(NSString*)account password:(NSString*)password isreinput:(double)isReInput isv:(double)isV {
		NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
		[array addObject:[NSString stringWithFormat:@"account=%@",account==nil?@"":account]];
		[array addObject:[NSString stringWithFormat:@"password=%@",password==nil?@"":password]];
		[array addObject:[NSString stringWithFormat:@"isReInput=%@",[Frame number2String:isReInput]]];
		[array addObject:[NSString stringWithFormat:@"isV=%@",[Frame number2String:isV]]];
		UpdateOne *updateone=[[UpdateOne alloc] init:@"MMyLibrary" params:array  delegate:delegate selecter:select];
		return [self instanceUpdate:updateone];
	}

	/**
	 *  个人图书馆(分页) mobile?methodno=MMyLibrary&debug=1&userid=&verify=&deviceid=&appid=&account=&password=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param account * account
	 * @param password * password
	 * @param isReInput * 是否是用户重新输入
	 * @param isV * 该用户是否已验证
	 * @callback MBookList_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  account:(NSString*)account password:(NSString*)password isreinput:(double)isReInput isv:(double)isV {
		UpdateOne *update=[self get:delegate selecter:select account:account password:password isreinput:isReInput isv:isV];
		[DataManager loadData:[[NSArray alloc]initWithObjects:update,nil] delegate:delegate];
		return update;
	}


@end
