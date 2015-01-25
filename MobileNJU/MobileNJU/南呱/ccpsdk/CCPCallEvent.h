/*
 *  Copyright (c) 2013 The CCP project authors. All Rights Reserved.
 *
 *  Use of this source code is governed by a Beijing Speedtong Information Technology Co.,Ltd license
 *  that can be found in the LICENSE file in the root of the web site.
 *
 *                    http://www.yuntongxun.com
 *
 *  An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 */
#import "CommonClass.h"

#ifndef CPPCallManagerSDK_CCPType_h
#define CPPCallManagerSDK_CCPType_h

@class InterphoneMsg;

@protocol CCPCallEventDelegate<NSObject>
/********************初始化回调********************/
@required
//与云通讯平台连接成功
- (void)onConnected;
//与云通讯平台连接失败或连接断开
- (void)onConnectError:(NSInteger)reason withReasonMessge:(NSString *)reasonMessage;

@optional
/********************系统事件回调********************/
//事件通知
- (void)onReceiveEvents:(CCPEvents) events;
//P2P连接成功
- (void)onFirewallPolicyEnabled;
//网络连接状态, status 值为ENETWORK_STATUS
- (void)onReachbilityChanged:(NSInteger)status;

//音频设备开始中断
- (void)onAudioBeginInterruption;
//音频设备结束终端
- (void)onAudioEndInterruption;

/********************VoIP通话的方法********************/
//有呼叫进入
- (void)onIncomingCallReceived:(NSString*)callid withCallerAccount:(NSString *)caller withCallerPhone:(NSString *)callerphone withCallerName:(NSString *)callername withCallType:(NSInteger)calltype;
//呼叫处理中
- (void)onCallProceeding:(NSString *)callid;
//呼叫振铃
- (void)onCallAlerting:(NSString*)callid;
//所有应答
- (void)onCallAnswered:(NSString *)callid;
//外呼失败
- (void)onMakeCallFailed:(NSString *)callid withReason:(NSInteger)reason;
//本地Pause呼叫成功
- (void)onCallPaused:(NSString *)callid;
//呼叫被对端pasue
- (void)onCallPausedByRemote:(NSString *)callid;
//本地resume呼叫成功
- (void)onCallResumed:(NSString *)callid;
//呼叫被对端resume
- (void)onCallResumedByRemote:(NSString *)callid;
//呼叫挂机
- (void)onCallReleased:(NSString *)callid;
//呼叫被转接
- (void)onCallTransfered:(NSString *)callid transferTo:(NSString *)destination;
//视频通话中对端旋转屏幕
- (void)onMessageRemoteVideoRotate:(NSString*)degree;
//收到对方切换音视频的请求
//request：0  请求增加视频（需要响应） 1:请求删除视频（不需要响应）
- (void)onSwitchCallMediaType:(NSString *)callid withRequest:(NSInteger)request;

//收到对方应答切换音视频请求
//切换后的媒体状态 0 有视频 1 无视频
- (void)onSwitchCallMediaType:(NSString *)callid withResponse:(NSInteger)response;

//视频分辨率发生改变
- (void)onCallVideoRatioChanged:(NSString *)callid andVoIP:(NSString *)voip andIsConfrence:(BOOL)isConference andWidth:(NSInteger)width andHeight:(NSInteger)height;

//呼叫时，媒体初始化失败
- (void)onCallMediaInitFailed:(NSString *)callid  withMediaType:(NSInteger) mediaType withReason:(NSInteger)reason;

@optional
//回拨回调
- (void)onCallBackWithReason:(CloopenReason*)reason andFrom:(NSString*)src To:(NSString*)dest;


/********************实时对讲的方法********************/

//通知客户端收到新的实时对讲邀请信息（接收到实时对讲的Push消息）
- (void)onReceiveInterphoneMsg:(InterphoneMsg*) msg;

//启动对讲场景状态（实时对讲状态回调方法）
- (void)onInterphoneStateWithReason:(CloopenReason *) reason andConfNo:(NSString*)confNo;

//发起对讲——抢麦（控麦状态回调方法）
- (void)onControlMicStateWithReason:(CloopenReason *) reason andSpeaker:(NSString*)speaker;

//结束对讲——放麦（放麦状态回调方法）
- (void)onReleaseMicStateWithReason:(CloopenReason *) reason;

//获取对讲场景的成员
- (void)onInterphoneMembersWithReason:(CloopenReason *) reason andData:(NSArray*)members;

/********************聊天室的方法********************/
//通知客户端收到新的聊天室信息
- (void)onReceiveChatroomMsg:(ChatroomMsg*) msg;

//聊天室状态
- (void)onChatroomStateWithReason:(CloopenReason *) reason andRoomNo:(NSString*)roomNo;

//获取聊天室的成员
- (void)onChatroomMembersWithReason:(CloopenReason *) reason andData:(NSArray*)members;

//获取聊天室（获取房间列表回调方法）
- (void)onChatroomsWithReason:(CloopenReason *) reason andRooms:(NSArray*)chatrooms;

