//
//  UINavigationController+MCExtension.h
//
//  Created by maocheng on 2017/6/12.
//  Copyright © 2017年 All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (MCExtension)

/**
 导航条背景颜色和前景颜色

 @param foregroundColor 前景颜色
 @param backgroundColor 背景颜色
 */
- (void)MC_setBarForegroundColor:(UIColor *)foregroundColor backgroundColor:(UIColor *)backgroundColor;

@end
