/*!
 @header FrontiaPersonalStorageModel.h
 @abstract 提供对个人云存储PCS(Personal Cloud Storage)的操作的模块。
 @discussion 在正式使用个人云存储之前，需要到百度开发者中心进行特定的权限开通，管理中心－>应用管理－>应用－>API列表，在这个页面开通PCS API列表就可以了。
     在调用这个类之前需要先完成授权工作，设置当前用户，必须时通过百度帐号来进行登陆，而且scope必须包括授权声明：basic和netdisk。
     在开通个人云存储之后就可以直接使用了，下边示例，
 
       FrontiaAuthorization *auth = [Frontia getAuthorization];
     
       NSMutableArray *scope = [[NSMutableArray alloc] init];
       [scope addObject:@"basic"];
       [scope addObject:@"netdisk"];
 
       [auth authorizeWithController:yourUIController
                          platform:FRONTIA_SOCIAL_PLATFORM_BAIDU
                             scope:scope
                    cancelListener:onCancel
                   failureListener:onFailure
                    resultListener:onResult];
      
        //in onResult, get the user
        [Frontia setCurrentAccount:user];
 
  	    FrontiaPersonalStorage *personalStorage = [Frontia getPersonalStorage];
  	    [personalStorage quota:listener];
 
  	  如果需要访问图片流，视频流等，需要scope包含如下额外授权声明：
  	    图片流：pcs_album
  	    视频流：pcs_video
  	    音乐流：pcs_music
  	    文档流：pcs_doc
 @version 1.00 2013/06/19 Creation
 @copyright (c) 2013 baidu. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "IModule.h"
#import "FrontiaPersonalStorageDelegate.h"

/*!
 * 定义支持的视频转码格式类型
 */
#define STREAMING_TYPE_M3U8_480_224    @"M3U8_480_224"
#define STREAMING_TYPE_M3U8_480_320    @"M3U8_480_320"
#define STREAMING_TYPE_M3U8_480_360    @"M3U8_480_360"
#define STREAMING_TYPE_M3U8_640_360    @"M3U8_640_360"
#define STREAMING_TYPE_M3U8_640_480    @"M3U8_640_480"
#define STREAMING_TYPE_M3U8_854_480    @"M3U8_854_480"
#define STREAMING_TYPE_M3U8_1280_720   @"M3U8_1280_720"
#define STREAMING_TYPE_M3U8_1920_1080  @"M3U8_1920_1080"
#define STREAMING_TYPE_M3U8_AUTO_240   @"M3U8_AUTO_240"
#define STREAMING_TYPE_M3U8_AUTO_360   @"M3U8_AUTO_360"
#define STREAMING_TYPE_M3U8_AUTO_480   @"M3U8_AUTO_480"
#define STREAMING_TYPE_M3U8_AUTO_720   @"M3U8_AUTO_720"
#define STREAMING_TYPE_MP4_360P        @"MP4_360P"
#define STREAMING_TYPE_MP4_480P        @"MP4_480P"

/*!
 @enum
 @abstract 离线下载任务状态列表。
 @constant Cloud_Download_Status_Undefine
    未指定状态。
 @constant Cloud_Download_Status_Success
    下载成功。
 @constant Cloud_Download_Status_Downloading
    正在下载。
 @constant Cloud_Download_Status_Busy
    系统繁忙。
 @constant Cloud_Download_Status_File_Not_Exist
    下载资源不存在。
 @constant Cloud_Download_Status_Timeout
    任务超时。
 @constant Cloud_Download_Status_Download_Fail
    下载失败。
 @constant Cloud_Download_Status_Not_Enough_Space
    用户空间不足。
 @constant Cloud_Download_Status_User_Canceled
    任务已取消。
 @constant Cloud_Download_Status_File_Already_Exist
    下载文件已存在。
 @constant Cloud_Download_Status_User_Deleted
    任务已删除。
 @constant Cloud_Download_Status_Part_Success
    下载部分成功（bt任务）。
*/
typedef enum CloudDownloadTaskStatus {
    Cloud_Download_Status_Undefine = -1,
    Cloud_Download_Status_Success = 0,
    Cloud_Download_Status_Downloading = 1,
    Cloud_Download_Status_Busy = 2,
    Cloud_Download_Status_File_Not_Exist = 3,
    Cloud_Download_Status_Timeout = 4,
    Cloud_Download_Status_Download_Fail = 5,
    Cloud_Download_Status_Not_Enough_Space = 6,
    Cloud_Download_Status_User_Canceled = 7,
    Cloud_Download_Status_File_Already_Exist = 8,
    Cloud_Download_Status_User_Deleted = 9,
    Cloud_Download_Status_Part_Success = 10
} TCloudDownloadTaskStatus;

