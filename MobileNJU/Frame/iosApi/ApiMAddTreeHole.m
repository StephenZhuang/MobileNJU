//
//  ApiMAddTreeHole
//
//  Created by ryan on 2014-08-06 14:28:21
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiMAddTreeHole.h"

@implementation ApiMAddTreeHole


	/**
	 *  发布树洞:MAddTopic   /mobile?methodno=MAddTreeHole&debug=1&deviceid=1&userid=1&verify=1
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param topic * null
	 * @callback MRet_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  topic:(MAddTopic_Builder*) topic {
		NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
		UpdateOne *updateone=[[UpdateOne alloc] init:@"MAddTreeHole" params:array  postparams:topic delegate:delegate selecter:select];
		return [self instanceUpdate:updateone];
	}

	/**
	 *  发布树洞:MAddTopic   /mobile?methodno=MAddTreeHole&debug=1&deviceid=1&userid=1&verify=1
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param topic * null
	 * @callback MRet_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  topic:(MAddTopic_Builder*) topic {
		UpdateOne *update=[self get:delegate selecter:select topic:topic];
		[DataManager loadData:[[NSArray alloc]initWithObjects:update,nil] delegate:delegate];
		return update;
	}


@end
