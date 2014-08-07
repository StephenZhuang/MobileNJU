//
//  ApisFactory
//
//  Created by ryan on 2014-08-06 14:28:21
//  Copyright (c) ryan All rights reserved.


/**
   apis集合类
*/

#import "ApiMChatIndex.h"
#import "ApiMChat.h"
#import "ApiMChatMsg.h"
#import "ApiMAddChat.h"
#import "ApiMChatReq.h"
#import "ApiMChatDel.h"
#import "ApiMChatBlack.h"
#import "ApiMIndex.h"
#import "ApiMUnreadModule.h"
#import "ApiMSearchBook.h"
#import "ApiMBookDetail.h"
#import "ApiMMyLibrary.h"
#import "ApiMLostAndFound.h"
#import "ApiMMarketList.h"
#import "ApiMAddMarket.h"
#import "ApiMSoldMarket.h"
#import "ApiMNewsList.h"
#import "ApiMNews.h"
#import "ApiMBaiheNewsList.h"
#import "ApiMAllRss.h"
#import "ApiMMyRss.h"
#import "ApiMActivity.h"
#import "ApiMPushClear.h"
#import "ApiMGetWelcomePage.h"
#import "ApiMVerifyUser.h"
#import "ApiMRss.h"
#import "ApiMBookRenew.h"
#import "ApiMRoomSearch.h"
#import "ApiMAddLostAndFound.h"
#import "ApiMScheduleAuto.h"
#import "ApiMSchedule.h"
#import "ApiMAddClass.h"
#import "ApiMDelClass.h"
#import "ApiMTermList.h"
#import "ApiMGradeSearch.h"
#import "ApiMCardInfo.h"
#import "ApiMCardHistory.h"
#import "ApiMContacts.h"
#import "ApiMBusSearch.h"
#import "ApiMSignInInfo.h"
#import "ApiMSignInInDetail.h"
#import "ApiMHelp.h"
#import "ApiMGetTags.h"
#import "ApiMTreeHoleList.h"
#import "ApiMTreeHoleQuery.h"
#import "ApiMTagTreeHole.h"
#import "ApiMTreeHole.h"
#import "ApiMTreeHoleComments.h"
#import "ApiMGetMsgCount.h"
#import "ApiMPraise.h"
#import "ApiMAddTreeHole.h"
#import "ApiMTreeHoleDel.h"
#import "ApiMTreeHoleReport.h"
#import "ApiMTreeHoleComment.h"
#import "ApiMTreeHoleNewComment.h"
#import "ApiMLogin.h"
#import "ApiMRegist.h"
#import "ApiMChangePhone.h"
#import "ApiMGetUserInfo.h"
#import "ApiMUpdateUserInfo.h"
#import "ApiMLogout.h"
#import "ApiMGetMobileVerify.h"
#import "ApiMVerifyMobile.h"
#import "ApiMUpdateHeadImg.h"

