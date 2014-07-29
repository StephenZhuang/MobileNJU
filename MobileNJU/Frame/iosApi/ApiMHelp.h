//
//  ApiMHelp
//
//  Created by ryan on 2014-07-29 20:12:07
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"

#import "ZsndTreehole.pb.h"

@interface ApiMHelp : ApiUpdate


	/**
	 *  办理流程(分页) /mobile?methodno=MHelp&debug=1&deviceid=1&userid=&verify=&page=&limit=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MContacts_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select ;
	/**
	 *  办理流程(分页) /mobile?methodno=MHelp&debug=1&deviceid=1&userid=&verify=&page=&limit=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MContacts_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select ;

@end
