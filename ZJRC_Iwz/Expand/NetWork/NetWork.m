//
//  NetWork.m
//  ZJRC_Iwz
//
//  Created by Wynter on 15/11/20.
//  Copyright © 2015年 Wynter. All rights reserved.
//

#import "NetWork.h"

@implementation NetWork

singleton_implementation(NetWork);


#pragma mark - HTTP Request Operation Manager

+(void)sendGetUrl:(NSString *)url withParams:(NSDictionary *)params showHUD:(BOOL)showHUD success:(successBlock)success failure:(failureBlock)failure
{
    if (![[NetWork sharedNetWork] isNetworkState])
    {
        return;
    }
    if (showHUD == YES)
    {
        [MBProgressHUD showHUD];
    }

    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manger = [self getRequstManager];
    [manger GET:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         [MBProgressHUD dissmiss];
         success(responseObject);
     }   failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         [MBProgressHUD dissmiss];
         failure(error);
     }];
    
}

+(void)sendGetByReplacingUrl:(NSString *)url withParams:(NSDictionary *)params showHUD:(BOOL)showHUD success:(successBlock)success failure:(failureBlock)failure
{

    if (![[NetWork sharedNetWork] isNetworkState])
    {
        return;
    }
    if (showHUD == YES)
    {
        [MBProgressHUD showHUD];
    }
    
    NSString *urlStr = [url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manger = [self getRequstManager];
    [manger GET:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         [MBProgressHUD dissmiss];
         success(responseObject);
     }   failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         [MBProgressHUD dissmiss];
         failure(error);
     }];
    
    
}

+(void)sendPostFormEncodedRequestUrl:(NSString *)url withParams:(NSDictionary *)params showHUD:(BOOL)showHUD success:(successBlock)success failure:(failureBlock)failure
{
    if (![[NetWork sharedNetWork] isNetworkState])
    {
        return;
    }
    if (showHUD == YES)
    {
        [MBProgressHUD showHUD];
    }

    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [self getRequstManager];
    [manager POST:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD dissmiss];
        success(responseObject);
        DLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD dissmiss];
        failure(error);
        DLog(@"Error: %@", error);
    }];

}

+(void)sendPostMultiPartRequestUrl:(NSString *)url withParams:(NSDictionary *)params filePath:(NSString *)afilePath fileName:(NSString*)filename showHUD:(BOOL)showHUD success:(successBlock)success failure:(failureBlock)failure
{
    if (![[NetWork sharedNetWork] isNetworkState])
    {
        return;
    }
    if (showHUD == YES)
    {
        [MBProgressHUD showHUD];
    }
    
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [self getRequstManager];
    NSURL *filePath = [NSURL fileURLWithPath:afilePath];
    [manager POST:urlStr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileURL:filePath name:filename error:nil];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD dissmiss];
        success(responseObject);
        DLog(@"Success: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD dissmiss];
        failure(error);
        DLog(@"Error: %@", error);
    }];
}


#pragma mark -下载文件 监听下载进度
+ (void)downloadFileWithOption:(NSDictionary *)paramDic withInferface:(NSString*)requestURL savedPath:(NSString*)savedPath downloadSuccess:(successBlock)success downloadFailure:(failureBlock)failure progress:(void (^)(float progress))progress
{
    if (![[NetWork sharedNetWork] isNetworkState])
    {
        return;
    }
    //沙盒路径    //NSString *savedPath = [NSHomeDirectory() stringByAppendingString:@"/Documents/xxx.zip"];
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    NSMutableURLRequest *request =[serializer requestWithMethod:@"POST" URLString:requestURL parameters:paramDic error:nil];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setOutputStream:[NSOutputStream outputStreamToFileAtPath:savedPath append:NO]];
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        float p = (float)totalBytesRead / totalBytesExpectedToRead;
        progress(p);
        DLog(@"download：%f", (float)totalBytesRead / totalBytesExpectedToRead);
        
    }];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
        DLog(@"下载成功");
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
        
        DLog(@"下载失败");
        
    }];
    
    [operation start];
    
}



#pragma mark - AFURLSessionManager
+(void)sendDownloadTaskUrl:(NSString *)url withSavedPath:(NSString *)savedPath showHUD:(BOOL)showHUD success:(successBlock)success failure:(failureBlock)failure{
    
    if (![[NetWork sharedNetWork] isNetworkState])
    {
        return;
    }
    if (showHUD == YES)
    {
        [MBProgressHUD showHUD];
    }
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        [MBProgressHUD dissmiss];
        if (error)
        {
            failure(error);
            DLog(@"下载失败");
        }
        else
        {
            success(filePath);
        }
        
        DLog(@"File downloaded to: %@", filePath);
    }];
    [downloadTask resume];
}

+(void)sendUploadTaskUrl:(NSString *)url filePath:(NSString *)afilePath showHUD:(BOOL)showHUD success:(successBlock)success failure:(failureBlock)failure{
    
    if (![[NetWork sharedNetWork] isNetworkState])
    {
        return;
    }
    if (showHUD == YES)
    {
        [MBProgressHUD showHUD];
    }
    
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURL *filePath = [NSURL fileURLWithPath:afilePath];
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithRequest:request fromFile:filePath progress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        [MBProgressHUD dissmiss];
        if (error) {
            DLog(@"Error: %@", error);
            failure(error);
            DLog(@"上传失败");
        } else {
            success(responseObject);
            DLog(@"Success: %@ %@", response, responseObject);
        }
        
    }];
    [uploadTask resume];
}


+(void)sendDataTaskUrl:(NSString *)url showHUD:(BOOL)showHUD success:(successBlock)success failure:(failureBlock)failure{

    if (![[NetWork sharedNetWork] isNetworkState])
    {
        return;
    }
    if (showHUD == YES)
    {
        [MBProgressHUD showHUD];
    }
    
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        [MBProgressHUD dissmiss];
        if (error) {
            failure(error);
            DLog(@"Error: %@", error);
        } else {
            success(responseObject);
            DLog(@"%@ %@", response, responseObject);
        }
    }];
    [dataTask resume];

}

#pragma makr - 开始监听网络连接

+ (void)startMonitoring
{
    // 1.获得网络监控的管理者
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    // 2.设置网络状态改变后的处理
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
                DLog(@"未知网络");
                break;
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                [NetWork sharedNetWork].networkError = YES;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                DLog(@"手机自带网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                DLog(@"WIFI");
                break;
        }
    }];
    [mgr startMonitoring];
}

+ (AFHTTPRequestOperationManager *)getRequstManager {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 请求超时设定
    manager.requestSerializer.timeoutInterval = 20;
    
    return manager;
}

- (BOOL)isNetworkState{
    
    if (self.networkError == YES) {
        SHOW_ALERT(@"网络连接断开,请检查网络!");
        return NO;
    }
    return YES;
}

@end
