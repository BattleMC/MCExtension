//
//  NSArray+MCExtension.h
//
//  Created by maocheng on 2017/6/12.
//  Copyright © 2017年 All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (MCExtension)

/**
 取出模型数组中某个属性组成数组
 
 @param propertyName 要取出的属性名
 @return 属性值组成的数组
 */
- (NSArray *)MC_fetchPropertys:(NSString *)propertyName defaultValue:(id)value;

- (NSArray *)MC_fetchPropertys:(NSString *)propertyName otherProperty:(NSString *)otherProperty defaultValue:(id)defaultValue;

- (NSString *)MC_arrayJson;

@end
