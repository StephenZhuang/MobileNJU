//
//  ApiMGetWelcomePage
//
//  Created by ryan on 2014-06-12 13:12:48
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiMGetWelcomePage.h"

@implementation ApiMGetWelcomePage


	/**
	 * 获取欢迎页   /mobile?methodno=MGetWelcomePage&debug=&deviceid=&appid=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MRet_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  {
		NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
		UpdateOne *updateone=[[UpdateOne alloc] init:@"MGetWelcomePage" params:array delegate:delegate selecter:select];
		return [self instanceUpdate:updateone];
	}

	/**
	 * 获取欢迎页   /mobile?methodno=MGetWelcomePage&debug=&deviceid=&appid=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MRet_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  {
		UpdateOne *update=[self get:delegate selecter:select];
		[DataManager loadData:[[NSArray alloc]initWithObjects:update,nil] delegate:delegate];
		return update;
	}


@end
