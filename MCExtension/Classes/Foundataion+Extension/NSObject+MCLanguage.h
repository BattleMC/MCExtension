//
//  NSObject+MCLanguage.h
//
//  Created by maocheng on 2017/6/12.
//  Copyright © 2017年 All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//#define VERSION (@"1.0.0") ///< 代码版本号

@interface NSObject (MCLanguage)

/** 转化为繁体 */
- (id)toTran;

/** 转化为简体 */
- (id)toSimp;

/** 转化为本地语言 */
- (id)toLocal;

/** 转化为繁体与否 */
- (id)convertToTran:(NSNumber *)isTran;

/** 当前语言是否繁体 */
- (BOOL)isTran;

/** 当前语言是否简体 */
- (BOOL)isSimp;

@end

@interface NSString (MCLanguage)
@end

@interface UIView (MCLanguage)
@end

@interface UILabel (MCLanguage)
@end

@interface UITextField (MCLanguage)
@end

@interface UITextView (MCLanguage)
@end

@interface UIButton (MCLanguage)
@end

@interface UISegmentedControl (MCLanguage)
@end

@interface UIToolbar (MCLanguage)
@end

@interface UITabBar (MCLanguage)
@end

@interface UINavigationBar (MCLanguage)
@end

@interface UINavigationItem (MCLanguage)
@end

@interface UITableView (MCLanguage)

/** 转化为繁体 */
- (void)reloadDataToTran;

/** 转化为简体 */
- (void)reloadDataToSimp;

/** 转化为本地语言 */
- (void)reloadDataToLocal;

//在reloadData后将Cell转化为正确语言
- (void)reloadDataToTran:(NSNumber *)isTran;
@end

@interface UITableViewCell (MCLanguage)
@end

@interface UIViewController (MCLanguage)
@end

@interface NSArray (MCLanguage)
@end

@interface NSDictionary (MCLanguage)
@end

@interface UIAlertView (MCLanguage)
@end

/**
 ***********************************
 * 2018-10-17修正：
 * 删除 UIViewController (MCLanguage)分类中的以下方法的隐式自动转换
 // 开始国际化,繁简自动切换
 + (void)ccTranSimpLocalization;
 // 取消国际化,繁简不自动切换
 + (void)ccUnTranSimpLocalization;

 ***********************************
 * 2014-09-05修正：
 * 简体环境下为“简体”
 * 其他语言环境下都为“繁体”
 ***********************************
 * 2014-02-17修正:
 * 1.引入新的字库,
 * 2.添加的繁简文字: "冲" = "沖"; "决" = "決"; "历" = "曆"; "采" = "採"; "强" = "強"; ""么" = "麼";"肮" = "骯"; "伙" = "夥"; "迹" = "跡"; "侥" = "僥"; "仆" = "僕";"喂" = "餵";"冢" = "塚";"谑" = "謔";"猬" = "蝟";"丬" = "爿";"滗" = "潷"; "璇" = "璿";"檐" = "簷";"牦" = "犛";"腌" = "醃";"腭" = "齶";"飚" = "飈";"沓" = "遝";"钜" = "鉅";"跖" = "蹠";
 * 3.删除的繁简文字: 丑, 污, 台, 咸, 斗, 雕, 翱, 迭, 杆, 皋 ,苟, 菇, 呵, 呼, 脊, 秸, 撅, 狸, 溜, 眯, 呐, 噼, 墒, 污, 凶, 岩, 彝, 游, 灶, 症, 志, 著, 睾, 鞀, 佘, 艹, 擀, 吒,唕, 噘, 嚯, 嵴, 徼, 怵, 屙, 槔, 槁, 犟, 睃, 麽
 * 4.更新: "复" = "複";"净" = "淨";"墙" = "牆";"刹" = "剎"; "陕" = "陝";"叹" = "嘆";"绦" = "絛";"锈" = "銹";"勋" = "勛";"艳" = "艷";"脏" = "髒";"钻" = "鑽";"绁" = "絏";"赍" = "賫";"锎" = "鐦";"镅" = "鎇";"虬" = "虯";"鲇" = "鮎";
 * 4.修正语言的本地化  1.麽(原)->麼(新);
 *          2.混的簡繁去掉
 *          3.確認 台灣 採用 臺灣
 ************************************
 ***********************************
 * 0718修正: 1.麽(原)->麼(新);
 *          2.混的簡繁去掉
 *          3.確認 台灣 採用 臺灣
 ************************************
 * 0719修正: 1.修改全部返回id型,解决提示重复方法名警告
 *          2.添加UITableView的支持,并加强reloadData方法
 ************************************
 * 0802修正: 1.删除 淡\升 污咸愣案糊愍渺彷霉等字符
 2.修正按钮的状态文字
 */
