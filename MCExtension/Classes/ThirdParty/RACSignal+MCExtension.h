//
//  RACSignal+MCExtension.h
//
//  Created by maocheng on 2017/6/12.
//  Copyright © 2017年 All rights reserved.
//

#import <ReactiveObjc/ReactiveObjc.h>

@interface RACSignal (MCExtension)

- (RACSignal *)filterEmptyString;

@end
