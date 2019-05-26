//
//  UIResponder+MCExtension.h
//
//  Created by maocheng on 2017/6/12.
//  Copyright © 2017年 All rights reserved.
//
#import <UIKit/UIKit.h>

static NSString * pushKey = @"pushController";
static NSString * popKey = @"popController";

@interface UIResponder (MCExtension)

- (void)routerWithPushController:(UIViewController *)viewController;

- (void)routerWithPopController;

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo needBuried:(BOOL)needBuried;

@end
