//
//  UIAlertController+MCExtension.h
//
//  Created by maocheng on 2017/6/12.
//  Copyright © 2017年 All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^MCAlertWithBtnBlock)(NSInteger index);
typedef void (^MCActionWithBtnBlock)(NSInteger index);
typedef void (^MCAlertWithTextBlock)(NSInteger index,NSString *text);

@interface UIAlertController (MCExtension)<UIAlertViewDelegate>

/**
 标题+信息+确认按钮
 
 @param title 标题
 @param message 显示信息
 */
+ (UIAlertController *)MC_alertWithOKButtonWithTitle:(NSString *)title message:(NSString *)message;

/**
 标题+信息+确认按钮+回调
 
 @param title 标题
 @param message 显示信息
 */
+ (UIAlertController *)MC_alertWithOKButtonWithTitle:(NSString *)title message:(NSString *)message buttonTitle:(NSString *)buttonTitle handle:(void(^)(UIAlertAction *action))handleBlock;

/** 标题+信息+确认+取消按钮 */
+ (UIAlertController *)MC_alertWithOKCancelBtnWithTitle:(NSString *)title message:(NSString *)message clickBtnAtIndex:(MCAlertWithBtnBlock)block;

/** 标题+信息+确认+取消按钮+取消block */
+ (void)MC_alertWithOKCancelBtnWithTitle:(NSString *)title message:(NSString *)message clickBtnAtIndex:(MCAlertWithBtnBlock)block cancel:(void(^)(void))cancelBlock;

+ (UIAlertController *)MC_alertWithTitle:(NSString *)title message:(NSString *)message btnTitles:(NSArray *)titles clickBtnAtIndex:(MCActionWithBtnBlock)block cancel:(void(^)(void))cancelBlock;

/** 标题+信息+确认+取消+文本框 */
+ (void)MC_alertWithtPlainText:(NSString *)title isSecure:(BOOL)isSecure message:(NSString *)message placeholder:(NSString *)placehoder keyBoardType:(UIKeyboardType)keyBoardType clickBtnAtIndex:(MCAlertWithTextBlock)block;
+ (void)MC_alertWithtPlainText:(NSString *)title message:(NSString *)message configureTextField:(void(^)(UITextField* textField))configureTextField clickBtnAtIndex:(MCAlertWithTextBlock)block;

/** 标题+信息+按钮A+...+按钮N */
+ (UIAlertController *)MC_alertWithTitle:(NSString *)title message:(NSString *)message btnTitles:(NSArray *)titles clickBtnAtIndex:(MCActionWithBtnBlock)block;

/** 列表：标题+信息+按钮A+...+按钮N */
+ (UIAlertController *)MC_actionSheetWithTitle:(NSString *)title message:(NSString *)message btnTitles:(NSArray *)titles clickBtnAtIndex:(MCActionWithBtnBlock)block;
+ (void)MC_ipad_actionSheetWithTitle:(NSString *)title message:(NSString *)message btnTitles:(NSArray *)titles sourceView:(UIView *)sourceView  clickBtnAtIndex:(MCActionWithBtnBlock)block;


@end
