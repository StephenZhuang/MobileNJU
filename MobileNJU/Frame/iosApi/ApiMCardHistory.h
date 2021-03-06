//
//  ApiMCardHistory
//
//  Created by ryan on 2014-08-06 14:28:21
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"

#import "ZsndSystem.pb.h"

@interface ApiMCardHistory : ApiUpdate



/**
 *  一卡通消费记录  /mobile?methodno=MCardHistory&debug=1&deviceid=1&userid=&verify=&begin=&end=&account=&password=
 * @param delegate 回调类
 * @param select  回调函数
 * @callback MCardList_Builder
 * @param begin * 起始
 * @param end * 结束
 */
-(UpdateOne*)get:(id)delegate selecter:(SEL)select  begin:(NSString*)begin end:(NSString*)end account:(NSString*)account password:(NSString*)password;
/**
 *  一卡通消费记录  /mobile?methodno=MCardHistory&debug=1&deviceid=1&userid=&verify=&begin=&end=&account=&password=
 * @param delegate 回调类
 * @param select  回调函数
 * @param begin * 起始
 * @param end * 结束
 * @callback MCardList_Builder
 */
-(UpdateOne*)load:(id)delegate selecter:(SEL)select  begin:(NSString*)begin end:(NSString*)end account:(NSString*)account password:(NSString*)password;
@end
