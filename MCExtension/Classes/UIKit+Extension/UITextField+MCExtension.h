//
//  UITextField+MCExtension.h
//
//  Created by maocheng on 2017/6/12.
//  Copyright © 2017年 All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (MCExtension)<UITextFieldDelegate>

/**
 最大长度
 */
- (void)setMaxLength:(NSInteger)maxLength;

@end
