//
//  UILabel+MCExtension.h
//
//  Created by maocheng on 2017/6/12.
//  Copyright © 2017年 All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (MCExtension)

- (UILabel *(^)(CGFloat x))MC_x;
- (UILabel *(^)(CGFloat y))MC_y;
- (UILabel *(^)(CGFloat maxX))MC_MaxX;
- (UILabel *(^)(CGFloat maxY))MC_MaxY;
- (UILabel *(^)(CGFloat width))MC_width;
- (UILabel *(^)(CGFloat height))MC_height;
- (UILabel *(^)(UIColor *backgroundColor))MC_backgroundColor;
- (UILabel *(^)(CGRect frame))MC_frame;
- (UILabel * (^)(CGFloat centerX))MC_centerX;
- (UILabel * (^)(CGFloat centerY))MC_centerY;
- (UILabel * (^)(CGFloat radius))MC_raduis;
- (UILabel * (^)(UIColor *borderColor))MC_borderColor;

- (UILabel *(^)(UIColor *textColor))MC_textColor;
- (UILabel *(^)(NSString *text))MC_text;
- (UILabel *(^)(NSInteger fontSize,UIFontWeight weight))MC_font;
- (UILabel *(^)(NSInteger fontSize))MC_fontSize;
- (UILabel *)MC_unlimitedLine;

- (void)setColor:(UIColor *)color fontSize:(NSInteger)fontSize weight:(UIFontWeight)weight;

- (void)setColor:(UIColor *)color fontSize:(NSInteger)fontSize;

- (void)setText:(NSString *)text withLineSpacing:(NSInteger)lineSpacing color:(UIColor *)color fontSize:(NSInteger)fontSize;

//- (void)highlightKeyword:(NSString *)keyword originString:(NSString *)originString color:(UIColor *)color;

@end
