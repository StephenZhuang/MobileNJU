//
//  ApiMSchedule
//
//  Created by ryan on 2014-06-04 18:30:33
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiMSchedule.h"

@implementation ApiMSchedule


	/**
	 *  课程表
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MClassList_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  {
		NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
        
		UpdateOne *updateone=[[UpdateOne alloc] init:@"MSchedule" params:array delegate:delegate selecter:select];
		return [self instanceUpdate:updateone];
	}

	/**
	 *  课程表
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MClassList_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  {
		UpdateOne *update=[self get:delegate selecter:select];
		[DataManager loadData:[[NSArray alloc]initWithObjects:update,nil] delegate:delegate];
		return update;
	}


@end
