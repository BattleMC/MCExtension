//
//  NSArray+MCExtension.h
//
//  Created by maocheng on 2017/6/12.
//  Copyright © 2017年 All rights reserved.
//

#import "NSArray+MCExtension.h"
#import "NSObject+MCExtension.h"
#import <objc/runtime.h>
#import "MCMacro.h"
#import <MJExtension/MJExtension.h>

@implementation NSArray (MCExtension)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        id obj = [[self alloc] init];
        [obj MC_swizzleMethod:@selector(objectAtIndex:) withMethod:@selector(safeObjectAtIndex:)];
    });
}

- (id)safeObjectAtIndex:(NSInteger)index
{
    if(index<[self count]){
        return [self safeObjectAtIndex:index];
    }else{
        MCLog(@"index is beyond bounds ");
    }
    return nil;
}

- (NSString *)MC_arrayJson
{
    NSMutableArray *dataJsons = [NSMutableArray array];
    for (NSObject *obj in self) {
        [dataJsons addObject:obj.mj_JSONString];
    }
    NSString *json = [dataJsons componentsJoinedByString:@","];
    NSString *string = [NSString stringWithFormat:@"[%@]",json];
    return string;
}

- (NSArray *)MC_fetchPropertys:(NSString *)propertyName otherProperty:(NSString *)otherProperty defaultValue:(id)defaultValue
{
    NSMutableArray *propertyLists = [NSMutableArray array];
    for (NSObject *object in self) {
        unsigned int count = 0;
        Class c = object.class;
        while (c &&c != [NSObject class]) {
            objc_property_t *properties = class_copyPropertyList(c, &count);
            for (int i = 0; i < count; i++) {
                const char* name = property_getName(properties[i]);
                NSString *ivarName = [[NSString alloc] initWithCString:name encoding:NSUTF8StringEncoding];
                if([ivarName isEqualToString:propertyName]) {
                    // 获取值
                    id value = [object valueForKey:ivarName];
                    if (value) {
                        [propertyLists addObject:value];
                    } else {
                        for (int j = 0; j < count; j++) {
                            const char* name2 = property_getName(properties[j]);
                            NSString *ivarName2 = [[NSString alloc] initWithCString:name2 encoding:NSUTF8StringEncoding];
                            if([ivarName2 isEqualToString:otherProperty]) {
                                id value2 = [object valueForKey:ivarName2];
                                if (value2) {
                                    [propertyLists addObject:value2];
                                } else {
                                    [propertyLists addObject:defaultValue];
                                }
                                break;
                            }
                        }
                    }
                    break;
                }
            }
            free(properties);
            c = [c superclass];
        }
    }
    return propertyLists;
}

- (NSArray *)MC_fetchPropertys:(NSString *)propertyName defaultValue:(id)defaultValue {
    NSMutableArray *propertyLists = [NSMutableArray array];
    for (NSObject *object in self) {
        unsigned int count = 0;
        Class c = object.class;
        while (c &&c != [NSObject class]) {
            objc_property_t *properties = class_copyPropertyList(c, &count);
            for (int i = 0; i < count; i++) {
                const char* name = property_getName(properties[i]);
                NSString *ivarName = [[NSString alloc] initWithCString:name encoding:NSUTF8StringEncoding];
                if([ivarName isEqualToString:propertyName]) {
                    // 获取值
                    id value = [object valueForKey:ivarName];
                    if (value) {
                        [propertyLists addObject:value];
                    } else {
                        [propertyLists addObject:defaultValue];
                    }
                    break;
                }
            }
            free(properties);
            c = [c superclass];
        }
    }
    return propertyLists;
}

/**
 重写系统方法，控制台打印中文
 */
- (NSString *)descriptionWithLocale:(id)locale
{
    // 控制台打印中文
    NSMutableString *string = [NSMutableString string];
    [string appendString:@"[\n"];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [string appendFormat:@"\t%@,\n", obj];
    }];
    [string appendString:@"]"];
    NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];
    if (range.location != NSNotFound)
        [string deleteCharactersInRange:range];
    
    return string;
}

@end

@implementation NSArray (ZYLog)
#ifdef DEBUG
- (NSString *)description {
    return [self ZY_descriptionWithLevel:1];
}
-(NSString *)descriptionWithLocale:(id)locale{
    return [self ZY_descriptionWithLevel:1];
}
- (NSString *)descriptionWithLocale:(nullable id)locale indent:(NSUInteger)level {
    return [self ZY_descriptionWithLevel:(int)level];
}
/**
 将数组转化成字符串，文字格式UTF8,并且格式化
 @param level 当前数组的层级，最少为 1，代表最外层
 @return 格式化的字符串
 */
