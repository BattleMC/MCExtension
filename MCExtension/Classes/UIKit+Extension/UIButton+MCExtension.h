//
//  UIButton+MCExtension.h
//
//  Created by maocheng on 2017/6/12.
//  Copyright © 2017年 All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ButtonClickedBlock)(UIButton *button);

@interface UIButton (MCExtension)

- (UIButton *(^)(CGFloat x))MC_x;
- (UIButton *(^)(CGFloat y))MC_y;
- (UIButton * (^)(CGFloat maxX))MC_MaxX;
- (UIButton * (^)(CGFloat maxY))MC_MaxY;
- (UIButton *(^)(CGFloat width))MC_width;
- (UIButton *(^)(CGFloat height))MC_height;
- (UIButton *(^)(UIColor *backgroundColor))MC_backgroundColor;
- (UIButton *(^)(CGRect frame))MC_frame;
- (UIButton * (^)(CGFloat centerX))MC_centerX;
- (UIButton * (^)(CGFloat centerY))MC_centerY;
- (UIButton * (^)(CGFloat radius))MC_raduis;
- (UIButton * (^)(UIColor *borderColor))MC_borderColor;

- (UIButton *(^)(UIColor *titleColor))MC_titleColor;
- (UIButton *(^)(UIColor *titleColor,UIControlState state))MC_titleColorState;
- (UIButton *(^)(NSString *title,UIControlState state))MC_titleState;
- (UIButton *(^)(CGFloat titleFontSize))MC_titleFontSize;
- (UIButton *(^)(UIImage *image))MC_image;
- (UIButton *(^)(UIImage *image,UIControlState state))MC_imageState;
- (UIButton *(^)(UIEdgeInsets titleInset))MC_titleInset;
- (UIButton *(^)(NSString *title))MC_title;

/**
 UIButton 附加 Block 点击回调
 
 @param event 点击状态
 @param action 回调方法
 */
- (void)MC_handleControlEvent:(UIControlEvents)event withBlock:(ButtonClickedBlock)action;

/**
 点击直接调用路由
 */
- (void)MC_clickWithRouterName:(NSString *)routerName userInfo:(NSDictionary *)userInfo needBuired:(BOOL)needBuired;

/**
 点击事件的信号
 
 @return 信号
 */
#ifdef RAC
- (RACSignal *)clickSignal;
#endif

@end
