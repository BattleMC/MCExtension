//
//  UINavigationController+MCExtension.h
//
//  Created by maocheng on 2017/6/12.
//  Copyright © 2017年 All rights reserved.
//

#import "UINavigationController+MCExtension.h"

@implementation UINavigationController (MCExtension)

- (void)MC_setBarForegroundColor:(UIColor *)foregroundColor backgroundColor:(UIColor *)backgroundColor
{
    // 导航条背景颜色
    self.navigationBar.barTintColor = backgroundColor;
    self.navigationBar.backgroundColor = backgroundColor;
    // 导航条title颜色
    NSMutableDictionary *barTitleDic = [NSMutableDictionary dictionary];
    barTitleDic[NSForegroundColorAttributeName] = foregroundColor;
    [[UINavigationBar appearance] setTitleTextAttributes:barTitleDic];
}

@end
