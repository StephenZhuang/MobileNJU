//
//  ApiMSearchBook
//
//  Created by ryan on 2014-07-29 20:12:07
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiMSearchBook.h"

@implementation ApiMSearchBook


	/**
	 *  图书馆检索(分页)  /mobile?methodno=MSearchBook&debug=1&userid=&verify=&deviceid=&appid=&page=&limit=&keyword=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param keyword * 关键字
	 * @callback MBookList_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  keyword:(NSString*)keyword {
		NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
		[array addObject:[NSString stringWithFormat:@"keyword=%@",keyword==nil?@"":keyword]];
		UpdateOne *updateone=[[UpdateOne alloc] init:@"MSearchBook" params:array  delegate:delegate selecter:select];
		return [self instanceUpdate:updateone];
	}

	/**
	 *  图书馆检索(分页)  /mobile?methodno=MSearchBook&debug=1&userid=&verify=&deviceid=&appid=&page=&limit=&keyword=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param keyword * 关键字
	 * @callback MBookList_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  keyword:(NSString*)keyword {
		UpdateOne *update=[self get:delegate selecter:select keyword:keyword];
		[DataManager loadData:[[NSArray alloc]initWithObjects:update,nil] delegate:delegate];
		return update;
	}


@end
