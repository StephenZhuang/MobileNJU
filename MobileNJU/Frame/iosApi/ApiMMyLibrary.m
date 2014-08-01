//
//  ApiMMyLibrary
//
//  Created by ryan on 2014-07-31 17:37:06
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
	 * @callback MBookList_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  account:(NSString*)account password:(NSString*)password {
		NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
		[array addObject:[NSString stringWithFormat:@"account=%@",account==nil?@"":account]];
		[array addObject:[NSString stringWithFormat:@"password=%@",password==nil?@"":password]];
		UpdateOne *updateone=[[UpdateOne alloc] init:@"MMyLibrary" params:array  delegate:delegate selecter:select];
		return [self instanceUpdate:updateone];
	}

	/**
	 *  个人图书馆(分页) mobile?methodno=MMyLibrary&debug=1&userid=&verify=&deviceid=&appid=&account=&password=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param account * account
	 * @param password * password
	 * @callback MBookList_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  account:(NSString*)account password:(NSString*)password {
		UpdateOne *update=[self get:delegate selecter:select account:account password:password];
		[DataManager loadData:[[NSArray alloc]initWithObjects:update,nil] delegate:delegate];
		return update;
	}


@end
