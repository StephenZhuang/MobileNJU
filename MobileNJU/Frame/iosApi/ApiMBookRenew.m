//
//  ApiMBookRenew
//
//  Created by ryan on 2014-07-31 17:37:07
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiMBookRenew.h"

@implementation ApiMBookRenew


	/**
	 *  图书馆续借  mobile?methodno=MBookRenew&debug=&deviceid=&appid=1&userid=&verify=&account=&password=&id=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param id * 图书id
	 * @param account * account
	 * @param password * password
	 * @callback MRet_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  id:(NSString*)id account:(NSString*)account password:(NSString*)password {
		NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
		[array addObject:[NSString stringWithFormat:@"id=%@",id==nil?@"":id]];
		[array addObject:[NSString stringWithFormat:@"account=%@",account==nil?@"":account]];
		[array addObject:[NSString stringWithFormat:@"password=%@",password==nil?@"":password]];
		UpdateOne *updateone=[[UpdateOne alloc] init:@"MBookRenew" params:array  delegate:delegate selecter:select];
		return [self instanceUpdate:updateone];
	}

	/**
	 *  图书馆续借  mobile?methodno=MBookRenew&debug=&deviceid=&appid=1&userid=&verify=&account=&password=&id=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param id * 图书id
	 * @param account * account
	 * @param password * password
	 * @callback MRet_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  id:(NSString*)id account:(NSString*)account password:(NSString*)password {
		UpdateOne *update=[self get:delegate selecter:select id:id account:account password:password];
		[DataManager loadData:[[NSArray alloc]initWithObjects:update,nil] delegate:delegate];
		return update;
	}


@end
