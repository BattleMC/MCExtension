//
//  UIBarButtonItem+MCExtension.h
//
//  Created by maocheng on 2017/6/12.
//  Copyright © 2017年 All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MCBtnClickedBlock)(UIButton *button);
typedef void(^MCBtnImgClickedBlock)(UIButton *button,UIImageView *imageView);

@interface UIBarButtonItem (MCExtension)

/**
 拥有尺寸为20，20的图片的按钮
 
 @param image 图片
 @param block 点击回调
 @return UIBarButtonItem
 */
+ (instancetype)MC_itemForButtonWithImage:(UIImage *)image actionBlock:(MCBtnClickedBlock)block;

/**
 拥有字号为17的按钮

 @param title 标题
 @param titleColor 标题颜色
 @param block 回调
 @return UIBarButtonItem
 */
+ (instancetype)MC_itemForButtonWithTitle:(NSString *)title color:(UIColor *)titleColor actionBlock:(MCBtnClickedBlock)block;

+ (instancetype)MC_itemForButtonWithTitle:(NSString *)title fontSize:(CGFloat)fontSize color:(UIColor *)titleColor actionBlock:(MCBtnClickedBlock)block;

+ (instancetype)MC_itemForButtonWithTitle:(NSString *)title fontSize:(CGFloat)fontSize color:(UIColor *)titleColor buttonWidth:(CGFloat)buttonWidth actionBlock:(MCBtnClickedBlock)block;

+ (instancetype)MC_itemForButtonWithTitle:(NSString *)title image:(UIImage *)image fontSize:(CGFloat)fontSize color:(UIColor *)titleColor actionBlock:(MCBtnImgClickedBlock)block;

@end
