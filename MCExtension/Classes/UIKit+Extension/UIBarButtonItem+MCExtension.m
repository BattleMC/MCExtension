//
//  UIBarButtonItem+MCExtension.h
//
//  Created by maocheng on 2017/6/12.
//  Copyright © 2017年 All rights reserved.
//

#import "UIBarButtonItem+MCExtension.h"
#import "UIButton+MCExtension.h"
#import "UIView+MCExtension.h"
#import <objc/runtime.h>

@implementation UIBarButtonItem (MCExtension)

+ (instancetype)MC_itemForButtonWithImage:(UIImage *)image actionBlock:(MCBtnClickedBlock)block
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateHighlighted];
    CGRect rect = btn.frame;
    rect.size = CGSizeMake(20, 20);
    btn.frame = rect;
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btn MC_handleControlEvent:UIControlEventTouchUpInside withBlock:^(UIButton *button) {
        block(button);
    }];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return item;
}

+ (instancetype)MC_itemForButtonWithTitle:(NSString *)title fontSize:(CGFloat)fontSize color:(UIColor *)titleColor actionBlock:(MCBtnClickedBlock)block {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [btn sizeToFit];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btn MC_handleControlEvent:UIControlEventTouchUpInside withBlock:^(UIButton *button) {
        if(block) {
            block(button);
        }
    }];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return item;
}

+ (instancetype)MC_itemForButtonWithTitle:(NSString *)title fontSize:(CGFloat)fontSize color:(UIColor *)titleColor buttonWidth:(CGFloat)buttonWidth actionBlock:(MCBtnClickedBlock)block {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [btn sizeToFit];
    btn.width = buttonWidth;
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btn MC_handleControlEvent:UIControlEventTouchUpInside withBlock:^(UIButton *button) {
        if(block) {
            block(button);
        }
    }];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return item;
}

+ (instancetype)MC_itemForButtonWithTitle:(NSString *)title image:(UIImage *)image fontSize:(CGFloat)fontSize color:(UIColor *)titleColor actionBlock:(MCBtnImgClickedBlock)block {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(0, 6, 18, 18);
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [btn sizeToFit];
    btn.x = 23;
    
    UIButton *coverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    coverBtn.frame = CGRectMake(0, 0, imageView.width + btn.width + 5, 30);
    [coverBtn MC_handleControlEvent:UIControlEventTouchUpInside withBlock:^(UIButton *button) {
        if(block) {
            block(button,imageView);
        }
    }];
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, imageView.width + btn.width + 5, 30)];
    [customView addSubview:imageView];
    [customView addSubview:btn];
    [customView addSubview:coverBtn];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:customView];
    return item;
}

+ (instancetype)MC_itemForButtonWithTitle:(NSString *)title color:(UIColor *)titleColor actionBlock:(MCBtnClickedBlock)block
{
    return [self MC_itemForButtonWithTitle:title fontSize:14 color:titleColor actionBlock:block];
}

@end