@interface ApisFactory : NSObject


	
	/**
	 *  南呱首页 /mobile?methodno=MChatIndex&debug=1&appid=nju&deviceid=1&userid=1&verify=1
	 */
	+(ApiMChatIndex*) getApiMChatIndex;
	
	/**
	 *  详情 /mobile?methodno=MChat&debug=1&appid=nju&deviceid=1&userid=1&verify=1&id=&begin=&topicid=
	 */
	+(ApiMChat*) getApiMChat;
	
	/**
	 *  单条记录 /mobile?methodno=MChatMsg&debug=1&appid=nju&deviceid=1&userid=1&verify=1&id=
	 */
	+(ApiMChatMsg*) getApiMChatMsg;
	
	/**
	 *  添加聊天(MImg)  /mobile?methodno=MAddChat&debug=1&appid=nju&deviceid=1&userid=1&verify=1&id=&content=&topicid=
	 */
	+(ApiMAddChat*) getApiMAddChat;
	
	/**
	 *  树洞发起会话 /mobile?methodno=MChatReq&debug=1&appid=nju&deviceid=1&userid=1&verify=1&targetid=&topicid=
	 */
	+(ApiMChatReq*) getApiMChatReq;
	
	/**
	 *  南呱记录删除  /mobile?methodno=MChatDel&debug=1&appid=nju&deviceid=1&userid=1&verify=1&viewid=
	 */
	+(ApiMChatDel*) getApiMChatDel;
	
	/**
	 *  南呱黑名单 /mobile?methodno=MChatBlack&debug=1&appid=nju&deviceid=1&userid=1&verify=1&viewid=
	 */
	+(ApiMChatBlack*) getApiMChatBlack;
	
	/**
	 * 首页 /mobile?methodno=MIndex&debug=1&deviceid=1&userid=fe34a40e-eac6-11e3-b696-ac853d9d52b1&verify=cf09a009-d221-466a-b9f0-d7d3b43dce7c&appid=nju&appid=nju
	 */
	+(ApiMIndex*) getApiMIndex;
	
	/**
	 *  未读消息  /mobile?methodno=MUnreadModule&debug=1&deviceid=1&userid=dffeda04-eb07-11e3-b696-ac853d9d52b1&verify=753bd4cd-590a-4fa2-b5b3-f390d3bc1d01&appid=nju
	 */
	+(ApiMUnreadModule*) getApiMUnreadModule;
	
	/**
	 *  图书馆检索(分页)  /mobile?methodno=MSearchBook&debug=1&userid=&verify=&deviceid=&appid=&page=&limit=&keyword=
	 */
	+(ApiMSearchBook*) getApiMSearchBook;
	
	/**
	 *  图书详情查询  /mobile?methodno=MBookDetail&debug=1&userid=&verify=&deviceid=&appid=&id=
	 */
	+(ApiMBookDetail*) getApiMBookDetail;
	
	/**
	 *  个人图书馆(分页) mobile?methodno=MMyLibrary&debug=1&userid=&verify=&deviceid=&appid=&account=&password=
	 */
	+(ApiMMyLibrary*) getApiMMyLibrary;
	
	/**
	 *  失物招领(分页) /mobile?methodno=MLostAndFound&debug=1&deviceid=1&userid=&verify=&type=&page=&limit=
	 */
	+(ApiMLostAndFound*) getApiMLostAndFound;
	
	/**
	 * 
	 */
	+(ApiMMarketList*) getApiMMarketList;
	
	/**
	 * 
	 */
	+(ApiMAddMarket*) getApiMAddMarket;
	
	/**
	 * 
	 */
	+(ApiMSoldMarket*) getApiMSoldMarket;
	
	/**
	 * 新闻列表(分页) /mobile?methodno=MNewsList&debug=1&deviceid=1&userid=fe34a40e-eac6-11e3-b696-ac853d9d52b1&verify=cf09a009-d221-466a-b9f0-d7d3b43dce7c&page=2&limit=10&appid=nju
	 */
	+(ApiMNewsList*) getApiMNewsList;
	
	/**
	 *  新闻详情
	 */
	+(ApiMNews*) getApiMNews;
	
	/**
	 *  百合十大 /mobile?methodno=MBaiheNewsList&debug=1&deviceid=1&userid=fe34a40e-eac6-11e3-b696-ac853d9d52b1&verify=cf09a009-d221-466a-b9f0-d7d3b43dce7c&appid=nju
	 */
	+(ApiMBaiheNewsList*) getApiMBaiheNewsList;
	
	/**
	 *  全部订阅 /mobile?methodno=MAllRss&debug=1&deviceid=1&userid=&verify=&appid=
	 */
	+(ApiMAllRss*) getApiMAllRss;
	
	/**
	 *  我的订阅 /mobile?methodno=MMyRss&debug=1&deviceid=1&userid=&verify=&appid=
	 */
	+(ApiMMyRss*) getApiMMyRss;
	
	/**
	 *  活动  /mobile?methodno=MNewsList&debug=1&deviceid=1&userid=fe34a40e-eac6-11e3-b696-ac853d9d52b1&verify=cf09a009-d221-466a-b9f0-d7d3b43dce7c&page=2&limit=10&appid=nju
	 */
	+(ApiMActivity*) getApiMActivity;
	
	/**
	 * 清空推送   /mobile?methodno=MPushClear&debug=1&deviceid=&appid=&userid=
	 */
	+(ApiMPushClear*) getApiMPushClear;
	
	/**
	 * 获取欢迎页   /mobile?methodno=MGetWelcomePage&debug=&deviceid=&appid=
	 */
	+(ApiMGetWelcomePage*) getApiMGetWelcomePage;
	
	/**
	 * 用户身份认证 /mobile?methodno=MVerifyUser&debug=1&deviceid=1&userid=&verify=&num=&pwd=&code=&appid=nju
	 */
	+(ApiMVerifyUser*) getApiMVerifyUser;
	
	/**
	 *  订阅 /mobile?methodno=MRss&debug=1&deviceid=1&userid=&verify=&rssid=&appid=
	 */
	+(ApiMRss*) getApiMRss;
	
	/**
	 *  图书馆续借  mobile?methodno=MBookRenew&debug=&deviceid=&appid=1&userid=&verify=&account=&password=&id=
	 */
	+(ApiMBookRenew*) getApiMBookRenew;
	
	/**
	 *  空教室搜索 /mobile?methodno=MRoomSearch&debug=1&deviceid=1&userid=&verify=&type=&day=&begin=&end=
	 */
	+(ApiMRoomSearch*) getApiMRoomSearch;
	
	/**
	 *  添加失物招领:MAddLostOrFound /mobile?methodno=MAddLostAndFound&debug=&appid=&deviceid=&userid=&verify=
	 */
	+(ApiMAddLostAndFound*) getApiMAddLostAndFound;
	
	/**
	 *  课程表 /mobile?methodno=MSchedule&debug=1&deviceid=1&account=&password=&code=
	 */
	+(ApiMScheduleAuto*) getApiMScheduleAuto;
	
	/**
	 *   课程表-教务处全新抓取 /mobile?methodno=MSchedule&debug=1&deviceid=1&account=&password=&code=
	 */
	+(ApiMSchedule*) getApiMSchedule;
	
	/**
	 *   课程表-添加课程 /mobile?methodno=MSchedule&debug=1&deviceid=1&account=&password=&code=
	 */
	+(ApiMAddClass*) getApiMAddClass;
	
	/**
	 *   课程表-删除课程 /mobile?methodno=MSchedule&debug=1&deviceid=1&account=&password=&code=
	 */
	+(ApiMDelClass*) getApiMDelClass;
	
	/**
	 *  获取学期列表  /mobile?methodno=MTermList&debug=1&deviceid=1&userid=&verify=&account=&password=
	 */
	+(ApiMTermList*) getApiMTermList;
	
	/**
	 * 成绩查询  /mobile?methodno=MGradeSearch&debug=1&deviceid=1&userid=&verify=&account=&password=&url=
	 */
	+(ApiMGradeSearch*) getApiMGradeSearch;
	
	/**
	 *  一卡通余额 /mobile?methodno=MCardInfo&debug=1&deviceid=1&userid=&verify=&account=&password=
	 */
	+(ApiMCardInfo*) getApiMCardInfo;
	
	/**
	 *  一卡通消费记录  /mobile?methodno=MCardHistory&debug=1&deviceid=1&userid=&verify=&begin=&end=&account=&password=
	 */
	+(ApiMCardHistory*) getApiMCardHistory;
	
	/**
	 *  部门电话 /mobile?methodno=MContacts&debug=1&deviceid=1&userid=&verify=
	 */
	+(ApiMContacts*) getApiMContacts;
	
	/**
	 *  校车 /mobile?methodno=MBusSearch&debug=1&deviceid=1&userid=&verify=&type=&page=&limit=
	 */
	+(ApiMBusSearch*) getApiMBusSearch;
	
	/**
	 *  打卡信息 /mobile?methodno=MSignInInfo&debug=1&deviceid=1&userid=&verify=&account=&password=
	 */
	+(ApiMSignInInfo*) getApiMSignInInfo;
	
	/**
	 *  打卡详情 /mobile?methodno= MSignInInDetail&debug=1&deviceid=1&userid=&verify=&account=&password=
	 */
	+(ApiMSignInInDetail*) getApiMSignInInDetail;
	
	/**
	 *  办理流程(分页) /mobile?methodno=MHelp&debug=1&deviceid=1&userid=&verify=&page=&limit=
	 */
	+(ApiMHelp*) getApiMHelp;
	
	/**
	 *  获取所有话题(前三个首页显示) /mobile?methodno=MGetTags&debug=1&deviceid=1&appid=1&userid=1&verify=1
	 */
	+(ApiMGetTags*) getApiMGetTags;
	
	/**
	 *  树洞首页 /mobile?methodno=MTreeHoleList&debug=1&deviceid=1&appid=1&userid=1&verify=1&begin=
	 */
	+(ApiMTreeHoleList*) getApiMTreeHoleList;
	
	/**
	 *  树洞查询 /mobile?methodno=MTreeHoleQuery&debug=1&deviceid=1&appid=1&userid=1&verify=1&type=
	 */
	+(ApiMTreeHoleQuery*) getApiMTreeHoleQuery;
	
	/**
	 *  话题树洞 /mobile?methodno=MTagTreeHole&debug=1&deviceid=1&appid=1&userid=1&verify=1&tagid=&begin=
	 */
	+(ApiMTagTreeHole*) getApiMTagTreeHole;
	
	/**
	 *  树洞详情 /mobile?methodno=MTreeHole&debug=1&deviceid=1&appid=1&userid=1&verify=1&id=1
	 */
	+(ApiMTreeHole*) getApiMTreeHole;
	
	/**
	 *  树洞评论 /mobile?methodno=MTreeHoleComments&debug=1&deviceid=1&appid=1&userid=1&verify=1&id=1&begin=
	 */
	+(ApiMTreeHoleComments*) getApiMTreeHoleComments;
	
	/**
	 *  获取消息数 /mobile?methodno=MGetMsgCount&debug=1&deviceid=1&appid=1&userid=1&verify=1
	 */
	+(ApiMGetMsgCount*) getApiMGetMsgCount;
	
	/**
	 *  树洞赞 /mobile?methodno=MPraise&debug=1&deviceid=1&appid=1&userid=1&verify=1&id=1&type=1
	 */
	+(ApiMPraise*) getApiMPraise;
	
	/**
	 *  发布树洞:MAddTopic   /mobile?methodno=MAddTreeHole&debug=1&deviceid=1&userid=1&verify=1
	 */
	+(ApiMAddTreeHole*) getApiMAddTreeHole;
	
	/**
	 *  树洞删除 /mobile?methodno=MTreeHoleDel&debug=1&deviceid=1&appid=1&userid=1&verify=1&id=1
	 */
	+(ApiMTreeHoleDel*) getApiMTreeHoleDel;
	
	/**
	 *  树洞举报 /mobile?methodno=MTreeHoleReport&debug=1&deviceid=1&appid=1&userid=1&verify=1&id=1
	 */
	+(ApiMTreeHoleReport*) getApiMTreeHoleReport;
	
	/**
	 *  发布树洞评论 /mobile?methodno=MTreeHoleComment&debug=1&deviceid=1&appid=1&userid=1&verify=1&id=&content=&reply=&floor=
	 */
	+(ApiMTreeHoleComment*) getApiMTreeHoleComment;
	
	/**
	 *  树洞新的评论 /mobile?methodno=MTreeHoleNewComment&debug=1&deviceid=1&appid=1&userid=1&verify=1
	 */
	+(ApiMTreeHoleNewComment*) getApiMTreeHoleNewComment;
	
	/**
	 * 登录 /mobile?methodno=MLogin&debug=1&phone=&password=&deviceid=&appid=&device=
	 */
	+(ApiMLogin*) getApiMLogin;
	
	/**
	 * 注册或忘记密码 /mobile?methodno=MRegist&debug=1&deviceid=1&phone=&password=&nickname=&code=&appid=&device=
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
	
	/**
	 * 退出登录   /mobile?methodno=MLogout&debug=1&deviceid=&appid=&userid=
	 */
	+(ApiMLogout*) getApiMLogout;
	
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

@end
