//
//  NSObject+MCExtension.h
//
//  Created by maocheng on 2017/6/12.
//  Copyright © 2017年 All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (MCExtension)

/** 深复制对象 */
- (instancetype)MC_deepCopy;

/**
 *  runtime字典转模型
 *
 *  @param dict    原字典
 *  @param mapDict 映射字典
 *
 *  @return 返回属性已赋值的模型
 */
+ (instancetype)MC_modelWithDict:(NSDictionary *)dict mapDict:(NSDictionary *)mapDict;

/**
 *  runtime字典转模型
 *
 *  @param dict    原字典
 *  @param mapDict 映射字典
 *  @return 返回属性已赋值的模型
 */
- (instancetype)initWithDict:(NSDictionary *)dict mapDict:(NSDictionary *)mapDict;

/**
 *  runtime字典转模型
 *
 *  @param dict    原字典
 *  @return 返回属性已赋值的模型
 */
+ (instancetype)MC_modelWithDict:(NSDictionary *)dict;

/**
 *  runtime字典转模型
 *
 *  @param dict    原字典
 *  @return 返回属性已赋值的模型
 */
- (instancetype)initWithDict:(NSDictionary *)dict;

/**
 方法交换
 
 @param origSelector 方法1
 @param newSelector 方法2
 */
- (void)MC_swizzleMethod:(SEL)origSelector withMethod:(SEL)newSelector;

/**
 获取当前显示的控制器
 
 @return 当前的控制器
 */
- (id)MC_topViewController;


@end
