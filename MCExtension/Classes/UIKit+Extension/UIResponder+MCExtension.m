//
//  UIResponder+MCExtension.h
//
//  Created by maocheng on 2017/6/12.
//  Copyright © 2017年 All rights reserved.
//

#import "UIResponder+MCExtension.h"
#import "MCMacro.h"

@implementation UIResponder (MCExtension)

- (void)routerWithPushController:(UIViewController *)viewController
{
    [self routerEventWithName:pushKey userInfo:@{@"viewController":viewController} needBuried:NO];
}

- (void)routerWithPopController
{
    [self routerEventWithName:popKey userInfo:nil needBuried:NO];
}   

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo needBuried:(BOOL)needBuried
{
    if (needBuried) {
        [self handleBuriedWithEventName:eventName userInfo:userInfo];
        needBuried = NO;
    }
    [[self nextResponder] routerEventWithName:eventName userInfo:userInfo needBuried:needBuried];
}

- (void)handleBuriedWithEventName:(NSString *)eventName userInfo:(NSDictionary *)userInfo
{
    MCLog(@"点击 %@ 事件",eventName);
    
}

@end
