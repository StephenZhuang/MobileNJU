//
//  ApiMCardHistory
//
//  Created by ryan on 2014-06-09 10:27:58
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiMCardHistory.h"

@implementation ApiMCardHistory


	/**
	 *  一卡通消费记录  /mobile?methodno=MCardHistory&debug=1&deviceid=1&userid=&verify=&begin=&end=&account=&password=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param begin * 起始
	 * @param end * 结束
	 * @callback MCardList_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  begin:(NSString*)begin end:(NSString*)end {
		NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
		[array addObject:[NSString stringWithFormat:@"begin=%@",begin==nil?@"":begin]];
		[array addObject:[NSString stringWithFormat:@"end=%@",end==nil?@"":end]];
		UpdateOne *updateone=[[UpdateOne alloc] init:@"MCardHistory" params:array delegate:delegate selecter:select];
		return [self instanceUpdate:updateone];
	}

	/**
	 *  一卡通消费记录  /mobile?methodno=MCardHistory&debug=1&deviceid=1&userid=&verify=&begin=&end=&account=&password=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param begin * 起始
	 * @param end * 结束
	 * @callback MCardList_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  begin:(NSString*)begin end:(NSString*)end {
		UpdateOne *update=[self get:delegate selecter:select begin:begin end:end];
		[DataManager loadData:[[NSArray alloc]initWithObjects:update,nil] delegate:delegate];
		return update;
	}


@end
