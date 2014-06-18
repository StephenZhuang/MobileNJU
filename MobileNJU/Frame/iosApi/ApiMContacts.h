//
//  ApiMContacts
//
//  Created by ryan on 2014-06-18 15:39:59
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"


@interface ApiMContacts : ApiUpdate


	/**
	 *  部门电话 /mobile?methodno=MContacts&debug=1&deviceid=1&userid=&verify=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MContactList_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select ;
	/**
	 *  部门电话 /mobile?methodno=MContacts&debug=1&deviceid=1&userid=&verify=
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MContactList_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select ;

@end