//邀请加入聊天室
- (void)onChatroomInviteMembersWithReason:(CloopenReason *) reason andRoomNo:(NSString*)roomNo;

/**
 * 解散聊天室回调
 * @param reason 状态值 0:成功
 * @param roomNo 房间号
 */
- (void) onChatroomDismissWithReason:(CloopenReason *) reason andRoomNo:(NSString*) roomNo;

/**
 * 移除成员
 * @param reason 状态值 0:成功
 * @param member 成员号
 */
- (void) onChatroomRemoveMemberWithReason:(CloopenReason *) reason andMember:(NSString*) member;

/********************多媒体IM的方法********************/
// 录音超时
-(void)onRecordingTimeOut:(long) ms;
//通知客户端当前录音振幅
-(void)onRecordingAmplitude:(double) amplitude;
//播放结束
-(void)onFinishedPlaying;
//发送多媒体IM结果回调
- (void) onSendInstanceMessageWithReason: (CloopenReason *) reason andMsg:(InstanceMsg*) data;
// 下载文件回调
- (void)onDownloadAttachedWithReason:(CloopenReason *)reason andFileName:(NSString*) fileName;
//通知客户端收到新的信息
- (void)onReceiveInstanceMessage:(InstanceMsg*) msg;
//确认已下载
- (void)onConfirmInstanceMessageWithReason:(CloopenReason *)reason;


/********************视频会议的方法********************/
//通知客户端收到新的视频会议信息
- (void)onReceiveVideoConferenceMsg:(VideoConferenceMsg*) msg;

//视频会议状态
- (void)onVideoConferenceStateWithReason:(CloopenReason *) reason andConferenceId:(NSString*)conferenceId;

//获取视频会议的成员
- (void)onVideoConferenceMembersWithReason:(CloopenReason *) reason andData:(NSArray*)members;

//获取视频会议（获取房间列表回调方法）
- (void)onVideoConferencesWithReason:(CloopenReason *) reason andConferences:(NSArray*)conferences;

/**
 * 解散视频会议回调
 * @param reason 状态值 0:成功
 * @param roomNo 房间号
 */
- (void) onVideoConferenceDismissWithReason:(CloopenReason *) reason andConferenceId:(NSString*) conferenceId;

/**
 * 移除成员
 * @param reason 状态值 0:成功
 * @param member 成员号
 */
- (void) onVideoConferenceRemoveMemberWithReason:(CloopenReason *) reason andMember:(NSString*) member;

/**
 * 切换主屏幕回调
 * @param reason 状态值 0:成功
 */
- (void) onSwitchRealScreenToVoipWithReason:(CloopenReason *) reason;

/**
 * 发送头像到视频会议
 * @param reason 状态值 0:成功
 * @param portraitPath 本地头像路径
 */
- (void) onSendLocalPortraitWithReason:(CloopenReason *) reason andPortrait:(NSString*)portraitPath;

/**
 * 获取视频会议中的成员头像
 * @param reason 状态值 0:成功
 * @param portraitlist 成员头像列表
 */
- (void) onGetPortraitsFromVideoConferenceWithReason:(CloopenReason *) reason andPortraitList:(NSArray*)portraitlist;

/**
 * 下载头像
 * @param reason 状态值 0:成功
 * @param portrait 成员头像信息
 */
- (void) onDownloadVideoConferencePortraitsWithReason:(CloopenReason *) reason andPortrait:(VideoPartnerPortrait*) portrait;

/********************多路视频的方法********************/
- (void)onRequestConferenceMemberVideoFailed:(CloopenReason *)reason andConferenceId:(NSString*)conferenceId andVoip:(NSString*)voip;
- (void)onCancelConferenceMemberVideo:(CloopenReason *)reason andConferenceId:(NSString*)conferenceId andVoip:(NSString*)voip;
//发布视频
-(void)onPublishVideoInVideoConferenceWithReason:(CloopenReason *)reason;

//取消视频发布
-(void)onUnpublishVideoInVideoConferenceWithReason:(CloopenReason *)reason;


//体验模式 更改测试号码
- (void) onEditTestNumWithReason:(CloopenReason *) reason;
/**
 * 底层上报通话中得原始数据
 * @param callid  会话id
 * @param inData  底层上报的原始声音数据
 * @param outData 加密或解密后的声音数据通过该接口返回给底层
 * @param outLen  加密或解密后的声音数据长度
 * @param isSend  发送或者接收数据，YES为发送，NO为接收
 */
- (void) onAudioDataWithCallid:(NSString*)callid andInData:(NSData*) inData andOutData:(void *)outData andOutLen:(int*)outLen andIsSend:(BOOL) isSend;

/**
 * 上报音频原始数据
 * @param callid  会话id
 * @param inData  底层上报的原始声音数据
 * @param sampleRate 采样率
 * @param numChannels Channel个数
 * @param codec 编解码格式
 */
- (void) onOriginalAudioDataWithCallid:(NSString*)callid andInData:(NSData*) inData andSampleRate:(NSInteger)sampleRate andNumChannels:(NSInteger)numChannels andCodec:(NSString*)codec andIsSend:(BOOL)isSend;
@end

#endif
