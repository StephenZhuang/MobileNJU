//
//  ApiMTreeHoleList
//
//  Created by ryan on 2014-08-06 14:28:21
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiMTreeHoleList.h"

@implementation ApiMTreeHoleList


	/**
	 *  树洞首页 /mobile?methodno=MTreeHoleList&debug=1&deviceid=1&appid=1&userid=1&verify=1&begin=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param type * 1:置顶+热门 2:按时间倒序分页
	 * @param begin  开始时间
	 * @callback MTreeHole_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  type:(double)type begin:(NSString*)begin page:(int) page limit:(int)limit{
		NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
		[array addObject:[NSString stringWithFormat:@"type=%@",[Frame number2String:type]]];
		[array addObject:[NSString stringWithFormat:@"begin=%@",begin==nil?@"":begin]];
        
        if (page!=0) {
            [array addObject:[NSString stringWithFormat:@"page=%d",page]];
             
        }
        if (limit!=0) {
            [array addObject:[NSString stringWithFormat:@"limit=%d",limit]];

        }
		UpdateOne *updateone=[[UpdateOne alloc] init:@"MTreeHoleList" params:array  delegate:delegate selecter:select];
		return [self instanceUpdate:updateone];
	}

	/**
	 *  树洞首页 /mobile?methodno=MTreeHoleList&debug=1&deviceid=1&appid=1&userid=1&verify=1&begin=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param type * 1:置顶+热门 2:按时间倒序分页
	 * @param begin  开始时间
	 * @callback MTreeHole_Builder
	*/
-(UpdateOne*)load:(id)delegate selecter:(SEL)select  type:(double)type begin:(NSString*)begin page:(int) page limit:(int)limit{
		UpdateOne *update=[self get:delegate selecter:select type:type begin:begin page:page limit:limit];
		[DataManager loadData:[[NSArray alloc]initWithObjects:update,nil] delegate:delegate];
		return update;
	}


@end
