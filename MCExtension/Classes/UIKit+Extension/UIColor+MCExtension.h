//
//  UIColor+MCExtension.h
//
//  Created by maocheng on 2017/6/12.
//  Copyright © 2017年 All rights reserved.
//

#import <UIKit/UIKit.h>

#define MC_RANDOM_COLOR [UIColor MC_randomColor]

@interface UIColor (MCExtension)

/**
 随机颜色
 */
+ (UIColor *)MC_randomColor;

/**
 十六进制颜色
 
 @param color 十六进制颜色码
 @return  UIColor
 */
+ (UIColor *)MC_colorWithHexString:(NSString *)color;

/**
 图片平铺
 
 @param name 图片名
 @return 平铺后的色块
 */
+ (UIColor *)MC_tilingWithImageName:(NSString *)name;

/**
 从十六进制字符串获取颜色，
 color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
 
 @param color  十六进制颜色码
 @param alpha 透明度
 @return  UIColor
 */
+ (UIColor *)MC_colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

/**
 *  @brief  根据颜色生成纯色图片
 *
 *  @param color 颜色
 *
 *  @return 纯色图片
 */
- (UIImage *)image;

@end
