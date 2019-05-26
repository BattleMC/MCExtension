//
//  UITextView+MCExtension.h
//
//  Created by maocheng on 2017/6/12.
//  Copyright © 2017年 All rights reserved.
//
#import "UITextView+MCExtension.h"
#import <objc/runtime.h>

@implementation UITextView (MCExtension)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];

        SEL originalSelector = @selector(setText:);
        SEL swizzledSelector = @selector(mySetText:);
        
        Method originaMCethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        method_exchangeImplementations(originaMCethod, swizzledMethod);
    });
}

#pragma mark - Method Swizzling

- (void)mySetText:(NSString *)text
{
    if(self.editable == NO) {
        if([text containsString:@"(null)"]) {
            [self mySetText:[text stringByReplacingOccurrencesOfString:@"(null)" withString:@""]];
        }else {
            [self mySetText:text];
        }
    }else {
        [self mySetText:text];
    }
}

@end
