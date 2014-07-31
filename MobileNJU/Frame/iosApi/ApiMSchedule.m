//
//  ApiMSchedule
//
//  Created by ryan on 2014-07-31 09:18:59
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiMSchedule.h"

@implementation ApiMSchedule


	/**
	 *   课程表-教务处全新抓取 /mobile?methodno=MSchedule&debug=1&deviceid=1&account=&password=&code=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param account * account 
	 * @param password * password 
	 * @param code * code 
	 * @param isReInput * isReInput 
	 * @param isV * isV 
	 * @callback MClassList_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  account:(NSString*)account password:(NSString*)password code:(NSString*)code isreinput:(NSString*)isReInput isv:(NSString*)isV {
		NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
		[array addObject:[NSString stringWithFormat:@"account=%@",account==nil?@"":account]];
		[array addObject:[NSString stringWithFormat:@"password=%@",password==nil?@"":password]];
		[array addObject:[NSString stringWithFormat:@"code=%@",code==nil?@"":code]];
		[array addObject:[NSString stringWithFormat:@"isReInput=%@",isReInput==nil?@"":isReInput]];
		[array addObject:[NSString stringWithFormat:@"isV=%@",isV==nil?@"":isV]];
		UpdateOne *updateone=[[UpdateOne alloc] init:@"MSchedule" params:array  delegate:delegate selecter:select];
		return [self instanceUpdate:updateone];
	}

	/**
	 *   课程表-教务处全新抓取 /mobile?methodno=MSchedule&debug=1&deviceid=1&account=&password=&code=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param account * account 
	 * @param password * password 
	 * @param code * code 
	 * @param isReInput * isReInput 
	 * @param isV * isV 
	 * @callback MClassList_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  account:(NSString*)account password:(NSString*)password code:(NSString*)code isreinput:(NSString*)isReInput isv:(NSString*)isV {
		UpdateOne *update=[self get:delegate selecter:select account:account password:password code:code isreinput:isReInput isv:isV];
		[DataManager loadData:[[NSArray alloc]initWithObjects:update,nil] delegate:delegate];
		return update;
	}


@end
