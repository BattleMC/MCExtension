//
//  MCMacro.h
//
//  Created by maocheng on 2017/6/12.
//  Copyright © 2017年 All rights reserved.
//

#ifndef MCMacro_h
#define MCMacro_h

/*** 沙盒 ***/
#define MCHomePath        NSHomeDirectory()
#define MCTempPath        NSTemporaryDirectory()
#define MCDocumentPath    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

/*** 是否自动简繁体转换 */
//#define MC_AUTO_TOLOCAL

#define MCScale 1.5

/*** 日志 ***/
#ifdef DEBUG // 调试
#define MCLog(...) NSLog(@"%s 第%d行 %@",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else // 发布
#define MCLog(...)
#endif

/*** 颜色 ***/
#define MCRGBColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define MCHEXCOLOR(hexColor) [UIColor MC_colorWithHexString:hexColor]

/*** UserDefaults ***/
#define MCSetUserDefault(key,value) [[NSUserDefaults standardUserDefaults] setObject:(value) forKey:(key)]
#define MCGetUserDefault(key) [[NSUserDefaults standardUserDefaults] objectForKey:(key)]

/*** KeyedArchive ***/
#define MCCacheFilePath(name) [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.data",(name)]]
#define MCKeyedArchive(fileName,obj) [NSKeyedArchiver archiveRootObject:(obj) toFile:MCCacheFilePath(fileName)]
#define MCKeyedUnArchive(fileName) [NSKeyedUnarchiver unarchiveObjectWithFile:MCCacheFilePath(fileName)]
#define MCKeyedArchiveFileDelete(filename) {\
NSFileManager *defaultManager = [NSFileManager defaultManager];\
if ([defaultManager isDeletableFileAtPath:MCCacheFilePath(filename)]) {\
[defaultManager removeItemAtPath:MCCacheFilePath(filename) error:nil];\
}\
}

/*** Notification ***/
#define MCSendNotification(name,sendObject,info) [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:name object:sendObject userInfo:info]];

/*** 常用 ***/
#define MCScreenW [UIScreen mainScreen].bounds.size.width
#define MCScreenH [UIScreen mainScreen].bounds.size.height
#define MCScreenBounds [UIScreen mainScreen].bounds

// 状态栏高度
//#define KSTATUSBAR_HEIGHT (IS_IPHONE_X ? 30 : 20)

// TabBar高度
#define KTabBar_HEIGHT (IS_IPHONE_X ? 83 : 49)

// 顶部高度
#define KTOP_MARGIN (IS_IPHONE_X ? 88 : 64)

#define KNAV_HEIGHT self.navigationController.navigationBar.height
#define KSTATUSBAR_HEIGHT [UIApplication sharedApplication].statusBarFrame.size.height
#define KBottom_HEIGHT (IS_IPHONE_X ? 34 : 0)

#define MCLoadViewFromNib [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
#define MCLoadViewFromNibWithIndex(index) [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil][index];

#define MCDeprecated(instead) __attribute__((deprecated(instead)))

#define MCNonnullString(str) ((str && [str isKindOfClass:[NSString class]] && str.length) ? str : @"")
#define MCNullableString(str) ((str && [str isKindOfClass:[NSString class]] && str.length) ? str : nil)

// 当前版本
#define MC_SYSTEM_VERSION          ([[[UIDevice currentDevice] systemVersion] floatValue])
#define MC_APP_NAME                ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"])
#define MC_APP_VERSION             ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"])
#define MC_APP_BUILD               ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"])
#define MC_APP_BUNDLE_ID           ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"])

/*** 错误 ***/
#define MCDomain MC_APP_BUNDLE_ID

#define MCError(errorMessage) [NSError errorWithDomain:MCDomain code:-1 userInfo:@{NSLocalizedDescriptionKey:errorMessage}]

#define MCError_(errorMessage,errorCode) [NSError errorWithDomain:MCDomain code:errorCode userInfo:@{NSLocalizedDescriptionKey:errorMessage}]

// 当前语言
#define MCCURRENTLANGUAGE         ([[NSLocale preferredLanguages] objectAtIndex:0])

// 是否高于IOS X
#define MC_isHigherIOS(version)    [[[UIDevice currentDevice]systemVersion]floatValue] > version

// 是否iPad
#define isPad                   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

// 手机型号
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

#define IS_IPHONE_X [UIDevice isIPhoneXSeries]

// x & xs
#define MC_ISiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define MC_ISPhoneXr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)

#define MC_ISPhoneXsMax ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)

//#define MC_ISiPhoneX_Series (IsiPhoneX || IsiPhoneXr || IsiPhoneXsMax)



#endif /* MCMarco_h */
