//
//  NSObject+MCExtension.h
//
//  Created by maocheng on 2017/6/12.
//  Copyright © 2017年 All rights reserved.
//

#import "NSObject+MCExtension.h"
#import <objc/runtime.h>
#import <UIKit/UIKit.h>

@implementation NSObject (MCExtension)

- (instancetype)MC_deepCopy
{
    return [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:self]];
}

+ (instancetype)MC_modelWithDict:(NSDictionary *)dict mapDict:(NSDictionary *)mapDict
{
    return [[self alloc] initWithDict:dict mapDict:mapDict];
}

#pragma clang diagnostic ignored "-Wobjc-designated-initializers"

- (instancetype)initWithDict:(NSDictionary *)dict mapDict:(NSDictionary *)mapDict
{
    // 记录属性个数
    unsigned int count = 0;
    // 获取模型的所有属性
    Ivar *ivars = class_copyIvarList([self class], &count);
    // 遍历模型中属性
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        // 获取属性名
        NSString *ivarName = @(ivar_getName(ivar));
        // 去掉下划线
        ivarName = [ivarName substringFromIndex:1];
        // 获取值
        id value = dict[ivarName];
        if (value == nil) {
            if (mapDict) {
                // 从映射字典中取出替代的key
                NSString *keyName = mapDict[ivarName];
                // 在原字典中用替代的key取出值
                value = dict[keyName];
            }
        }
        // 赋值
        [self setValue:value forKey:ivarName];
    }
    return self;
}

+ (instancetype)MC_modelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        NSString *ivarName = @(ivar_getName(ivar));
        ivarName = [ivarName substringFromIndex:1];
        id value = dict[ivarName];
        [self setValue:value forKey:ivarName];
    }
    return self;
}

- (void)MC_swizzleMethod:(SEL)origSelector withMethod:(SEL)newSelector
{
    Class class = [self class];
    
    Method originaMCethod = class_getInstanceMethod(class, origSelector);
    Method swizzledMethod = class_getInstanceMethod(class, newSelector);
    
    BOOL didAddMethod = class_addMethod(class,
                                        origSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(class,
                            newSelector,
                            method_getImplementation(originaMCethod),
                            method_getTypeEncoding(originaMCethod));
    } else {
        method_exchangeImplementations(originaMCethod, swizzledMethod);
    }
}

- (id)MC_topViewController {
    UIViewController *resultVC;
    resultVC = [self findTopViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self findTopViewController:resultVC.presentedViewController];
    }
    return resultVC;
}


- (UIViewController *)findTopViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self findTopViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self findTopViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

@end
