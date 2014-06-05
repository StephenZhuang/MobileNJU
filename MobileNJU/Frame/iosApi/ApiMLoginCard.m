//
//  ApiMLoginCard
//
//  Created by ryan on 2014-06-04 18:30:34
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiMLoginCard.h"

@implementation ApiMLoginCard


	/**
	 * 一卡通登录
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param account * 学号
	 * @param password * 密码
	 * @param code * 验证码
	 * @callback MRet_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  account:(NSString*)account password:(NSString*)password code:(NSString*)code {
		NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
		[array addObject:[NSString stringWithFormat:@"account=%@",account==nil?@"":account]];
		[array addObject:[NSString stringWithFormat:@"password=%@",password==nil?@"":password]];
		[array addObject:[NSString stringWithFormat:@"code=%@",code==nil?@"":code]];
		UpdateOne *updateone=[[UpdateOne alloc] init:@"MLoginCard" params:array delegate:delegate selecter:select];
		return [self instanceUpdate:updateone];
	}

	/**
	 * 一卡通登录
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param account * 学号
	 * @param password * 密码
	 * @param code * 验证码
	 * @callback MRet_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  account:(NSString*)account password:(NSString*)password code:(NSString*)code {
		UpdateOne *update=[self get:delegate selecter:select account:account password:password code:code];
		[DataManager loadData:[[NSArray alloc]initWithObjects:update,nil] delegate:delegate];
		return update;
	}


@end
