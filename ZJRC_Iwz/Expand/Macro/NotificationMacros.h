//
//  NotificationMacros.h
//  ZJRC_Iwz
//
//  Created by Wynter on 15/11/19.
//  Copyright © 2015年 Wynter. All rights reserved.
//  系统Notification定义

#ifndef NotificationMacros_h
#define NotificationMacros_h


#define _ADDOBSERVER(TITLE, SELECTOR) [[NSNotificationCenter defaultCenter] addObserver:self selector:SELECTOR name:TITLE object:nil]//添加通知

#define _REMOVEOBSERVER(id) [[NSNotificationCenter defaultCenter] removeObserver:id]//销毁通知

#define _POSTNOTIFY(TITLE,OBJ,PARAM) [[NSNotificationCenter defaultCenter] postNotificationName:TITLE object:OBJ userInfo:PARAM]//发送通知

#define kNotficationDownloadProgressChanged @"kNotficationDownloadProgressChanged"//下载进度变化
#define kNotificationPauseDownload          @"kNotificationPauseDownload"         //暂停下载
#define kNotificationStartDownload          @"kNotificationStartDownload"         //开始下载

#define kNotificationDownloadSuccess        @"kNotificationDownloadSuccess"       //下载成功
#define kNotificationDownloadFailed         @"kNotificationDownloadFailed"        //下载失败
#define kNotificationDownloadNewMagazine    @"kNotificationDownloadNewMagazine"

#endif /* NotificationMacros_h */