/*!
 @enum FrontiaCloudDownloadOrder
 @abstract 查询结果排序。
 @constant CloudDownloadOrder_DESC
    按字母表正序排列。
 @constant CloudDownloadOrder_ASC
    按字母表倒序排列
 */
typedef enum FrontiaCloudDownloadOrder
{
    CloudDownloadOrder_DESC,
    CloudDownloadOrder_ASC
}TFrontiaCloudDownloadOrder;
/*!
 @class FrontiaPersonalStorage
 @abstract 提供对个人云存储的操作的模块。
 */
@interface FrontiaPersonalStorage : NSObject <IModule>

/*!
 @method uploadFileWithData
 @abstract 将指定文件上传到个人云存储的指定路径，可监控上传的进度。
 @param data
     指定文件
 @param target
     个人云存储上的指定路径。
 @param statusListener
     监听上传进度的监听器。
 @param resultListener
     上传成功后的回调函数。
 @param failureListener
     上传失败后的回调函数。
 @result 无
 */
-(void)uploadFileWithData:(NSData*)data
                   target:(NSString*)target
           statusListener:(FrontiaPersonalProgressCallback)statusListener
           resultListener:(FrontiaPersonalUploadResultCallback)resultListener
          failureListener:(FrontiaPersonalFailureCallback)failureListener;

/*!
 @method uploadFileWithData
 @abstract 将指定文件上传到个人云存储的指定路径，没有上传进度监听。
 @param data
     指定文件
 @param target
     个人云存储上的指定路径。
 @param resultListener
     上传成功后的回调函数。
 @param failureListener
     上传失败后的回调函数。
 @result 无
 */
-(void)uploadFileWithData:(NSData*)data
                   target:(NSString*)target
           resultListener:(FrontiaPersonalUploadResultCallback)resultListener
          failureListener:(FrontiaPersonalFailureCallback)failureListener;

/*!
 @method downloadFileWithSource
 @abstract 将个人云存储上指定路径的文件下载到本地，没有下载进度监听。
 @param source
     个人云存储上指定路径的文件。
 @param resultListener
     下载成功后的回调函数。
 @param failureListener
     下载失败后的回调函数。
 @result 无
 */
-(void)downloadFileWithSource:(NSString*)source
                    resultListener:(FrontiaPersonalDownloadCallback)resultListener
                   failureListener:(FrontiaPersonalFailureCallback)failureListener;

/*!
 @method downloadFileWithSource
 @abstract 将个人云存储上指定路径的文件下载到本地，可监控下载的进度。
 @param accessToken
     access token
 @param source
     个人云存储上指定路径的文件。
 @param statusListener
     监听下载进度的监听器。
 @param resultListener
     下载成功后的回调函数。
 @param failureListener
     下载失败后的回调函数。
 @result 无
 */
-(void)downloadFileWithSource:(NSString*)source
               statusListener:(FrontiaPersonalProgressCallback)statusListener
               resultListener:(FrontiaPersonalDownloadCallback)resultListener
              failureListener:(FrontiaPersonalFailureCallback)failureListener;

/*!
 @method downloadFileFromStreamWithSource
 @abstract 将个人云存储上指定路径的fstream文件下载到本地，可监控下载的进度。
 @param source
     个人云存储上指定路径的文件。
 @param statusListener 
     监听下载进度的监听器。
 @param resultListener
     下载成功后的回调函数。
 @param failureListener
     下载失败后的回调函数。
 */
