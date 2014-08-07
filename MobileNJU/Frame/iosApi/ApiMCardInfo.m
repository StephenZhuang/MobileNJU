//
//  ApiMCardInfo
//
//  Created by ryan on 2014-08-06 14:28:21
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiMCardInfo.h"

@implementation ApiMCardInfo


	/**
	 *  一卡通余额 /mobile?methodno=MCardInfo&debug=1&deviceid=1&userid=&verify=&account=&password=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param code * 第一次登录时不需要，如果有验证码，则第二次请求时必须
	 * @param account * account
	 * @param password * password
	 * @callback MCard_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  code:(NSString*)code account:(NSString*)account password:(NSString*)password isV:(int)isV isReInput:(int)isReInput{
		NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
        if (code!=nil) {
            [array addObject:[NSString stringWithFormat:@"code=%@",code==nil?@"":code]];
        }
		[array addObject:[NSString stringWithFormat:@"account=%@",account==nil?@"":account]];
		[array addObject:[NSString stringWithFormat:@"password=%@",password==nil?@"":password]];
        [array addObject:[NSString stringWithFormat:@"isReInput=%d",isReInput]];
        [array addObject:[NSString stringWithFormat:@"isV=%d",isV]];
		UpdateOne *updateone=[[UpdateOne alloc] init:@"MCardInfo" params:array  delegate:delegate selecter:select];
		return [self instanceUpdate:updateone];
	}

	/**
	 *  一卡通余额 /mobile?methodno=MCardInfo&debug=1&deviceid=1&userid=&verify=&account=&password=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param code * 第一次登录时不需要，如果有验证码，则第二次请求时必须
	 * @param account * account
	 * @param password * password
	 * @callback MCard_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  code:(NSString*)code account:(NSString*)account password:(NSString*)password isV:(int)isV isReInput:(int)isReInput{
		UpdateOne *update=[self get:delegate selecter:select code:code account:account password:password isV:isV isReInput:isReInput ];
		[DataManager loadData:[[NSArray alloc]initWithObjects:update,nil] delegate:delegate];
		return update;
	}


@end
