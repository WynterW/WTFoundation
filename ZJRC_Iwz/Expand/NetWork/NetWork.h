//
//  NetWork.h
//  ZJRC_Iwz
//
//  Created by Wynter on 15/11/20.
//  Copyright © 2015年 Wynter. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AFHTTPRequestOperation;

/**
 *  定义请求成功的block
 */
typedef void(^successBlock)(id responseBody);
/**
 *  定义请求失败的block
 */
typedef void(^failureBlock)(NSError *error);


@interface NetWork : NSObject

/**
 *  是否有网络
 */
@property (nonatomic,assign) BOOL networkError;

singleton_interface(NetWork)

/**
 *   监听网络状态的变化
 */
+ (void)startMonitoring;

#pragma mark - HTTP Request Operation Manager
/**
 *  发送get请求
 *
 *  @param url     网络请求的URL
 *  @param params  传一个字典
 *  @parma showHUD 是否开始加载圈圈
 *  @param success 请求成功的block
 *  @param failure 请求失败的block
 */
+(void)sendGetUrl:(NSString *)url withParams:(NSDictionary *)params showHUD:(BOOL)showHUD success:(successBlock)success failure:(failureBlock)failure;

/**
 *  发送get请求
 *
 *  @param url     网络请求的URL 这里的URL转码方式跟上面的不一样注意一下（也就是编码和解码）
 *  @param params  传一个字典
 *  @parma showHUD 是否开始加载圈圈
 *  @param success 请求成功的block
 *  @param failure 请求失败的block
 */
+(void)sendGetByReplacingUrl:(NSString *)url withParams:(NSDictionary *)params showHUD:(BOOL)showHUD success:(successBlock)success failure:(failureBlock)failure;

/**
 *  发送Post请求
 *
 *  @param url     网络请求的URL
 *  @param params  传一个字典
 *  @parma showHUD 是否开始加载圈圈
 *  @param success 请求成功的block
 *  @param failure 请求失败的block
 */
+(void)sendPostFormEncodedRequestUrl:(NSString *)url withParams:(NSDictionary *)params showHUD:(BOOL)showHUD success:(successBlock)success failure:(failureBlock)failure;


/**
 *  发送Post上传请求
 *
 *  @param url     网络请求的URL
 *  @param params  传一个字典
 *  @param afilePath  文件路径
 *  @param fileName  文件名称
 *  @parma showHUD 是否开始加载圈圈
 *  @param success 请求成功的block
 *  @param failure 请求失败的block
 */
+(void)sendPostMultiPartRequestUrl:(NSString *)url withParams:(NSDictionary *)params filePath:(NSString *)afilePath fileName:(NSString*)filename showHUD:(BOOL)showHUD success:(successBlock)success failure:(failureBlock)failure;

/**
 *  @brief  下载文件 进度监听
 *
 *  @param paramDic   附加post参数
 *  @param requestURL 请求地址
 *  @param savedPath  保存 在磁盘的位置
 *  @param success    下载成功回调
 *  @param failure    下载失败回调
 *  @param progress   实时下载进度回调
 */
+ (void)downloadFileWithOption:(NSDictionary *)paramDic withInferface:(NSString*)requestURL savedPath:(NSString*)savedPath downloadSuccess:(successBlock)success downloadFailure:(failureBlock)failure progress:(void (^)(float progress))progress;

#pragma mark - AFURLSessionManager
/**
 *  发送下载请求（SessionManager）
 *
 *  @param url     网络请求的URL
 *  @param savedPath  文件保存路径
 *  @parma showHUD 是否开始加载圈圈
 *  @param success 请求成功的block
 *  @param failure 请求失败的block
 */
+(void)sendDownloadTaskUrl:(NSString *)url withSavedPath:(NSString *)savedPath showHUD:(BOOL)showHUD success:(successBlock)success failure:(failureBlock)failure;

/**
 *  发送上传请求（SessionManager）
 *
 *  @param url     网络请求的URL
 *  @param afilePath  文件路径
 *  @parma showHUD 是否开始加载圈圈
 *  @param success 请求成功的block
 *  @param failure 请求失败的block
 */
+(void)sendUploadTaskUrl:(NSString *)url filePath:(NSString *)afilePath showHUD:(BOOL)showHUD success:(successBlock)success failure:(failureBlock)failure;

/**
 *  发送数据上传请求（SessionManager）
 *
 *  @param url     网络请求的URL
 *  @parma showHUD 是否开始加载圈圈
 *  @param success 请求成功的block
 *  @param failure 请求失败的block
 */
+(void)sendDataTaskUrl:(NSString *)url showHUD:(BOOL)showHUD success:(successBlock)success failure:(failureBlock)failure;


/**
 *  是否有网络
 *
 *  @return YES则有网络，NO则无网络
 */
- (BOOL)isNetworkState;



@end