-(void)downloadFileFromStreamWithSource:(NSString*)source
                         statusListener:(FrontiaPersonalProgressCallback)statusListener
                         resultListener:(FrontiaPersonalDownloadCallback)resultListener
                        failureListener:(FrontiaPersonalFailureCallback)failureListener;

/*!
 @method downloadFileFromStreamWithSource
 @abstract 将个人云存储上指定路径的fstream文件下载到本地。
 @param source
     个人云存储上指定路径的文件。
 @param resultListener
     下载成功后的回调函数。
 @param failureListener
     下载失败后的回调函数。
 */
-(void)downloadFileFromStreamWithSource:(NSString*)source
                         resultListener:(FrontiaPersonalDownloadCallback)resultListener
                        failureListener:(FrontiaPersonalFailureCallback)failureListener;

/*!
 @method stopDownloadingWithSource
 @abstract 停止所有下载个人云存储上同一路径下的文件的任务。
 @param source
 被下载的云端文件的路径。
 */
-(void)stopDownloadingWithSource:(NSString*)source;

/*!
 @method stopUploadingWithTarget
 @abstract 停止所有上传到个人云存储上同一路径的任务。
 @param target
 文件被上传到的云端路径。
 */
-(void)stopUploadingWithTarget:(NSString*)target;

/*!
 @method deleteFileWithPath
 @abstract 将个人云存储上指定路径的文件删除。
 @param filePath 
     个人云存储上指定路径的文件。
 @param resultListener 
     删除成功后的回调函数。
 @param failureListener
     删除失败后的回调函数。
 */
-(void)deleteFileWithPath:(NSString*)filePath
           resultListener:(FrontiaPersonalFileOperationCallBack)resultListener
          failureListener:(FrontiaPersonalFailureCallback)failureListener;

/*!
 @method moveFileWithPath
 @abstract 将个人云存储上指定路径的文件移动到指定位置。
 @param path
    个人云存储上指定路径的文件。
 @param resultListener
    移动成功后的回调函数。
 @param failureListener
    移动失败后的回调函数。
 */
-(void)moveFileWithPath:(NSString*)path
                     to:(NSString*)to
         resultListener:(FrontiaPersonalFileFromToCallBack)resultListener
        failureListener:(FrontiaPersonalFailureCallback)failureListener;

/*!
 @method moveFileWithList
 @abstract 将个人云存储上指定路径的一组文件移动到指定位置。
 @param list
    FrontiaPersonalFileInfo数组，保存需要移动的文件信息。
 @param resultListener
    移动成功后的回调函数。
 @param failureListener
    移动失败后的回调函数。
 */
-(void)moveFileWithList:(NSArray*)list
         resultListener:(FrontiaPersonalFileFromToCallBack)resultListener
        failureListener:(FrontiaPersonalFailureCallback)failureListener;

/*!
 @method copyWithPath
 @abstract 将个人云存储上指定路径的文件拷贝到指定位置。
 @param path
    个人云存储上指定路径的文件。
 @param resultListener
    拷贝成功后的回调函数。
 @param failureListener
    拷贝失败后的回调函数。
 */
-(void)copyWithPath:(NSString*)path
                 to:(NSString*)to
     resultListener:(FrontiaPersonalFileFromToCallBack)resultListener
    failureListener:(FrontiaPersonalFailureCallback)failureListener;

/*!
 @method copyFileWithList
 @abstract 拷贝个人云存储上指定路径的一组文件到指定位置。
 @param list
    FrontiaPersonalFileInfo数组，保存需要拷贝的文件信息。
 @param resultListener
    拷贝成功后的回调函数。
 @param failureListener
    拷贝失败后的回调函数。
 */
-(void)copyFileWithList:(NSArray*)list
         resultListener:(FrontiaPersonalFileFromToCallBack)resultListener
        failureListener:(FrontiaPersonalFailureCallback)failureListener;

