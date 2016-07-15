# iOS的基础框架

##目录说明

1. Main：目录下面的文件对应的是app的具体单元，首页、个人中心、登陆、注册、等等
    * Expand：扩展目录
     
    * BasicVC：公用的ViewController、TableViewController、NavitationController等

    * NetWork：存放网络层代码

    * CustomView：该目录存放项目自定义的文件,如自定义控件，扩展类。

    * Category：该目录存放项目自定义的扩展类文件
    
    * Config：该目录存放项目配置文件
  
    * CommonTool：工具文件类，存放工具类，比如数据正则匹配等

    * Macro：放了整个应用会用到的宏定义

* AppDelegate  ：这个目录下放的是AppDelegate.h(.m)文件，是整个应用的入口文件，所以单独拿出来。
*  Utils：存放[第三方库](#第三方库)
* Resources：放的是app会用到的一些资源，主要是图片和Storyboard文件资源
    * Document：放文档文件，例如pdf文件，txt文件等
    * Musics 
* Other Sources：放系统自带plist、启动图片、pch、main文件等

##第三方库：
   - IQKeyBoardManager
   - JSONKit
   - Masonry
   - MBProgressHUD
   - MJExtension
   - MJRefresh
   - Netwroking
   - NJKWebViewProgress
   - SDWebImage
   
##宏定义：
   - APIStringMacros.h
   - ColorMacros.h
   - DataHandleMacros.h
   - DimensMacros.h
   - macros.h
   - NotificationMacros.h
   - PathMacros.h
   - SingletonPatternMacros.h
   - UtilsMacros.h
   
##Category：
   - NSDate
   - NSString
   - UIButton
   
##基础视图：
   - BasicNavigationController
   - BasicTableViewcontollerCell
   - BasicTableViewController
   - BasicViewContoller
   - BasicWebViewController
   - ROOTBasicViwController
