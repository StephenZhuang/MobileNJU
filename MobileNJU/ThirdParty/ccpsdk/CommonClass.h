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
#ifndef CPPCallManagerSDK_CCPCommon_h
#define CPPCallManagerSDK_CCPCommon_h
#define ERROR_FILE              29010//文件过大



#import <Foundation/Foundation.h>



//服务器录音文件状态枚举定义
//状态，取值有0（队列），1（发送中），2（已通知），3（接收端不在线，通知失败），4（已接收），5（已下载）
typedef enum {
    EQueue,
    ESending,
    ENotification,
    EOffLine,
    EReceived,
    EDownloaded,
}EVoiceFileState;


typedef enum {
	Rotate_Auto,
	Rotate_0,
	Rotate_90,
	Rotate_180,
	Rotate_270
} Rotate;


typedef enum
{    
    eAUDIO_AGC,   //自动增益控制，默认底层是关闭，开启后默认模式是kAgcAdaptiveAnalog
    eAUDIO_EC,	 //回音消除，默认开启，模式默认是kEcAecm
    eAUDIO_NS	 //静音抑制，默认开启，模式默认是kNsVeryHighSuppression
}EAudioType;

typedef enum    // type of Noise Suppression
{
    eNsUnchanged = 0,   // previously set mode
    eNsDefault,         // platform default
    eNsConference,      // conferencing default
    eNsLowSuppression,  // lowest suppression
    eNsModerateSuppression,
    eNsHighSuppression,
    eNsVeryHighSuppression,     // highest suppression
}EAudioNsMode;

typedef enum                  // type of Automatic Gain Control
{
    eAgcUnchanged = 0,
    // platform default
    eAgcDefault,
    // adaptive mode for use when analog volume control exists (e.g. for
    // PC softphone)
    eAgcAdaptiveAnalog,
    // scaling takes place in the digital domain (e.g. for conference servers
    // and embedded devices)
    eAgcAdaptiveDigital,
    // can be used on embedded devices where the capture signal level
    // is predictable
    eAgcFixedDigital
}EAudioAgcMode;


// EC modes
typedef enum                   // type of Echo Control
{
    eEcUnchanged = 0,          // previously set mode
    eEcDefault,                // platform default
    eEcConference,             // conferencing default (aggressive AEC)
    eEcAec,                    // Acoustic Echo Cancellation
    eEcAecm,                   // AEC mobile
}EAudioEcMode;

typedef enum
{
    SYSCallComing =0,
    BatteryLower
}CCPEvents;

@interface AudioConfig : NSObject
@property(nonatomic, assign) EAudioType audioType;
@property(nonatomic, assign) BOOL enable;
@property(nonatomic, assign) NSInteger audioMode;
@end

//返回丢包率等通话质量信息对象
@interface StatisticsInfo:NSObject
@property (nonatomic,assign)   NSUInteger  rlFractionLost;    //上次调用获取统计后这一段时间的丢包率，范围是0~255，255是100%丢失。
@property (nonatomic,assign)   NSUInteger  rlCumulativeLost;    //开始通话后的所有的丢包总个数
@property (nonatomic,assign)   NSUInteger  rlExtendedMax;       //开始通话后应该收到的包总个数
@property (nonatomic,assign)   NSUInteger  rlJitterSamples;     //rtp抖动率
@property (nonatomic,assign)   NSInteger   rlRttMs;                      //延迟时间，单位是ms
@property (nonatomic,assign)   NSUInteger  rlBytesSent;         //开始通话后发送的总字节数
@property (nonatomic,assign)   NSUInteger  rlPacketsSent;       //开始通话后发送的总RTP包个数
@property (nonatomic,assign)   NSUInteger  rlBytesReceived;     //开始通话后收到的总字节数
@property (nonatomic,assign)   NSUInteger  rlPacketsReceived;   //开始通话后收到的总RTP包个数
@end

//摄像头的信息类
@interface CameraCapabilityInfo : NSObject
@property (nonatomic,assign) NSInteger width;
@property (nonatomic,assign) NSInteger height;
@property (nonatomic,assign) NSInteger maxfps;
@end

//摄像头设备信息类
@interface CameraDeviceInfo : NSObject
@property (nonatomic,assign) NSInteger index;
@property (nonatomic,retain) NSString *name;
@property (nonatomic,retain) NSArray *capabilityArray;
@end

//下载结构文件参数结构定义
@interface DownloadInfo:NSObject
@property (nonatomic,retain) NSString*  fileUrl;//网络文件地址
@property (nonatomic,retain) NSString*  fileName;//本地存储地址
@property (nonatomic,assign) BOOL       isChunked;//是否chunked方式上传
@end

