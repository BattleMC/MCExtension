//
//  UIImage+MCExtension.h
//
//  Created by maocheng on 2017/6/12.
//  Copyright © 2017年 All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (DKExtension)

/**
 根据View绘制image
 
 @param view view
 @return image
 */
+ (UIImage *)MC_makeImageWithView:(UIView *)view;

/**
 改变图片尺寸（给定宽度，高度按比例计算）

 @param sourceImage 原图
 @param targetWidth 目标图片宽度
 @return 压缩后的图片
 */
+ (UIImage *)MC_compressImage:(UIImage *)sourceImage toTargetWidth:(CGFloat)targetWidth;

/**
 创建一个内容可拉伸，而边角不拉伸的图片
 
 @param imageName 图片名
 @return 图片
 */
+ (instancetype)MC_imageWithStretchableName:(NSString *)imageName;

/**
 *  把图片裁剪成带有圆环的圆形图片
 *
 *  @param image       原图片
 *  @param borderWidth 圆环的宽度
 *  @param borderColor 圆环的颜色
 *
 *  @return 带有圆环的圆形图片
 */
+ (instancetype)MC_imageWithClipImage:(UIImage *)image borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/**
 保存图片至沙盒

 @param image 图片
 @param imageName 图片名
 @return 路径
 */
+ (NSString *)MC_saveImage:(UIImage *)image withName:(NSString *)imageName;

/**
 UIImage 转 Base64

 @return base64 string
 */
- (NSString *)MC_base64;

/**
 图片压缩
 体积压缩至默认系数0.8，宽高按照原比例压缩到屏幕的宽度
 @return 压缩后的图片
 */
- (UIImage *)MC_compress;

/**
 图片压缩
 指定宽度压缩，压缩系数默认0.8
 @param width 压缩后的宽度
 @return 压缩后的图片
 */
- (UIImage *)MC_compressWithWidth:(CGFloat)width;

/**
 图片压缩
 指定系数压缩，宽度默认为屏幕宽度
 @param coefficient 压缩系数
 @return 压缩后的图片
 */
- (UIImage *)MC_compressWithCoefficient:(CGFloat)coefficient;

/**
 图片压缩
 指定宽度和系数压缩
 @param width 压缩后的宽度
 @param coefficient 压缩系数
 @return 压缩后的图片
 */
- (UIImage *)MC_compressWithWidth:(CGFloat)width coefficient:(CGFloat)coefficient;


//Avilable in iOS 7.0 and later
+ (UIImage *)qrCodeImageWithContent:(NSString *)content
                      codeImageSize:(CGFloat)size
                               logo:(UIImage *)logo
                          logoFrame:(CGRect)logoFrame
                                red:(CGFloat)red
                              green:(CGFloat)green
                               blue:(NSInteger)blue;
+ (UIImage *)qrCodeImageWithContent:(NSString *)content codeImageSize:(CGFloat)size;

//Avilable in iOS 8.0 and later
+ (UIImage *)barcodeImageWithContent:(NSString *)content
                       codeImageSize:(CGSize)size
                                 red:(CGFloat)red
                               green:(CGFloat)green
                                blue:(NSInteger)blue;
+ (UIImage *)barcodeImageWithContent:(NSString *)content codeImageSize:(CGSize)size;

+ (UIImage *)MC_compressImage:(UIImage *)sourceImage toTargetHeight:(CGFloat)targetHeight;

- (UIImage*)MC_ChangeToGrayStyle;

/**
 压缩图片到指定大小
 */
- (UIImage *)MC_compressImageToByte:(NSUInteger)maxLength;

+ (UIImage *)MC_imageWithColor:(UIColor *)color size:(CGSize)size;
+ (UIImage *)MC_verticalImageFromArray:(NSArray *)imagesArray;

@end