/*!
 @method listWithPath
 @abstract 列举个人云存储上存储在给定路径下的所有文件。
 @param path
     个人云存储上的给定路径。
 @param resultListener
     列举成功后的回调函数。
 @param failureListener
     列举失败后的回调函数。
 */
-(void)listWithPath:(NSString*)path
     resultListener:(FrontiaPersonalListCallback)resultListener
    failureListener:(FrontiaPersonalFailureCallback)failureListener;

/*!
 @method listWithPath
 @abstract 列举个人云存储上存储在给定路径下的所有文件，列举结果根据给定角色进行排序。
 @param path
     个人云存储上的给定路径。
 @param by 
     给定角色，可以是多个角色。
 @param order
     排序方法。
 @param resultListener
     列举成功后的回调函数。
 @param failureListener
     列举失败后的回调函数。
 */
-(void)listWithPath:(NSString*)path
                 by:(NSString*)by
              order:(NSString*)order
    resultListener:(FrontiaPersonalListCallback)resultListener
           failureListener:(FrontiaPersonalFailureCallback)failureListener;

/*!
 @method imageStream
 @abstract 从个人云存储上获得图片文件。
 @param resultListener
     获取成功后的回调函数。
 @param failureListener
     获取失败后的回调函数。
 */
-(void)imageStream:(FrontiaPersonalListCallback)resultListener
   failureListener:(FrontiaPersonalFailureCallback)failureListener;

/*!
 @method videoStream
 @abstract 从个人云存储上获得视频文件。
 @param resultListener
     获取成功后的回调函数。
 @param failureListener
     获取失败后的回调函数。
 */
-(void)videoStream:(FrontiaPersonalListCallback)resultListener
   failureListener:(FrontiaPersonalFailureCallback)failureListener;

/*!
 @method audioStream
 @abstract 从个人云存储上获得音频文件。
 @param resultListener
     获取成功后的回调函数。
 @param failureListener
     获取失败后的回调函数。
 */
-(void)audioStream:(FrontiaPersonalListCallback)resultListener
   failureListener:(FrontiaPersonalFailureCallback)failureListener;

/*!
 @method docStream
 @abstract 从个人云存储上获得文本文件。
 @param resultListener
     获取成功后的回调函数。
 @param failureListener
     获取失败后的回调函数。
 */
-(void)docStream:(FrontiaPersonalListCallback)resultListener
 failureListener:(FrontiaPersonalFailureCallback)failureListener;

/*!
 @method makeDirWithPath
 @abstract 在个人云存储的指定路径创建新文件夹。
 @param path
     个人云存储的指定路径。
 @param resultListener
     获取成功后的回调函数。
 @param failureListener
     获取失败后的回调函数。
 */
-(void)makeDirWithPath:(NSString*)path
        resultListener:(FrontiaPersonalFileOperationCallBack)resultListener
       failureListener:(FrontiaPersonalFailureCallback)failureListener;

/*!
 @method thumbnailWithPath
 @abstract 为个人云存储上指定路径的图片生成本地缩略图。
 @param path
     个人云存储上指定路径的图片。
 @param quality
     缩略图的质量，范围是开区间：(0,100]。
 @param width
     缩略图的宽，最大值是850。
 @param height
     缩略图的高，最大值是580。
 @param resultListener
     本地缩略图生成成功后的回调函数。
 @param failureListener
     本地缩略图生成失败后的回调函数。
 */
-(void)thumbnailWithPath:(NSString*)path
                 quality:(int)quality
                   width:(int)width
                  height:(int)height
          resultListener:(FrontiaPersonalDownloadCallback)resultListener
         failureListener:(FrontiaPersonalFailureCallback)failureListener;

/*!
 @method quotaInfo
 @abstract 获取个人云存储配额信息。
 @param resultListener
     获取配额信息成功后的回调函数。
 @param failureListener
     获取配额信息失败后的回调函数。
 */
-(void)quotaInfo:(FrontiaPersonalQuotaCallback)resultListener
 failureListener:(FrontiaPersonalFailureCallback)failureListener;