//返回网络流量信息对象
@interface NetworkStatistic:NSObject
@property (nonatomic) long long duration;//媒体交互的持续时间，单位秒，可能为0；
@property (nonatomic) long long txBytes; //在duration时间内，网络发送的总流量，单位字节；
@property (nonatomic) long long rxBytes; //在duration时间内，网络接收的总流量，单位字节；
@end
    

//错误码
@interface CloopenReason : NSObject
@property (nonatomic,assign) NSInteger reason;
@property (nonatomic,retain) NSString *msg;
@end
#pragma mark - 实时语音消息的类
//实时对讲机消息基类定义
@interface InterphoneMsg : NSObject
@property (nonatomic, retain) NSString *interphoneId;
@end

//实时对讲解散消息类定义
@interface InterphoneOverMsg : InterphoneMsg
@end

//邀请加入实时对讲消息类定义
@interface InterphoneInviteMsg : InterphoneMsg
@property (nonatomic, retain) NSString *dateCreated;
@property (nonatomic, retain) NSString *fromVoip;
@end

//有人加入实时对讲消息类定义
@interface InterphoneJoinMsg : InterphoneMsg
@property (nonatomic, retain) NSArray *joinArr;
@end


//有人退出实时对讲消息类定义
@interface InterphoneExitMsg : InterphoneMsg
@property (nonatomic, retain) NSArray *exitArr;

@end

//实时对讲控麦消息类定义
@interface InterphoneControlMicMsg : InterphoneMsg
@property (nonatomic, retain) NSString *voip;
@end

//实时对讲放麦消息类定义
@interface InterphoneReleaseMicMsg : InterphoneMsg
@property (nonatomic, retain) NSString *voip;
@end

//获取到的对讲成员信息
@interface InterphoneMember : NSObject
@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) NSString *online;
@property (nonatomic, retain) NSString *voipId;
@property (nonatomic, retain) NSString *mic;
@end

#pragma mark - 聊天室相关类
//聊天室消息基类定义
@interface ChatroomMsg: NSObject
@property (nonatomic, retain) NSString *roomNo;
@end

//有人加入聊天室消息类定义
@interface ChatroomJoinMsg : ChatroomMsg
@property (nonatomic, retain) NSArray *joinArr;
@end

//有人退出聊天室消息类定义
@interface ChatroomExitMsg : ChatroomMsg
@property (nonatomic, retain) NSArray *exitArr;
@end

//有人被移除聊天室消息类定义
@interface ChatroomRemoveMemberMsg : ChatroomMsg
@property (nonatomic, retain) NSString *who;
@end;

@interface ChatroomDismissMsg : ChatroomMsg
@end;

//获取到的聊天室成员信息
@interface ChatroomMember : NSObject
{
    NSString *type;
    NSString *number;
}
@property (nonatomic, retain) NSString *type;//1为创建者
@property (nonatomic, retain) NSString *number;//VoIP账号
@end

//聊天室信息类
@interface Chatroom : NSObject
@property (nonatomic, retain) NSString *roomNo;
@property (nonatomic, retain) NSString *roomName;
@property (nonatomic, retain) NSString *creator;
@property (nonatomic, assign) NSInteger square;
@property (nonatomic, retain) NSString *keywords;
@property (nonatomic, assign) NSInteger joinNum;
@property (nonatomic, assign) NSInteger validate;
@end


#pragma mark - 实时消息相关类

//基类
@interface InstanceMsg : NSObject
@end

//文本消息
@interface IMTextMsg : InstanceMsg
@property (nonatomic, retain) NSString *msgId;
@property (nonatomic, retain) NSString *dateCreated;
@property (nonatomic, retain) NSString *sender;
@property (nonatomic, retain) NSString *receiver;
@property (nonatomic, retain) NSString *message;
@property (nonatomic, retain) NSString *userData;
@property (nonatomic, retain) NSString *status;
@end

//附件消息
@interface IMAttachedMsg : InstanceMsg
@property (nonatomic, retain) NSString *userData;
@property (nonatomic, retain) NSString *msgId;
@property (nonatomic, retain) NSString *dateCreated;
@property (nonatomic, retain) NSString *sender;
@property (nonatomic, retain) NSString *receiver;
@property (nonatomic, assign) NSInteger fileSize;
@property (nonatomic, retain) NSString *fileUrl;
@property (nonatomic, retain) NSString *ext;
@property (nonatomic, assign) BOOL     chunked;
@end


//解散群组
@interface IMDismissGroupMsg : InstanceMsg
@property (nonatomic, retain) NSString *groupId;
@end


