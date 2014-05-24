/*!
 @header FrontiaPersonalStorageDalegate.h
 @abstract 对个人数据存储的操作涉及的数据结构。
 @version 1.00 2013/06/19 Creation
 @copyright (c) 2013 baidu. All rights reserved.
 */

/*!
 @class FrontiaPersonalFileInfo
 @abstract 记录个人数据存储上的文件的文件信息的数据结构。
 */
@interface FrontiaPersonalFileInfo : NSObject

/*!
 @property fs_id
 @abstract 文件在个人云存储上的唯一id。
 */
@property(strong, nonatomic) NSString *fs_id;

/*!
 @property path
 @abstract 文件的绝对路径。
 */
@property(strong, nonatomic) NSString *path;

/*!
 @property mTime
 @abstract 文件最近一次被修改的时间。
 */
@property(assign, nonatomic) long mTime;

/*!
 @property cTime
 @abstract 文件被创建的时间。
 */
@property(assign, nonatomic) long cTime;

/*!
 @property md5
 @abstract 文件内容的MD5。
 */
@property(strong, nonatomic)NSString *blockList;

/*!
 @property size
 @abstract 文件的大小。
 */
@property(assign, nonatomic) int size;

/*!
 @property isDir
 @abstract 判定该文件是否是文件夹。TRUE表示是文件夹。
 */
@property(assign, nonatomic) BOOL isDir;

/*!
 @property hasSubFolder
 @abstract 判定该文件是否包含子文件夹。TRUE表示包含子文件夹。
 */
@property(assign, nonatomic) BOOL hasSubFolder;

@end

/*!
 @class FrontiaPersonalDifferEntryInfo
 @abstract 增量跟新请求返回的对象
 */
@interface FrontiaPersonalDifferEntryInfo : NSObject

/*!
 @property FrontiaPersonalFileInfo
 @abstract 个人云储存上文件信息
 */
@property(strong, nonatomic) FrontiaPersonalFileInfo *commonFileInfo;

/*!
 @property isDeleted
 @abstract 是否是被删除的文件
 */
@property(assign, nonatomic) BOOL isDeleted;

@end

/*!
 @class FrontiaPersonalDiffResponse
 @abstract 获取增量信息结果的数据结构
 */
@interface FrontiaPersonalDiffResponse : NSObject

/*!
 @property entries
 @abstract 包含FrontiaPersonalDifferEntryInfo的数组
 */
@property(strong, nonatomic) NSArray *entries;

/*!
 @property hasMore
 @abstract 是否还有更多的增量更新信息
 */
@property(assign, nonatomic) BOOL hasMore;

/*!
 @property isReseted
 @abstract 是否是重新设置游标
 */
@property(assign, nonatomic) BOOL isReseted;

/*!
 @property cursor
 @abstract 当前增量更新请求的游标
 */
@property(strong, nonatomic) NSString *cursor;

@end

/*!
 @class FrontiaPersonalFileFromToInfo
 @abstract 记录个人数据存储上的移动文件信息的数据结构。
 */
@interface  FrontiaPersonalFileFromToInfo : NSObject

/*!
 @property from
 @abstract 个人数据存储源文件路径
 */
@property(strong, nonatomic) NSString *from;

/*!
 @property to
 @abstract 个人数据存储上目的文件路径
 */
@property(strong, nonatomic) NSString *to;

@end

/*!
 @class FrontiaPersonalCloudDownloadTaskInfo
 @abstract 离线下载任务的数据结构
 */
@interface FrontiaPersonalCloudDownloadTaskInfo : NSObject
/*!
 @property taskId
 @abstract 任务的task id
 */
@property (strong, nonatomic)NSString *taskId;
/*!
 @property status
 @abstract 任务的状态
 */
@property (assign, nonatomic)int status;
/*!
 @property result
 @abstract 结果
 */
@property (assign, nonatomic)int result;
/*!
 @property sourceUrl
 @abstract 源文件下载地址
 */
@property (strong, nonatomic)NSString *sourceUrl;
/*!
 @property targetPath
 @abstract 放置到个人数据存储上的路径
 */
@property (strong, nonatomic)NSString *targetPath;
/*!
 @property rateLimit
 @abstract 频率限制
 */
@property (assign, nonatomic)int rateLimit;
/*!
 @property timeout
 @abstract 超时时间
 */
@property (assign, nonatomic)int timeout;
/*!
 @property callback
 @abstract 回调地址
 */
@property (strong, nonatomic)NSString *callback;
/*!
 @property createTime
 @abstract 任务创建时间
 */
@property (assign, nonatomic)long long int createTime;

@end


/*!
 @class FrontiaPersonalCloudDownloadTaskResponse
 @abstract 查询离线下载任务返回结果的数据结构
 */
@interface FrontiaPersonalCloudDownloadTaskResponse : NSObject

/*!
 @property total
 @abstract 总任务数
 */
@property (assign, nonatomic) int total;
/*!
 @property taskList
 @abstract 包含了FrontiaPersonalCloudDownloadTaskInfo对象的离线下载任务的数组。
 */
@property (strong, nonatomic) NSMutableArray *taskList;

@end


/*!
 @class FrontiaPersonalListRecycleResponse
 @abstract 遍历回收站请求返回的数据结构
 */
@interface FrontiaPersonalListRecycleResponse : NSObject

/*!
 @property
 @abstract 请求ID
 */
@property (strong, nonatomic) NSString* requestId;
/*!
 @property
 @abstract 包含FrontiaPersonalFileInfo的回收站文件数组
 */
@property (strong, nonatomic) NSMutableArray *fileList;

@end

