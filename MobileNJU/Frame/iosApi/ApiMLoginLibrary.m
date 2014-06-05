//
//  ApiMLoginLibrary
//
//  Created by ryan on 2014-06-04 18:30:33
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiMLoginLibrary.h"

@implementation ApiMLoginLibrary


	/**
	 *  图书馆登录 
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param account * 学号
	 * @param password * 密码
	 * @callback MRet_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  account:(NSString*)account password:(NSString*)password {
		NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
		[array addObject:[NSString stringWithFormat:@"account=%@",account==nil?@"":account]];
		[array addObject:[NSString stringWithFormat:@"password=%@",password==nil?@"":password]];
		UpdateOne *updateone=[[UpdateOne alloc] init:@"MLoginLibrary" params:array delegate:delegate selecter:select];
		return [self instanceUpdate:updateone];
	}

	/**
	 *  图书馆登录 
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param account * 学号
	 * @param password * 密码
	 * @callback MRet_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  account:(NSString*)account password:(NSString*)password {
		UpdateOne *update=[self get:delegate selecter:select account:account password:password];
		[DataManager loadData:[[NSArray alloc]initWithObjects:update,nil] delegate:delegate];
		return update;
	}


@end
