//
//  ApiMMarketList
//
//  Created by ryan on 2014-08-06 14:28:21
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiMMarketList.h"

@implementation ApiMMarketList



/**
 *
 * @param delegate 回调类
 * @param select  回调函数
 * @param type * 0：全部跳蚤市场    1：我的跳蚤市场    默认为0,我的跳蚤市场虽然没有，但也预留一下
 * @param sold * 0:全部列表    1：未售列表   2：已售列表
 * @callback MMarketList_Builder
 */
-(UpdateOne*)get:(id)delegate selecter:(SEL)select  type:(NSString *)type {
    NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
    [array addObject:[NSString stringWithFormat:@"type=%@",type]];
    UpdateOne *updateone=[[UpdateOne alloc] init:@"MMarketList" params:array  delegate:delegate selecter:select];
    return [self instanceUpdate:updateone];
}


/**
 *
 * @param delegate 回调类
 * @param select  回调函数
 * @param type * 0：全部跳蚤市场    1：我的跳蚤市场    默认为0,我的跳蚤市场虽然没有，但也预留一下
 * @param sold * 0:全部列表    1：未售列表   2：已售列表
 * @callback MMarketList_Builder
 */
-(UpdateOne*)load:(id)delegate selecter:(SEL)select  type:(NSString *)type {
    UpdateOne *update=[self get:delegate selecter:select type:type];
    [DataManager loadData:[[NSArray alloc]initWithObjects:update,nil] delegate:delegate];
    return update;
}



@end
