//
//  ApiMAddTreeHole
//
//  Created by ryan on 2014-06-18 15:39:59
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiMAddTreeHole.h"

@implementation ApiMAddTreeHole


	/**
	 *  发布树洞:MAddTopic     /mobile?methodno=MAddTreeHole&debug=1&deviceid=1&userid=1&verify=1
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MRet_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  {
		NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
		UpdateOne *updateone=[[UpdateOne alloc] init:@"MAddTreeHole" params:array  delegate:delegate selecter:select];
		return [self instanceUpdate:updateone];
	}

	/**
	 *  发布树洞:MAddTopic     /mobile?methodno=MAddTreeHole&debug=1&deviceid=1&userid=1&verify=1
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
