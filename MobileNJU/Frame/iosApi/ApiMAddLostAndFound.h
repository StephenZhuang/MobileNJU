//
//  ApiMAddLostAndFound
//
//  Created by ryan on 2014-07-29 20:12:07
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"

#import "ZsndTreehole.pb.h"

@interface ApiMAddLostAndFound : ApiUpdate


	/**
	 *  添加失物招领:MAddLostOrFound /mobile?methodno=MAddLostAndFound&debug=&appid=&deviceid=&userid=&verify=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MRet_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select ;
	/**
	 *  添加失物招领:MAddLostOrFound /mobile?methodno=MAddLostAndFound&debug=&appid=&deviceid=&userid=&verify=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MRet_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select ;

@end