- (NSString *)ZY_descriptionWithLevel:(int)level {
    NSString *subSpace = [self ZY_getSpaceWithLevel:level];
    NSString *space = [self ZY_getSpaceWithLevel:level - 1];
    NSMutableString *retString = [[NSMutableString alloc] init];
    // 1、添加 [
    [retString appendString:[NSString stringWithFormat:@"["]];
    // 2、添加 value
    [self enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSString class]]) {
            NSString *value = (NSString *)obj;
            value = [value stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSString *subString = [NSString stringWithFormat:@"\n%@\"%@\",", subSpace, value];
            [retString appendString:subString];
        } else if ([obj isKindOfClass:[NSArray class]]) {
            NSArray *arr = (NSArray *)obj;
            NSString *str = [arr ZY_descriptionWithLevel:level + 1];
            str = [NSString stringWithFormat:@"\n%@%@,", subSpace, str];
            [retString appendString:str];
        } else if ([obj isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = (NSDictionary *)obj;
            NSString *str = [dic descriptionWithLocale:nil indent:level + 1];
            str = [NSString stringWithFormat:@"\n%@%@,", subSpace, str];
            [retString appendString:str];
        } else {
            NSString *subString = [NSString stringWithFormat:@"\n%@%@,", subSpace, obj];
            [retString appendString:subString];
        }
    }];
    if ([retString hasSuffix:@","]) {
        [retString deleteCharactersInRange:NSMakeRange(retString.length-1, 1)];
    }
    // 3、添加 ]
    [retString appendString:[NSString stringWithFormat:@"\n%@]", space]];
    return retString;
}
/**
 根据层级，返回前面的空格占位符
 @param level 层级
 @return 占位空格
 */
- (NSString *)ZY_getSpaceWithLevel:(int)level {
    NSMutableString *mustr = [[NSMutableString alloc] init];
    for (int i=0; i<level; i++) {
        [mustr appendString:@"\t"];
    }
    return mustr;
}
#endif
@end
@implementation NSDictionary (ZYLog)
#ifdef DEBUG
- (NSString *)description {
    return [self ZY_descriptionWithLevel:1];
}
- (NSString *)descriptionWithLocale:(nullable id)locale {
    return [self ZY_descriptionWithLevel:1];
}
- (NSString *)descriptionWithLocale:(nullable id)locale indent:(NSUInteger)level {
    return [self ZY_descriptionWithLevel:(int)level];
}
/**
 * 非字典时，会引发崩溃
 */
- (NSString *)ZY_getUTF8String {
    if ([self isKindOfClass:[NSDictionary class]] == NO) {
        return @"";
    }
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        return @"";
    }
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return str;
}
/**
 将字典转化成字符串，文字格式UTF8,并且格式化
 @param level 当前字典的层级，最少为 1，代表最外层字典
 @return 格式化的字符串
 */
- (NSString *)ZY_descriptionWithLevel:(int)level {
    NSString *subSpace = [self ZY_getSpaceWithLevel:level];
    NSString *space = [self ZY_getSpaceWithLevel:level - 1];
    NSMutableString *retString = [[NSMutableString alloc] init];
    // 1、添加 {
    [retString appendString:[NSString stringWithFormat:@"{"]];
    // 2、添加 key : value;
    [self enumerateKeysAndObjectsUsingBlock:^(id _Nonnull key, id _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSString class]]) {
            NSString *value = (NSString *)obj;
            value = [value stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSString *subString = [NSString stringWithFormat:@"\n%@\"%@\" : \"%@\",", subSpace, key, value];
            [retString appendString:subString];
        } else if ([obj isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = (NSDictionary *)obj;
            NSString *str = [dic ZY_descriptionWithLevel:level + 1];
            str = [NSString stringWithFormat:@"\n%@\"%@\" : %@,", subSpace, key, str];
            [retString appendString:str];
        } else if ([obj isKindOfClass:[NSArray class]]) {
            NSArray *arr = (NSArray *)obj;
            NSString *str = [arr descriptionWithLocale:nil indent:level + 1];
            str = [NSString stringWithFormat:@"\n%@\"%@\" : %@,", subSpace, key, str];
            [retString appendString:str];
        } else {
            NSString *subString = [NSString stringWithFormat:@"\n%@\"%@\" : %@,", subSpace, key, obj];
            [retString appendString:subString];
        }
    }];
    if ([retString hasSuffix:@","]) {
        [retString deleteCharactersInRange:NSMakeRange(retString.length-1, 1)];
    }
    // 3、添加 }
    [retString appendString:[NSString stringWithFormat:@"\n%@}", space]];
    return retString;
}
/**
 根据层级，返回前面的空格占位符
 @param level 字典的层级
 @return 占位空格
 */
- (NSString *)ZY_getSpaceWithLevel:(int)level {
    NSMutableString *mustr = [[NSMutableString alloc] init];
    for (int i=0; i<level; i++) {
        [mustr appendString:@"\t"];
    }
    return mustr;
}
#endif
@end
