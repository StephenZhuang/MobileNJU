//
//  ApiMCardHistory
//
//  Created by ryan on 2014-08-06 14:28:21
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
-(UpdateOne*)get:(id)delegate selecter:(SEL)select  begin:(NSString*)begin end:(NSString*)end account:(NSString*)account password:(NSString*)password{
    NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
    [array addObject:[NSString stringWithFormat:@"begin=%@",begin==nil?@"":begin]];
    [array addObject:[NSString stringWithFormat:@"end=%@",end==nil?@"":end]];
    [array addObject:[NSString stringWithFormat:@"account=%@",account]];
    [array addObject:[NSString stringWithFormat:@"password=%@",password]];
    UpdateOne *updateone=[[UpdateOne alloc] init:@"MCardHistory" params:array  delegate:delegate selecter:select];
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
-(UpdateOne*)load:(id)delegate selecter:(SEL)select  begin:(NSString*)begin end:(NSString*)end account:(NSString*)account password:(NSString*)password{
    UpdateOne *update=[self get:delegate selecter:select begin:begin end:end account:account password:password];
    [DataManager loadData:[[NSArray alloc]initWithObjects:update,nil] delegate:delegate];
    return update;
}

@end
