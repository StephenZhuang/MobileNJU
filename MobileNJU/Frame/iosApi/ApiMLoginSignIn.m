//
//  ApiMLoginSignIn
//
//  Created by ryan on 2014-06-04 18:30:34
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiMLoginSignIn.h"

@implementation ApiMLoginSignIn


	/**
	 *  打卡登录
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param account * 学号
	 * @callback MRet_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  account:(NSString*)account {
		NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
		[array addObject:[NSString stringWithFormat:@"account=%@",account==nil?@"":account]];
		UpdateOne *updateone=[[UpdateOne alloc] init:@"MLoginSignIn" params:array delegate:delegate selecter:select];
		return [self instanceUpdate:updateone];
	}

	/**
	 *  打卡登录
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param account * 学号
	 * @callback MRet_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  account:(NSString*)account {
		UpdateOne *update=[self get:delegate selecter:select account:account];
		[DataManager loadData:[[NSArray alloc]initWithObjects:update,nil] delegate:delegate];
		return update;
	}


@end
