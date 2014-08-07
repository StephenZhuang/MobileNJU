//
//  ApiMGetTags
//
//  Created by ryan on 2014-08-06 14:28:21
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiMGetTags.h"

@implementation ApiMGetTags


	/**
	 *  获取所有话题(前三个首页显示) /mobile?methodno=MGetTags&debug=1&deviceid=1&appid=1&userid=1&verify=1
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MTagList_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  {
		NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
		UpdateOne *updateone=[[UpdateOne alloc] init:@"MGetTags" params:array  delegate:delegate selecter:select];
		return [self instanceUpdate:updateone];
	}

	/**
	 *  获取所有话题(前三个首页显示) /mobile?methodno=MGetTags&debug=1&deviceid=1&appid=1&userid=1&verify=1
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MTagList_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  {
		UpdateOne *update=[self get:delegate selecter:select];
		[DataManager loadData:[[NSArray alloc]initWithObjects:update,nil] delegate:delegate];
		return update;
	}


@end