//收到邀请
@interface IMInviterMsg : InstanceMsg
@property (nonatomic, retain) NSString *groupId;
@property (nonatomic, retain) NSString *admin;
@property (nonatomic, retain) NSString *declared;
@property (nonatomic, retain) NSString *confirm;
@end

//收到申请
@interface IMProposerMsg : InstanceMsg
@property (nonatomic, retain) NSString *groupId;
@property (nonatomic, retain) NSString *proposer;
@property (nonatomic, retain) NSString *declared;
@property (nonatomic, retain) NSString *dateCreated;
@end

//有成员加入
@interface IMJoinGroupMsg : InstanceMsg
@property (nonatomic, retain) NSString *groupId;
@property (nonatomic, retain) NSString *member;
@property (nonatomic, retain) NSString *declared;
@property (nonatomic, retain) NSString *dateCreated;
@end

//退出群组
@interface IMQuitGroupMsg : InstanceMsg
@property (nonatomic, retain) NSString *groupId;
@property (nonatomic, retain) NSString *member;
@end


//移除成员
@interface IMRemoveMemberMsg : InstanceMsg
@property (nonatomic, retain) NSString *groupId;
@property (nonatomic, retain) NSString *member;
@end

//答复申请加入
@interface IMReplyJoinGroupMsg : InstanceMsg
@property (nonatomic, retain) NSString *groupId;
@property (nonatomic, retain) NSString *admin;
@property (nonatomic, retain) NSString *confirm;
@property (nonatomic, retain) NSString *member;
@end

//答复邀请加入
@interface IMReplyInviteGroupMsg : InstanceMsg
@property (nonatomic, retain) NSString *groupId;
@property (nonatomic, retain) NSString *admin;
@property (nonatomic, retain) NSString *confirm;
@property (nonatomic, retain) NSString *member;
@end

//合作方消息
@interface IMCooperMsg : IMAttachedMsg
@property (nonatomic, retain) NSString * message;
@property (nonatomic, assign) NSInteger type;
@end


#pragma mark - 视频会议相关类
//视频会议消息基类定义
@interface VideoConferenceMsg: NSObject
@property (nonatomic, retain) NSString *conferenceId;
@end

//有人加入视频会议消息类定义
@interface VideoConferenceJoinMsg : VideoConferenceMsg
@property (nonatomic, retain) NSArray *joinArr;
@property (nonatomic, assign) NSInteger videoState;
@property (nonatomic, retain) NSString *videoSrc;
@end

//有人退出视频会议消息类定义
@interface VideoConferenceExitMsg : VideoConferenceMsg
@property (nonatomic, retain) NSArray *exitArr;
@end

//有人被移除视频会议消息类定义
@interface VideoConferenceRemoveMemberMsg : VideoConferenceMsg
@property (nonatomic, retain) NSString *who;
@end;

@interface VideoConferenceDismissMsg : VideoConferenceMsg
@end;

@interface VideoConferenceSwitchScreenMsg : VideoConferenceMsg
@property (nonatomic, retain) NSString *displayVoip;
@end

@interface VideoConferencePublishVideoMsg : VideoConferenceMsg
@property (nonatomic, retain) NSString *who;
@property (nonatomic, assign) NSInteger videoState;
@property (nonatomic, retain) NSString *videoSrc;
@end

@interface VideoConferenceUnpublishVideoMsg : VideoConferenceMsg
@property (nonatomic, retain) NSString *who;
@property (nonatomic, assign) NSInteger videoState;
@end

//获取到的视频会议成员信息
@interface VideoConferenceMember : NSObject
@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) NSString *number;
@property (nonatomic, assign) NSInteger screenType;
@property (nonatomic, assign) NSInteger videoState;
@property (nonatomic, retain) NSString *videoSource;
@end

//视频会议信息类
@interface VideoConference : NSObject
@property (nonatomic, retain) NSString *conferenceId;
@property (nonatomic, retain) NSString *conferenceName;
@property (nonatomic, retain) NSString *creator;
@property (nonatomic, assign) NSInteger square;
@property (nonatomic, retain) NSString *keywords;
@property (nonatomic, assign) NSInteger joinNum;
@property (nonatomic, assign) NSInteger validate;
@property (nonatomic, assign) NSInteger isMultiVideo;
@property (nonatomic, retain) NSString *confAttrs;
@end

//视频会议头像信息类
@interface VideoPartnerPortrait : NSObject
@property (nonatomic, retain) NSString *dateUpdate;
@property (nonatomic, retain) NSString *voip;
@property (nonatomic, retain) NSString *fileName;
@property (nonatomic, retain) NSString *fileUrl;
@end
#endif

