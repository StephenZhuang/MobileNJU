//
//  ApiMSignInInfo
//
//  Created by ryan on 2014-06-04 18:30:34
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"


@interface ApiMSignInInfo : ApiUpdate


	/**
	 *  打卡信息(分页)
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MSignInList_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select ;
	/**
	 *  打卡信息(分页)
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MSignInList_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select ;

@end