/*!
 @class FrontiaPersonalRestoreRecycleResponse
 @abstract 还原回收站文件请求的返回数据结构
 */
@interface FrontiaPersonalRestoreRecycleResponse : NSObject

/*!
 @property
 @abstract 包含了成功还原文件ID的数组
 */
@property (strong, nonatomic) NSMutableArray *fileIds;

@end

/*!
 @abstract 监视向个人数据存储上面上传文件，或是从个人数据存储上面下载文件的进度的监听器。
 @param file
    被上传或下载的文件的文件名。
 @param bytes
    当前已上传或下载的字节数。
 @param total
    被上传或下载的文件的大小（总字节数）。
 @result
    无。
 */
typedef void(^FrontiaPersonalProgressCallback)(NSString* file, long bytes, long total);

/*!
 @abstract 个人数据存储文件相关操作失败的回调函数。
 @param errorCode
    错误码。
 @param errorMessage
    错误原因。
 @result
    无。
 */
typedef void(^FrontiaPersonalFailureCallback)(int errorCode, NSString* errorMessage);

/*!
 @abstract 操作个人数据存储文件成功时的回调函数。
 @param fileName
    被操作文件的文件名。
 @result
    无。
 */
typedef void(^FrontiaPersonalFileOperationCallBack)(NSString *fileName);

/*!
 @abstract 个人数据存储文件移动或者拷贝成功时的回调函数。
 @param list
    包含FrontiaPersonalFileFromToInfo的对象的数组。
 @result
    无。
 */
typedef void(^FrontiaPersonalFileFromToCallBack)(NSArray *list);

/*!
 @abstract 上传文件到个人数据存储的回调函数。
 @param target
     文件上传到的目的路径。
 @param result
     个人数据存储上文件内容。
 @result
     无。
 */
typedef void(^FrontiaPersonalUploadResultCallback)(NSString *target, FrontiaPersonalFileInfo *result);

/*!
 @abstract 下载个人数据存储文件的回调函数。
 @param file
     要被下载的个人数据存储文件路径。
 @param data
     下载到本地的文件内容。
 @result
     无。
 */
typedef void(^FrontiaPersonalDownloadCallback)(NSString* file, NSData *data);

/*!
 @abstract 列举个人数据存储上所有文件的回调函数。
 @param list
     列举出的个人数据存储上面所有的文件列表。
 @result
     无。
 */
typedef void(^FrontiaPersonalListCallback)(NSArray *list);


/*!
 @abstract 查询个人数据存储配额的回调函数。
 @param used
     已经使用的个人数据存储配额。
 @param total
     可供使用的个人数据存储配额。
 @result
     无。
 */
typedef void(^FrontiaPersonalQuotaCallback)(long long used, long long total);

/*!
 @abstract 查询个人数据存储上面文件元信息的回调函数。
 @param file
    要查询的文件路径。
 @param result
    文件的元信息数据信息。
 @result
 无。
 */
typedef void(^FrontiaPersonalMetaCallback)(NSString* file, FrontiaPersonalFileInfo* result);

/*!
 @abstract 查询个人数据存储上面一组文件元信息的回调函数。
 @param fileList
    包含要查询的文件路径列表。
 @param infoList
    包含文件的元信息数据FrontiaPersonalFileInfo的列表。
 @result
    无。
 */
typedef void(^FrontiaPersonalMetaListCallback)(NSArray* fileList, NSArray* infoList);

/*!
 @abstract 获取个人数据存储上增量更新信息的回调函数。
 @param result
    获取的增量信息。
 @result
    无。
 */
typedef void(^FrontiaPersonalDiffCallback)(FrontiaPersonalDiffResponse* result);

/*!
 @abstract 获取个人数据存储上流文件转码的回调函数。
 @param url
    获取流文件转码后的url信息。
 @result
    无。
 */
typedef void(^FrontiaPersonalStreamingUrlCallback)(NSString* url);

/*!
 @abstract 添加离线任务成功回调函数。
 @param taskId
    添加离线任务的任务ID。
 @result
    无。
 */
typedef void(^FrontiaPersonalAddCloudDownloadCallback)(NSString* taskId);

/*!
 @abstract 查询离线任务成功回调函数。
 @param task
    离线任务对象。
 @result
    无。
 */
typedef void(^FrontiaPersonalCloudDownloadListCallback)(FrontiaPersonalCloudDownloadTaskResponse* task);

/*!
 @abstract 取消离线任务成功回调函数。
 @param taskId
    成功取消的任务Id。
 @result
    无。
 */
typedef void(^FrontiaPersonalCloudDownloadCancelCallback)(NSString* taskId);

/*!
 @abstract 遍历回收站成功回调函数。
 @param result
    回收站文件数组。
 @result
    无。
 */
typedef void(^FrontiaPersonalRecycleListCallback)(FrontiaPersonalListRecycleResponse* result);

/*!
 @abstract 还原回收站文件成功回调函数。
 @param result
    回收站文件数组。
 @result
    无。
 */
typedef void(^FrontiaPersonalRecycleRestoreCallback)(FrontiaPersonalRestoreRecycleResponse* result);

/*!
 @abstract 还原回收站文件失败回调函数。
 @param errorCode
    错误码。
 @param errorMessage
    错误原因。
 @param successIds
    还原成功的文件id列表。
 @result
 无。
 */
typedef void(^FrontiaPersonalRecycleRestoreFailureCallback)(int errorCode, NSString* errorMessage, NSArray* successIds);

/*!
 @abstract 清空回收站文件成功回调函数。
 @result
    无。
 */
typedef void(^FrontiaPersonalRecycleCleanCallback)();



