//
//  UIView+MCExtension.h
//
//  Created by maocheng on 2017/6/12.
//  Copyright © 2017年 All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCMacro.h"
#import "UIDevice+MCExtension.h"

static inline UIEdgeInsets MC_safeAreaInset(UIView *view) {
    if (@available(iOS 11.0, *)) {
        return view.safeAreaInsets;
    }
    return UIEdgeInsetsMake(KTOP_MARGIN, 0, 0, KBottom_HEIGHT);
}

@interface UIView (MCExtension)

#pragma mark - frame extension

@property (nonatomic,assign) CGFloat centerX;
@property (nonatomic,assign) CGFloat centerY;
@property (nonatomic,assign) CGSize size;
@property (nonatomic,assign) CGFloat x;
@property (nonatomic,assign) CGFloat y;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;
- (CGFloat) maxX;
- (CGFloat) minX;
- (CGFloat) maxY;
- (CGFloat) minY;

#pragma mark -chain
+ (instancetype)instance;
- (UIView * (^)(CGFloat x))MC_x;
- (UIView * (^)(CGFloat maxX))MC_MaxX;
- (UIView * (^)(CGFloat centerX))MC_centerX;
- (UIView * (^)(CGFloat y))MC_y;
- (UIView * (^)(CGFloat maxY))MC_MaxY;
- (UIView * (^)(CGFloat centerY))MC_centerY;
- (UIView * (^)(CGFloat width))MC_width;
- (UIView * (^)(CGFloat height))MC_height;
- (UIView * (^)(UIColor *backgroundColor))MC_backgroundColor;
- (UIView * (^)(CGRect frame))MC_frame;
- (UIView * (^)(CGFloat radius))MC_raduis;
- (UIView * (^)(UIColor *borderColor))MC_borderColor;

- (instancetype)MC_clipToBounds;
- (instancetype)MC_sizeToFit;
- (instancetype(^)(UIView *superView))MC_addTo;

#pragma mark - 添加xib配置属性
/** 边框颜色 */
@property (nonatomic, strong) IBInspectable UIColor *BorderColor;
/** 边框宽度 */
@property (nonatomic, assign) IBInspectable CGFloat BorderWidth;
/** 圆角半径 */
@property (nonatomic, assign) IBInspectable CGFloat CornerRadius;
/** 完全圆角 - 高度与屏幕高度的比例 */
@property (nonatomic, assign) IBInspectable CGFloat RadiusScopeH;
/** 完全圆角 正方形时，宽度与屏幕宽度的比例 */
@property (nonatomic, assign) IBInspectable CGFloat RadiusScopeW;

/**
 深复制 View
 
 @return 新的 View
 */
- (UIView *)MC_duplicate;

/**
 设置圆角
 
 @param cornerRadius 圆角值
 */
- (void)MC_setCornerRadius:(CGFloat)cornerRadius;

/**
 给View添加阴影
 */
- (void)MC_addShadowToView;
- (void)MC_addShadowToViewWithColor:(UIColor *)color offset:(CGSize)offset;
- (void)MC_addShadowToViewWithColor:(UIColor *)color offset:(CGSize)offset size:(CGFloat)size;

/**
 添加毛玻璃效果
 
 @param effcet 添加的样式
 */
- (void)MC_addBlurEffectStyle:(UIBlurEffectStyle)effcet;

/**
 添加圆角边框
 
 @param cornerRadius 圆角角度
 @param width 边框宽度
 @param color 边框颜色
 */
- (void)MC_addCorner:(CGFloat)cornerRadius borderWidth:(CGFloat)width borderColor:(UIColor *)color;

/**
 判断两个View是否有交集
 
 @param view 另一个 view
 @return YES/NO
 */
- (BOOL)MC_intersectWithView:(UIView *)view;

/**
 截屏
 
 @param afterUpdates 视图加载完成后截图
 @return 截屏 View
 */
- (UIView *)MC_snapshotViewAfterScreenUpdates:(BOOL)afterUpdates;

/**
 添加一个tap手势并处理回调
 
 @param tapCallback 回调
 */
- (void)MC_tapOnView:(void(^)(UITapGestureRecognizer *tap))tapCallback;

/**
 添加一个longPress手势并处理回调

 @param second 长按最短秒数
 @param pressCallback 长按回调
 */
- (void)MC_longPressBySecond:(NSInteger)second onView:(void(^)(UILongPressGestureRecognizer *longPress))pressCallback;

/**
 获取同名的reuse ID
 
 @return reuse ID
 */
+ (NSString *)defaultIdentifier;

/**
 获取同名的nib
 
 @return nib
 */
+ (UINib *)defaultNib;

/**
 添加渐变

 @param beginColor 起始颜色
 @param endColor 结束颜色
 @param cornerRadius 圆角半径
 */
- (void)MC_addGradientLayerWithBeginColor:(UIColor *)beginColor endColor:(UIColor *)endColor cornerRadius:(CGFloat)cornerRadius;


- (UIImage *)MC_screenshot;

- (UIImage *)MC_screenshotForCroppingRect:(CGRect)croppingRect;

@end
