//
//  UIButton+MCExtension.h
//
//  Created by maocheng on 2017/6/12.
//  Copyright © 2017年 All rights reserved.
//

#import "UIButton+MCExtension.h"
#import "UIResponder+MCExtension.h"
#import <objc/runtime.h>

@implementation UIButton (MCExtension)

- (UIButton *(^)(NSString *))MC_title
{
    return ^UIButton *(NSString *title) {
        [self setTitle:title forState:UIControlStateNormal];
        return self;
    };
}

- (UIButton *(^)(UIColor *titleColor))MC_titleColor
{
    return ^UIButton*(UIColor *titleColor) {
        [self setTitleColor:titleColor forState:UIControlStateNormal];
        return self;
    };
}

- (UIButton *(^)(UIColor *titleColor,UIControlState state))MC_titleColorState
{
    return ^UIButton*(UIColor *titleColor,UIControlState state) {
        [self setTitleColor:titleColor forState:state];
        return self;
    };
}

- (UIButton *(^)(NSString *title,UIControlState state))MC_titleState
{
    return ^UIButton*(NSString *title,UIControlState state) {
        [self setTitle:title forState:state];
        return self;
    };
}

- (UIButton *(^)(CGFloat titleFontSize))MC_titleFontSize
{
    return ^UIButton*(CGFloat titleFontSize) {
        self.titleLabel.font = [UIFont systemFontOfSize:titleFontSize];
        return self;
    };
}

- (UIButton *(^)(UIImage *image))MC_image
{
    return ^UIButton*(UIImage *image) {
        [self setImage:image forState:UIControlStateNormal];
        return self;
    };
}

- (UIButton *(^)(UIImage *image,UIControlState state))MC_imageState
{
    return ^UIButton*(UIImage *image,UIControlState state) {
        [self setImage:image forState:state];
        return self;
    };
}

- (UIButton *(^)(UIEdgeInsets titleInset))MC_titleInset
{
    return ^UIButton*(UIEdgeInsets titleInset) {
        self.titleEdgeInsets = titleInset;
        return self;
    };
}

static char eventKey;

- (void)MC_handleControlEvent:(UIControlEvents)event withBlock:(ButtonClickedBlock)action {
    objc_setAssociatedObject(self, &eventKey, action, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(dk_callActionBlock:) forControlEvents:event];
}

- (void)dk_callActionBlock:(UIButton *)sender {
    ButtonClickedBlock block = (ButtonClickedBlock)objc_getAssociatedObject(self, &eventKey);
    if (block) {
        block(sender);
    }
}

- (void)MC_clickWithRouterName:(NSString *)routerName userInfo:(NSDictionary *)userInfo needBuired:(BOOL)needBuired
{
    __weak typeof(self) weakSelf = self;
    [self MC_handleControlEvent:UIControlEventTouchUpInside withBlock:^(UIButton *button) {
        [weakSelf routerEventWithName:routerName userInfo:userInfo needBuried:needBuired];
    }];
}

#ifdef RAC
- (RACSignal *)clickSignal
{
    return [self rac_signalForControlEvents:UIControlEventTouchUpInside];
}
#endif

@end
