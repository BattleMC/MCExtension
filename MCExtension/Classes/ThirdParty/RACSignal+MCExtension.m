//
//
//  RACSignal+MCExtension.h
//
//  Created by maocheng on 2017/6/12.
//  Copyright © 2017年 All rights reserved.
//

#import "RACSignal+MCExtension.h"

@implementation RACSignal (MCExtension)

- (RACSignal *)filterEmptyString
{
   return [self filter:^BOOL(id value) {
       if ([value isKindOfClass:[NSString class]]) {
           NSString *str = value;
           if (!str || str.length == 0 ) {
               return NO;
           }
           return YES;
       } 
       return YES;
    }];
}

@end
