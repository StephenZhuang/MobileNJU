//
//  ApiMNewsList
//
//  Created by ryan on 2014-06-04 18:30:33
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiMNewsList.h"

@implementation ApiMNewsList


	/**
	 * 新闻列表(分页)
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MNewsList_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select page:(NSInteger)page{
		NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
        [array addObject:[NSString stringWithFormat:@"page=%d",page]];
        [array addObject:[NSString stringWithFormat:@"limit=%d",10]];
		UpdateOne *updateone=[[UpdateOne alloc] init:@"MNewsList" params:array delegate:delegate selecter:select];
		return [self instanceUpdate:updateone];
	}

	/**
	 * 新闻列表(分页)
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MNewsList_Builder
	*/
    -(UpdateOne*)load:(id)delegate selecter:(SEL)select page:(NSInteger)page{
		UpdateOne *update=[self get:delegate selecter:select page:page];
		[DataManager loadData:[[NSArray alloc]initWithObjects:update,nil] delegate:delegate];
		return update;
	}


@end