/*!
 @method metaWithPath
 @abstract 获取个人云存储文件或目录的元信息。
 @param path
    个人云存储的指定路径。
 @param resultListener
    获取文件或者目录的元信息成功后的回调函数。
 @param failureListener
    获取文件或者目录的元信息失败后的回调函数。
 */
-(void)metaWithPath:(NSString*)path
     resultListener:(FrontiaPersonalMetaCallback)resultListener
    failureListener:(FrontiaPersonalFailureCallback)failureListener;

/*!
 @method metaWithPaths
 @abstract 获取个人云存储一系列文件或目录的元信息。
 @param paths
    包含个人云存储的一系列文件指定路径的数组。
 @param resultListener
    获取文件或者目录的元信息成功后的回调函数。
 @param failureListener
    获取文件或者目录的元信息失败后的回调函数。
 */
-(void)metaWithPaths:(NSArray*)paths
      resultListener:(FrontiaPersonalMetaListCallback)resultListener
     failureListener:(FrontiaPersonalFailureCallback)failureListener;

/*!
 @method diff
 @abstract 获取个人云存储增量更新信息。
 @param resultListener
    获取增量更新信息成功后的回调函数。
 @param failureListener
    获取增量更新信息失败后的回调函数。
 */
-(void)diff:(FrontiaPersonalDiffCallback)resultListener
    failureListener:(FrontiaPersonalFailureCallback)failureListener;

/*!
 @method diff
 @abstract 获取个人云存储增量更新信息。
 @param cursor
    上次增量更新时使用游标。
 @param resultListener
    获取增量更新信息成功后的回调函数。
 @param failureListener
    获取增量更新信息失败后的回调函数。
 */
-(void)diff:(NSString*)cursor
resultListener:(FrontiaPersonalDiffCallback)resultListener
failureListener:(FrontiaPersonalFailureCallback)failureListener;

/*!
 @method streamingUrlWithPath
 @abstract 获取个人数据存储上文件转码后的地址。
 @param path
    需要转码的文件在个人云存储上全路径。
 @param mediaType
    转码类型。具体类型可参看开发者中心网站
 @param resultListener
    获取转码url成功后的回调函数。
 @param failureListener
    获取转码url失败后的回调函数。
 */
-(void)streamingUrlWithPath:(NSString*)path
                  mediaType:(NSString*)mediaType
             resultListener:(FrontiaPersonalStreamingUrlCallback)resultListener
            failureListener:(FrontiaPersonalFailureCallback)failureListener;

/*!
 @method addCloudDownloadWithPath
 @abstract 添加离线下载任务。
 @param path
    需要添加离线下载任务的文件url。
 @param targetPath
    保存到个人数据存储的目录
 @param resultListener
    添加离线任务成功后的回调函数。
 @param failureListener
    添加离线任务失败后的回调函数。
 */
-(void)addCloudDownloadWithUrl:(NSString *)sourceUrl
                    targetPath:(NSString *)targetPath
                resultListener:(FrontiaPersonalAddCloudDownloadCallback)resultListener
               failureListener:(FrontiaPersonalFailureCallback)failureListener;

/*!
 @method cloudDownloadTaskList
 @abstract 查询离线下载任务。
 @param resultListener
    查询离线任务成功后的回调函数。
 @param failureListener
    查询离线任务失败后的回调函数。
 */
-(void)cloudDownloadTaskList:(FrontiaPersonalCloudDownloadListCallback)resultListener
             failureListener:(FrontiaPersonalFailureCallback)failureListener;

/*!
 @method cloudDownloadTaskList
 @abstract 查询离线下载任务。
 @param start
    开始条目数。
 @param limit
    返回条数限制。
 @param asc
    文件排序规则。
 @param needTaskInfo
    返回任务详细信息。
 @param status
    任务状态。
 @param resultListener
    查询离线任务成功后的回调函数。
 @param failureListener
    查询离线任务失败后的回调函数。
 */
