//
//  ApiMIndex
//
//  Created by ryan on 2014-08-06 14:28:21
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiMIndex.h"

@implementation ApiMIndex


	/**
	 * 首页 /mobile?methodno=MIndex&debug=1&deviceid=1&userid=fe34a40e-eac6-11e3-b696-ac853d9d52b1&verify=cf09a009-d221-466a-b9f0-d7d3b43dce7c&appid=nju&appid=nju
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MIndex_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  version:(NSString *)version{
		NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
        [array addObject:[NSString stringWithFormat:@"version=%@",version]];
		UpdateOne *updateone=[[UpdateOne alloc] init:@"MIndexNew" params:array  delegate:delegate selecter:select];
		return [self instanceUpdate:updateone];
	}

	/**
	 * 首页 /mobile?methodno=MIndex&debug=1&deviceid=1&userid=fe34a40e-eac6-11e3-b696-ac853d9d52b1&verify=cf09a009-d221-466a-b9f0-d7d3b43dce7c&appid=nju&appid=nju
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MIndex_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  version:(NSString *)version{
		UpdateOne *update=[self get:delegate selecter:select version:version];
		[DataManager loadData:[[NSArray alloc]initWithObjects:update,nil] delegate:delegate];
		return update;
	}


@end
