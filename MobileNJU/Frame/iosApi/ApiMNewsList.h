//
//  ApiMNewsList
//
//  Created by ryan on 2014-07-31 17:37:07
//  Copyright (c) ryan All rights reserved.


/**
   
*/

#import "ApiUpdate.h"


@interface ApiMNewsList : ApiUpdate


	/**
	 * 新闻列表(分页) /mobile?methodno=MNewsList&debug=1&deviceid=1&userid=fe34a40e-eac6-11e3-b696-ac853d9d52b1&verify=cf09a009-d221-466a-b9f0-d7d3b43dce7c&page=2&limit=10&appid=nju
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MNewsList_Builder
	*/
	-(UpdateOne*)get:(id)delegate selecter:(SEL)select ;
	/**
	 * 新闻列表(分页) /mobile?methodno=MNewsList&debug=1&deviceid=1&userid=fe34a40e-eac6-11e3-b696-ac853d9d52b1&verify=cf09a009-d221-466a-b9f0-d7d3b43dce7c&page=2&limit=10&appid=nju
	 * @param delegate 回调类
	 * @param select  回调函数
	 * @callback MNewsList_Builder
	*/
	-(UpdateOne*)load:(id)delegate selecter:(SEL)select ;

@end