-(void)cloudDownloadTaskList:(int)start
                       limit:(int)limit
                         asc:(TFrontiaCloudDownloadOrder)asc
                needTaskInfo:(BOOL)needTaskInfo
                      status:(TCloudDownloadTaskStatus)status
              resultListener:(FrontiaPersonalCloudDownloadListCallback)resultListener
             failureListener:(FrontiaPersonalFailureCallback)failureListener;

/*!
 @method queryCloudDownloadTaskWithId
 @abstract 精确查询离线下载任务。
 @param taskId
    任务ID。
 @param resultListener
    查询离线任务成功后的回调函数。
 @param failureListener
    查询离线任务失败后的回调函数。
 */
-(void)queryCloudDownloadTaskWithId:(NSString *)taskId
                     resultListener:(FrontiaPersonalCloudDownloadListCallback)resultListener
                    failureListener:(FrontiaPersonalFailureCallback)failureListener;

/*!
 @method queryCloudDownloadTaskWithIds
 @abstract 精确查询离线下载任务。
 @param taskIds
    任务ID数组。
 @param resultListener
    查询离线任务成功后的回调函数。
 @param failureListener
    查询离线任务失败后的回调函数。
 */
-(void)queryCloudDownloadTaskWithIds:(NSArray *)taskIds
                      resultListener:(FrontiaPersonalCloudDownloadListCallback)resultListener
                     failureListener:(FrontiaPersonalFailureCallback)failureListener;
/*!
 @method cancelCloudDownloadTaskWithId
 @abstract 取消离线下载任务。
 @param taskId
    任务ID。
 @param resultListener
    取消离线任务成功后的回调函数。
 @param failureListener
    取消离线任务失败后的回调函数。
 */
-(void)cancelCloudDownloadTaskWithId:(NSString *)taskId
                      resultListener:(FrontiaPersonalCloudDownloadCancelCallback)resultListener
                     failureListener:(FrontiaPersonalFailureCallback)failureListener;

/*!
 @method listRecycle
 @abstract 遍历回收站中文件。
 @param resultListener
    遍历回收站成功后的回调函数。
 @param failureListener
    遍历回收站失败后的回调函数。
 */
-(void)listRecycle:(FrontiaPersonalRecycleListCallback)resultListener
   failureListener:(FrontiaPersonalFailureCallback)failureListener;

/*!
 @method listRecycle
 @abstract 遍历回收站中文件。
 @param from
    遍历起始文件index。
 @param limit
    遍历返回文件总数限制。
 @param resultListener
    遍历回收站成功后的回调函数。
 @param failureListener
    遍历回收站失败后的回调函数。
 */
-(void)listRecycle:(int)from
             limit:(int)limit
    resultListener:(FrontiaPersonalRecycleListCallback)resultListener
   failureListener:(FrontiaPersonalFailureCallback)failureListener;

/*!
 @method restoreRecycleWithFileId
 @abstract 还原回收站中文件。
 @param fileId
    要还原文件ID。
 @param resultListener
    还原文件成功后的回调函数。
 @param failureListener
    还原文件失败后的回调函数。
 */
-(void)restoreRecycleWithFileId:(NSString*)fileId
                 resultListener:(FrontiaPersonalRecycleRestoreCallback)resultListener
                failureListener:(FrontiaPersonalFailureCallback)failureListener;

/*!
 @method restoreRecycleWithFileId
 @abstract 还原回收站中一系列文件。
 @param fileIds
    要还原文件ID数组。
 @param resultListener
    还原文件成功后的回调函数。
 @param failureListener
    还原文件失败后的回调函数。
 */
-(void)restoreRecycleWithFileIds:(NSArray*)fileIds
                  resultListener:(FrontiaPersonalRecycleRestoreCallback)resultListener
                 failureListener:(FrontiaPersonalRecycleRestoreFailureCallback)failureListener;


/*!
 @method cleanRecycle
 @abstract 清空回收站中所有文件。
 @param resultListener
    清空回收站成功后的回调函数。
 @param failureListener
    清空回收站失败后的回调函数。
 */
-(void)cleanRecycle:(FrontiaPersonalRecycleCleanCallback)resultListener
    failureListener:(FrontiaPersonalFailureCallback)failureListener;
@end