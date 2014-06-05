//
//  ApisFactory
//
//  Created by ryan on 2014-06-04 18:30:34
//  Copyright (c) ryan All rights reserved.


/**
   apis集合类
*/

#import "ApiMChatIndex.h"
#import "ApiMChat.h"
#import "ApiMChatMsg.h"
#import "ApiMAddChat.h"
#import "ApiMChatMatch.h"
#import "ApiMIndex.h"
#import "ApiMUnreadModule.h"
#import "ApiMSearchBook.h"
#import "ApiMMyLibrary.h"
#import "ApiMLostAndFound.h"
#import "ApiMNewsList.h"
#import "ApiMNews.h"
#import "ApiMBaiheNewsList.h"
#import "ApiMAllRss.h"
#import "ApiMMyRss.h"
#import "ApiMActivity.h"
#import "ApiMGetWelcomePage.h"
#import "ApiMGetMobileVerify.h"
#import "ApiMVerifyMobile.h"
#import "ApiMUpdateHeadImg.h"
#import "ApiMGetVerifyUserCode.h"
#import "ApiMVerifyUser.h"
#import "ApiMPraise.h"
#import "ApiMAddTreeHole.h"
#import "ApiMTreeHoleDel.h"
#import "ApiMTreeHoleComment.h"
#import "ApiMChatDel.h"
#import "ApiMChatBlack.h"
#import "ApiMChatChange.h"
#import "ApiMChatCall.h"
#import "ApiMChatCallBack.h"
#import "ApiMLoginLibrary.h"
#import "ApiMBookRenew.h"
#import "ApiMRoomSearch.h"
#import "ApiMAddLostAndFound.h"
#import "ApiMLoginScheduleCode.h"
#import "ApiMLoginSchedule.h"
#import "ApiMSchedule.h"
#import "ApiMGradeSearch.h"
#import "ApiMLoginCardCode.h"
#import "ApiMLoginCard.h"
#import "ApiMCardInfo.h"
#import "ApiMCardHistory.h"
#import "ApiMContacts.h"
#import "ApiMBusSearch.h"
#import "ApiMLoginSignIn.h"
#import "ApiMSignInInfo.h"
#import "ApiMHelp.h"
#import "ApiMTreeHoleList.h"
#import "ApiMTreeHoleNews.h"
#import "ApiMTreeHole.h"
#import "ApiMLogin.h"
#import "ApiMRegist.h"
#import "ApiMChangePhone.h"
#import "ApiMGetUserInfo.h"
#import "ApiMUpdateUserInfo.h"

