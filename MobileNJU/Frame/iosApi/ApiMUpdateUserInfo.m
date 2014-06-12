//
//  ApiMUpdateUserInfo
//
//  Created by ryan on 2014-06-09 10:27:58
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiMUpdateUserInfo.h"

@implementation ApiMUpdateUserInfo


	/**
	 * 用户信息修改 /mobile?methodno=MUpdateUserInfo&debug=1&appid=nju&deviceid=1&userid=&verify=&nickname=&belong=&sex=&birthday=tags=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param nickname * 昵称
	 * @param belong * 院系
	 * @param sex * 0:女 1:男
	 * @param birthday * 生日
	 * @param tags  标签(逗号分隔)
	 * @callback MUser_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select  nickname:(NSString*)nickname belong:(NSString*)belong sex:(double)sex birthday:(NSString*)birthday tags:(NSString*)tags {
		NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:nil];
		[array addObject:[NSString stringWithFormat:@"nickname=%@",nickname==nil?@"":nickname]];
		[array addObject:[NSString stringWithFormat:@"belong=%@",belong==nil?@"":belong]];
		[array addObject:[NSString stringWithFormat:@"sex=%@",[Frame number2String:sex]]];
		[array addObject:[NSString stringWithFormat:@"birthday=%@",birthday==nil?@"":birthday]];
		[array addObject:[NSString stringWithFormat:@"tags=%@",tags==nil?@"":tags]];
		UpdateOne *updateone=[[UpdateOne alloc] init:@"MUpdateUserInfo" params:array delegate:delegate selecter:select];
		return [self instanceUpdate:updateone];
	}

	/**
	 * 用户信息修改 /mobile?methodno=MUpdateUserInfo&debug=1&appid=nju&deviceid=1&userid=&verify=&nickname=&belong=&sex=&birthday=tags=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @param nickname * 昵称
	 * @param belong * 院系
	 * @param sex * 0:女 1:男
	 * @param birthday * 生日
	 * @param tags  标签(逗号分隔)
	 * @callback MUser_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select  nickname:(NSString*)nickname belong:(NSString*)belong sex:(double)sex birthday:(NSString*)birthday tags:(NSString*)tags {
		UpdateOne *update=[self get:delegate selecter:select nickname:nickname belong:belong sex:sex birthday:birthday tags:tags];
		[DataManager loadData:[[NSArray alloc]initWithObjects:update,nil] delegate:delegate];
		return update;
	}


@end
