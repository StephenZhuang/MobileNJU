//
//  ApiMChatMatch
//
//  Created by ryan on 2014-06-09 10:27:58
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiMChatMatch.h"

@implementation ApiMChatMatch


	/**
	 *  南呱匹配 /mobile?methodno=MChatMatch&debug=1&appid=nju&deviceid=1&userid=1&verify=1
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MMatch_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  {
		NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
		UpdateOne *updateone=[[UpdateOne alloc] init:@"MChatMatch" params:array delegate:delegate selecter:select];
		return [self instanceUpdate:updateone];
	}

	/**
	 *  南呱匹配 /mobile?methodno=MChatMatch&debug=1&appid=nju&deviceid=1&userid=1&verify=1
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MMatch_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  {
		UpdateOne *update=[self get:delegate selecter:select];
		[DataManager loadData:[[NSArray alloc]initWithObjects:update,nil] delegate:delegate];
		return update;
	}


@end