@interface ApisFactory : NSObject


	
	/**
	 *  南呱首页 /mobile?methodno=MChatIndex&debug=1&appid=nju&deviceid=1&userid=1&verify=1
	 */
	+(ApiMChatIndex*) getApiMChatIndex;
	
	/**
	 *  南呱详情 /mobile?methodno=MChat&debug=1&appid=nju&deviceid=1&userid=1&verify=1&id=&begin=
	 */
	+(ApiMChat*) getApiMChat;
	
	/**
	 *  南呱单条记录 /mobile?methodno=MChatMsg&debug=1&appid=nju&deviceid=1&userid=1&verify=1&id=
	 */
	+(ApiMChatMsg*) getApiMChatMsg;
	
	/**
	 *  南呱添加聊天(MImg)  /mobile?methodno=MAddChat&debug=1&appid=nju&deviceid=1&userid=1&verify=1&id=&content=   
	 */
	+(ApiMAddChat*) getApiMAddChat;
	
	/**
	 *  南呱匹配 /mobile?methodno=MChatMatch&debug=1&appid=nju&deviceid=1&userid=1&verify=1
	 */
	+(ApiMChatMatch*) getApiMChatMatch;
	
	/**
	 * 首页
	 */
	+(ApiMIndex*) getApiMIndex;
	
	/**
	 *  未读消息
	 */
	+(ApiMUnreadModule*) getApiMUnreadModule;
	
	/**
	 *  图书馆检索(分页)  /mobile?methodno=MSearchBook&debug=1&userid=&verify=&deviceid=&appid=&page=&pagecount=&keyword=
	 */
	+(ApiMSearchBook*) getApiMSearchBook;
	
	/**
	 *  个人图书馆(分页) mobile?methodno=MMyLibrary&debug=1&userid=&verify=&deviceid=&appid=&account=&password=
	 */
	+(ApiMMyLibrary*) getApiMMyLibrary;
	
	/**
	 *  失物招领(分页)
	 */
	+(ApiMLostAndFound*) getApiMLostAndFound;
	
	/**
	 * 新闻列表(分页)
	 */
	+(ApiMNewsList*) getApiMNewsList;
	
	/**
	 *  新闻详情
	 */
	+(ApiMNews*) getApiMNews;
	
	/**
	 *  百合十大
	 */
	+(ApiMBaiheNewsList*) getApiMBaiheNewsList;
	
	/**
	 *  全部订阅
	 */
	+(ApiMAllRss*) getApiMAllRss;
	
	/**
	 *  我的订阅
	 */
	+(ApiMMyRss*) getApiMMyRss;
	
	/**
	 *  活动
	 */
	+(ApiMActivity*) getApiMActivity;
	
	/**
	 * 获取欢迎页   /mobile?methodno=MGetWelcomePage&debug=&deviceid=&appid=
	 */
	+(ApiMGetWelcomePage*) getApiMGetWelcomePage;
	
	/**
	 * 获取手机验证码 /mobile?methodno=MGetMobileVerify&debug=1&deviceid=1&phone=&appid=
	 */
	+(ApiMGetMobileVerify*) getApiMGetMobileVerify;
	
	/**
	 * 验证手机号 /mobile?methodno=MVerifyMobile&debug=1&deviceid=1&phone=&appid=&code=
	 */
	+(ApiMVerifyMobile*) getApiMVerifyMobile;
	
	/**
	 * 修改头像:MImg   /mobile?methodno=UpdateHeadImg&debug=1&deviceid=1&userid=&verify=&appid=
	 */
	+(ApiMUpdateHeadImg*) getApiMUpdateHeadImg;
	
	/**
	 * 获取用户身份认证校验码
	 */
	+(ApiMGetVerifyUserCode*) getApiMGetVerifyUserCode;
	
	/**
	 * 用户身份认证
	 */
	+(ApiMVerifyUser*) getApiMVerifyUser;
	
	/**
	 *  树洞赞 /mobile?methodno=MPraise&debug=1&deviceid=1&appid=1&userid=1&verify=1&id=1&type=1
	 */
	+(ApiMPraise*) getApiMPraise;
	
	/**
	 *  发布树洞:MAddTopic     /mobile?methodno=MAddTreeHole&debug=1&deviceid=1&userid=1&verify=1
	 */
	+(ApiMAddTreeHole*) getApiMAddTreeHole;
	
	/**
	 *  树洞删除 /mobile?methodno=MTreeHoleDel&debug=1&deviceid=1&appid=1&userid=1&verify=1&id=1
	 */
	+(ApiMTreeHoleDel*) getApiMTreeHoleDel;
	
	/**
	 *  发布树洞评论 /mobile?methodno=MTreeHoleComment&debug=1&deviceid=1&appid=1&userid=1&verify=1&id=&content=&reply=&commentId=
	 */
	+(ApiMTreeHoleComment*) getApiMTreeHoleComment;
	
	/**
	 *  南呱记录删除  /mobile?methodno=MChatDel&debug=1&appid=nju&deviceid=1&userid=1&verify=1&id=
	 */
	+(ApiMChatDel*) getApiMChatDel;
	
	/**
	 *  南呱黑名单 /mobile?methodno=MChatBlack&debug=1&appid=nju&deviceid=1&userid=1&verify=1&id=
	 */
	+(ApiMChatBlack*) getApiMChatBlack;
	
	/**
	 *  南呱换人 /mobile?methodno=MChatChange&debug=1&appid=nju&deviceid=1&userid=1&verify=1&id=
	 */
	+(ApiMChatChange*) getApiMChatChange;
	
	/**
	 *  南呱呼叫  /mobile?methodno=MChatCall&debug=1&appid=nju&deviceid=1&userid=1&verify=1&id=
	 */
	+(ApiMChatCall*) getApiMChatCall;
	
	/**
	 *  南呱呼叫应答 /mobile?methodno=MChatCallBack&debug=1&appid=nju&deviceid=1&userid=1&verify=1&id=&type=
	 */
	+(ApiMChatCallBack*) getApiMChatCallBack;
	
	/**
	 *  图书馆登录 
	 */
	+(ApiMLoginLibrary*) getApiMLoginLibrary;
	
	/**
	 *  图书馆续借  mobile?methodno=MBookRenew&debug=&deviceid=&appid=1&userid=&verify=&account=&password=&id=
	 */
	+(ApiMBookRenew*) getApiMBookRenew;
	
	/**
	 *  空教室搜索
	 */
	+(ApiMRoomSearch*) getApiMRoomSearch;
	
	/**
	 *  添加失物招领:MAddLostOrFound 
	 */
	+(ApiMAddLostAndFound*) getApiMAddLostAndFound;
	
	/**
	 *  一卡通验证码
	 */
	+(ApiMLoginScheduleCode*) getApiMLoginScheduleCode;
	
	/**
	 *  课程表/成绩查询登录
	 */
	+(ApiMLoginSchedule*) getApiMLoginSchedule;
	
	/**
	 *  课程表
	 */
	+(ApiMSchedule*) getApiMSchedule;
	
	/**
	 * 成绩查询
	 */
	+(ApiMGradeSearch*) getApiMGradeSearch;
	
	/**
	 *  一卡通验证码
	 */
	+(ApiMLoginCardCode*) getApiMLoginCardCode;
	
	/**
	 * 一卡通登录
	 */
	+(ApiMLoginCard*) getApiMLoginCard;
	
	/**
	 *  一卡通余额
	 */
	+(ApiMCardInfo*) getApiMCardInfo;
	
	/**
	 *  一卡通消费记录
	 */
	+(ApiMCardHistory*) getApiMCardHistory;
	
	/**
	 *  部门电话
	 */
	+(ApiMContacts*) getApiMContacts;
	
	/**
	 *  校车
	 */
	+(ApiMBusSearch*) getApiMBusSearch;
	
	/**
	 *  打卡登录
	 */
	+(ApiMLoginSignIn*) getApiMLoginSignIn;
	
	/**
	 *  打卡信息(分页)
	 */
	+(ApiMSignInInfo*) getApiMSignInInfo;
	
	/**
	 *  办理流程(分页)
	 */
	+(ApiMHelp*) getApiMHelp;
	
	/**
	 *  树洞首页 /mobile?methodno=MTreeHoleList&debug=1&deviceid=1&appid=1&userid=1&verify=1&type=0&begin=
	 */
	+(ApiMTreeHoleList*) getApiMTreeHoleList;
	
	/**
	 *  树洞新消息 /mobile?methodno=MTreeHoleNews&debug=1&deviceid=1&appid=1&userid=1&verify=1&begin=
	 */
	+(ApiMTreeHoleNews*) getApiMTreeHoleNews;
	
	/**
	 *  树洞详情 /mobile?methodno=MTreeHole&debug=1&deviceid=1&appid=1&userid=1&verify=1&id=1
	 */
	+(ApiMTreeHole*) getApiMTreeHole;
	
	/**
	 * 登录 /mobile?methodno=MLogin&debug=1&phone=&password=&deviceid=&appid=
	 */
	+(ApiMLogin*) getApiMLogin;
	
	/**
	 * 注册或忘记密码 /mobile?methodno=MRegist&debug=1&deviceid=1&phone=&password=&nickname=&code=&appid=
	 */
	+(ApiMRegist*) getApiMRegist;
	
	/**
	 * 修改账号或密码 /mobile?methodno=MChangePhone&debug=1&deviceid=1&phone=&password=&nickname=&code=&appid=
	 */
	+(ApiMChangePhone*) getApiMChangePhone;
	
	/**
	 * 用户详细信息 /mobile?methodno=MGetUserInfo&debug=1&deviceid=1&userid=88b9e9a9-ea31-11e3-b696-ac853d9d52b1&verify=&appid=nju
	 */
	+(ApiMGetUserInfo*) getApiMGetUserInfo;
	
	/**
	 * 用户信息修改 /mobile?methodno=MUpdateUserInfo&debug=1&appid=nju&deviceid=1&userid=&verify=&nickname=&belong=&sex=&birthday=tags=
	 */
	+(ApiMUpdateUserInfo*) getApiMUpdateUserInfo;

@end
