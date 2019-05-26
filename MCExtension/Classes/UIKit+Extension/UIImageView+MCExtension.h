//
//  UIImageView+MCExtension.h
//
//  Created by maocheng on 2017/6/12.
//  Copyright © 2017年 All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (MCExtension)

- (UIImageView *(^)(CGFloat x))MC_x;
- (UIImageView *(^)(CGFloat y))MC_y;
- (UIImageView * (^)(CGFloat maxX))MC_MaxX;
- (UIImageView * (^)(CGFloat maxY))MC_MaxY;
- (UIImageView *(^)(CGFloat width))MC_width;
- (UIImageView *(^)(CGFloat height))MC_height;
- (UIImageView *(^)(UIColor *backgroundColor))MC_backgroundColor;
- (UIImageView *(^)(CGRect frame))MC_frame;
- (UIImageView * (^)(CGFloat centerX))MC_centerX;
- (UIImageView * (^)(CGFloat centerY))MC_centerY;
- (UIImageView * (^)(CGFloat radius))MC_raduis;
- (UIImageView * (^)(UIColor *borderColor))MC_borderColor;

- (UIImageView *(^)(NSString *imageName))MC_imageNamed;
- (UIImageView * (^)(UIViewContentMode mode))MC_mode;

@end

NS_ASSUME_NONNULL_END
