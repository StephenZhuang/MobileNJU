//
//  ApisFactory
//
//  Created by ryan on 2014-06-04 18:30:34
//  Copyright (c) ryan All rights reserved.


/**
   apis集合类
*/

#import "ApisFactory.h"

@implementation ApisFactory


	
	/**
	 *  南呱首页 /mobile?methodno=MChatIndex&debug=1&appid=nju&deviceid=1&userid=1&verify=1
	 */
	+(ApiMChatIndex*) getApiMChatIndex{
		return [[ApiMChatIndex alloc ] init];
	}
	
	/**
	 *  南呱详情 /mobile?methodno=MChat&debug=1&appid=nju&deviceid=1&userid=1&verify=1&id=&begin=
	 */
	+(ApiMChat*) getApiMChat{
		return [[ApiMChat alloc ] init];
	}
	
	/**
	 *  南呱单条记录 /mobile?methodno=MChatMsg&debug=1&appid=nju&deviceid=1&userid=1&verify=1&id=
	 */
	+(ApiMChatMsg*) getApiMChatMsg{
		return [[ApiMChatMsg alloc ] init];
	}
	
	/**
	 *  南呱添加聊天(MImg)  /mobile?methodno=MAddChat&debug=1&appid=nju&deviceid=1&userid=1&verify=1&id=&content=   
	 */
	+(ApiMAddChat*) getApiMAddChat{
		return [[ApiMAddChat alloc ] init];
	}
	
	/**
	 *  南呱匹配 /mobile?methodno=MChatMatch&debug=1&appid=nju&deviceid=1&userid=1&verify=1
	 */
	+(ApiMChatMatch*) getApiMChatMatch{
		return [[ApiMChatMatch alloc ] init];
	}
	
	/**
	 * 首页
	 */
	+(ApiMIndex*) getApiMIndex{
		return [[ApiMIndex alloc ] init];
	}
	
	/**
	 *  未读消息
	 */
	+(ApiMUnreadModule*) getApiMUnreadModule{
		return [[ApiMUnreadModule alloc ] init];
	}
	
	/**
	 *  图书馆检索(分页)  /mobile?methodno=MSearchBook&debug=1&userid=&verify=&deviceid=&appid=&page=&pagecount=&keyword=
	 */
	+(ApiMSearchBook*) getApiMSearchBook{
		return [[ApiMSearchBook alloc ] init];
	}
	
	/**
	 *  个人图书馆(分页) mobile?methodno=MMyLibrary&debug=1&userid=&verify=&deviceid=&appid=&account=&password=
	 */
	+(ApiMMyLibrary*) getApiMMyLibrary{
		return [[ApiMMyLibrary alloc ] init];
	}
	
	/**
	 *  失物招领(分页)
	 */
	+(ApiMLostAndFound*) getApiMLostAndFound{
		return [[ApiMLostAndFound alloc ] init];
	}
	
	/**
	 * 新闻列表(分页)
	 */
	+(ApiMNewsList*) getApiMNewsList{
		return [[ApiMNewsList alloc ] init];
	}
	
	/**
	 *  新闻详情
	 */
	+(ApiMNews*) getApiMNews{
		return [[ApiMNews alloc ] init];
	}
	
	/**
	 *  百合十大
	 */
	+(ApiMBaiheNewsList*) getApiMBaiheNewsList{
		return [[ApiMBaiheNewsList alloc ] init];
	}
	
	/**
	 *  全部订阅
	 */
	+(ApiMAllRss*) getApiMAllRss{
		return [[ApiMAllRss alloc ] init];
	}
	
	/**
	 *  我的订阅
	 */
	+(ApiMMyRss*) getApiMMyRss{
		return [[ApiMMyRss alloc ] init];
	}
	
	/**
	 *  活动
	 */
	+(ApiMActivity*) getApiMActivity{
		return [[ApiMActivity alloc ] init];
	}
	
	/**
	 * 获取欢迎页   /mobile?methodno=MGetWelcomePage&debug=&deviceid=&appid=
	 */
	+(ApiMGetWelcomePage*) getApiMGetWelcomePage{
		return [[ApiMGetWelcomePage alloc ] init];
	}
	
	/**
	 * 获取手机验证码 /mobile?methodno=MGetMobileVerify&debug=1&deviceid=1&phone=&appid=
	 */
	+(ApiMGetMobileVerify*) getApiMGetMobileVerify{
		return [[ApiMGetMobileVerify alloc ] init];
	}
	
	/**
	 * 验证手机号 /mobile?methodno=MVerifyMobile&debug=1&deviceid=1&phone=&appid=&code=
	 */
	+(ApiMVerifyMobile*) getApiMVerifyMobile{
		return [[ApiMVerifyMobile alloc ] init];
	}
	
	/**
	 * 修改头像:MImg   /mobile?methodno=UpdateHeadImg&debug=1&deviceid=1&userid=&verify=&appid=
	 */
	+(ApiMUpdateHeadImg*) getApiMUpdateHeadImg{
		return [[ApiMUpdateHeadImg alloc ] init];
	}
	
	/**
	 * 获取用户身份认证校验码
	 */
	+(ApiMGetVerifyUserCode*) getApiMGetVerifyUserCode{
		return [[ApiMGetVerifyUserCode alloc ] init];
	}
	
	/**
	 * 用户身份认证
	 */
	+(ApiMVerifyUser*) getApiMVerifyUser{
		return [[ApiMVerifyUser alloc ] init];
	}
	
	/**
	 *  树洞赞 /mobile?methodno=MPraise&debug=1&deviceid=1&appid=1&userid=1&verify=1&id=1&type=1
	 */
	+(ApiMPraise*) getApiMPraise{
		return [[ApiMPraise alloc ] init];
	}
	
	/**
	 *  发布树洞:MAddTopic     /mobile?methodno=MAddTreeHole&debug=1&deviceid=1&userid=1&verify=1
	 */
	+(ApiMAddTreeHole*) getApiMAddTreeHole{
		return [[ApiMAddTreeHole alloc ] init];
	}
	
	/**
	 *  树洞删除 /mobile?methodno=MTreeHoleDel&debug=1&deviceid=1&appid=1&userid=1&verify=1&id=1
	 */
	+(ApiMTreeHoleDel*) getApiMTreeHoleDel{
		return [[ApiMTreeHoleDel alloc ] init];
	}
	
	/**
	 *  发布树洞评论 /mobile?methodno=MTreeHoleComment&debug=1&deviceid=1&appid=1&userid=1&verify=1&id=&content=&reply=&commentId=
	 */
	+(ApiMTreeHoleComment*) getApiMTreeHoleComment{
		return [[ApiMTreeHoleComment alloc ] init];
	}
	
	/**
	 *  南呱记录删除  /mobile?methodno=MChatDel&debug=1&appid=nju&deviceid=1&userid=1&verify=1&id=
	 */
	+(ApiMChatDel*) getApiMChatDel{
		return [[ApiMChatDel alloc ] init];
	}
	
	/**
	 *  南呱黑名单 /mobile?methodno=MChatBlack&debug=1&appid=nju&deviceid=1&userid=1&verify=1&id=
	 */
	+(ApiMChatBlack*) getApiMChatBlack{
		return [[ApiMChatBlack alloc ] init];
	}
	
	/**
	 *  南呱换人 /mobile?methodno=MChatChange&debug=1&appid=nju&deviceid=1&userid=1&verify=1&id=
	 */
	+(ApiMChatChange*) getApiMChatChange{
		return [[ApiMChatChange alloc ] init];
	}
	
	/**
	 *  南呱呼叫  /mobile?methodno=MChatCall&debug=1&appid=nju&deviceid=1&userid=1&verify=1&id=
	 */
	+(ApiMChatCall*) getApiMChatCall{
		return [[ApiMChatCall alloc ] init];
	}
	
	/**
	 *  南呱呼叫应答 /mobile?methodno=MChatCallBack&debug=1&appid=nju&deviceid=1&userid=1&verify=1&id=&type=
	 */
	+(ApiMChatCallBack*) getApiMChatCallBack{
		return [[ApiMChatCallBack alloc ] init];
	}
	
	/**
	 *  图书馆登录 
	 */
	+(ApiMLoginLibrary*) getApiMLoginLibrary{
		return [[ApiMLoginLibrary alloc ] init];
	}
	
	/**
	 *  图书馆续借  mobile?methodno=MBookRenew&debug=&deviceid=&appid=1&userid=&verify=&account=&password=&id=
	 */
	+(ApiMBookRenew*) getApiMBookRenew{
		return [[ApiMBookRenew alloc ] init];
	}
	
	/**
	 *  空教室搜索
	 */
	+(ApiMRoomSearch*) getApiMRoomSearch{
		return [[ApiMRoomSearch alloc ] init];
	}
	
	/**
	 *  添加失物招领:MAddLostOrFound 
	 */
	+(ApiMAddLostAndFound*) getApiMAddLostAndFound{
		return [[ApiMAddLostAndFound alloc ] init];
	}
	
	/**
	 *  一卡通验证码
	 */
	+(ApiMLoginScheduleCode*) getApiMLoginScheduleCode{
		return [[ApiMLoginScheduleCode alloc ] init];
	}
	
	/**
	 *  课程表/成绩查询登录
	 */
	+(ApiMLoginSchedule*) getApiMLoginSchedule{
		return [[ApiMLoginSchedule alloc ] init];
	}
	
	/**
	 *  课程表
	 */
	+(ApiMSchedule*) getApiMSchedule{
		return [[ApiMSchedule alloc ] init];
	}
	
	/**
	 * 成绩查询
	 */
	+(ApiMGradeSearch*) getApiMGradeSearch{
		return [[ApiMGradeSearch alloc ] init];
	}
	
	/**
	 *  一卡通验证码
	 */
	+(ApiMLoginCardCode*) getApiMLoginCardCode{
		return [[ApiMLoginCardCode alloc ] init];
	}
	
	/**
	 * 一卡通登录
	 */
	+(ApiMLoginCard*) getApiMLoginCard{
		return [[ApiMLoginCard alloc ] init];
	}
	
	/**
	 *  一卡通余额
	 */
	+(ApiMCardInfo*) getApiMCardInfo{
		return [[ApiMCardInfo alloc ] init];
	}
	
	/**
	 *  一卡通消费记录
	 */
	+(ApiMCardHistory*) getApiMCardHistory{
		return [[ApiMCardHistory alloc ] init];
	}
	
	/**
	 *  部门电话
	 */
	+(ApiMContacts*) getApiMContacts{
		return [[ApiMContacts alloc ] init];
	}
	
	/**
	 *  校车
	 */
	+(ApiMBusSearch*) getApiMBusSearch{
		return [[ApiMBusSearch alloc ] init];
	}
	
	/**
	 *  打卡登录
	 */
	+(ApiMLoginSignIn*) getApiMLoginSignIn{
		return [[ApiMLoginSignIn alloc ] init];
	}
	
	/**
	 *  打卡信息(分页)
	 */
	+(ApiMSignInInfo*) getApiMSignInInfo{
		return [[ApiMSignInInfo alloc ] init];
	}
	
	/**
	 *  办理流程(分页)
	 */
	+(ApiMHelp*) getApiMHelp{
		return [[ApiMHelp alloc ] init];
	}
	
	/**
	 *  树洞首页 /mobile?methodno=MTreeHoleList&debug=1&deviceid=1&appid=1&userid=1&verify=1&type=0&begin=
	 */
	+(ApiMTreeHoleList*) getApiMTreeHoleList{
		return [[ApiMTreeHoleList alloc ] init];
	}
	
	/**
	 *  树洞新消息 /mobile?methodno=MTreeHoleNews&debug=1&deviceid=1&appid=1&userid=1&verify=1&begin=
	 */
	+(ApiMTreeHoleNews*) getApiMTreeHoleNews{
		return [[ApiMTreeHoleNews alloc ] init];
	}
	
	/**
	 *  树洞详情 /mobile?methodno=MTreeHole&debug=1&deviceid=1&appid=1&userid=1&verify=1&id=1
	 */
	+(ApiMTreeHole*) getApiMTreeHole{
		return [[ApiMTreeHole alloc ] init];
	}
	
	/**
	 * 登录 /mobile?methodno=MLogin&debug=1&phone=&password=&deviceid=&appid=
	 */
	+(ApiMLogin*) getApiMLogin{
		return [[ApiMLogin alloc ] init];
	}
	
	/**
	 * 注册或忘记密码 /mobile?methodno=MRegist&debug=1&deviceid=1&phone=&password=&nickname=&code=&appid=
	 */
	+(ApiMRegist*) getApiMRegist{
		return [[ApiMRegist alloc ] init];
	}
	
	/**
	 * 修改账号或密码 /mobile?methodno=MChangePhone&debug=1&deviceid=1&phone=&password=&nickname=&code=&appid=
	 */
	+(ApiMChangePhone*) getApiMChangePhone{
		return [[ApiMChangePhone alloc ] init];
	}
	
	/**
	 * 用户详细信息 /mobile?methodno=MGetUserInfo&debug=1&deviceid=1&userid=88b9e9a9-ea31-11e3-b696-ac853d9d52b1&verify=&appid=nju
	 */
	+(ApiMGetUserInfo*) getApiMGetUserInfo{
		return [[ApiMGetUserInfo alloc ] init];
	}
	
	/**
	 * 用户信息修改 /mobile?methodno=MUpdateUserInfo&debug=1&appid=nju&deviceid=1&userid=&verify=&nickname=&belong=&sex=&birthday=tags=
	 */
	+(ApiMUpdateUserInfo*) getApiMUpdateUserInfo{
		return [[ApiMUpdateUserInfo alloc ] init];
	}

@end
