//
//  ApiMGetUserInfo
//
//  Created by ryan on 2014-06-18 15:39:59
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiMGetUserInfo.h"

@implementation ApiMGetUserInfo


	/**
	 * 用户详细信息 /mobile?methodno=MGetUserInfo&debug=1&deviceid=1&userid=88b9e9a9-ea31-11e3-b696-ac853d9d52b1&verify=&appid=nju
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MUser_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  {
		NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
		UpdateOne *updateone=[[UpdateOne alloc] init:@"MGetUserInfo" params:array  delegate:delegate selecter:select];
		return [self instanceUpdate:updateone];
	}

	/**
	 * 用户详细信息 /mobile?methodno=MGetUserInfo&debug=1&deviceid=1&userid=88b9e9a9-ea31-11e3-b696-ac853d9d52b1&verify=&appid=nju
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MUser_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  {
		UpdateOne *update=[self get:delegate selecter:select];
		[DataManager loadData:[[NSArray alloc]initWithObjects:update,nil] delegate:delegate];
		return update;
	}


@end
