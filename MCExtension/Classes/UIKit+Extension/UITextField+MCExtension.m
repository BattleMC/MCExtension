//
//  UITextField+MCExtension.h
//
//  Created by maocheng on 2017/6/12.
//  Copyright © 2017年 All rights reserved.
//

#import "UITextField+MCExtension.h"
#import <ReactiveObjC/ReactiveObjC.h>

@implementation UITextField (MCExtension)

- (void)setMaxLength:(NSInteger)maxLength
{
    @weakify(self);
    if(maxLength && maxLength != 0) {
        [self.rac_textSignal subscribeNext:^(NSString *x) {
            @strongify(self);
            if (x.length > maxLength) {
                self.text = [x substringToIndex:maxLength];
            }
        }];
    }
//    self.delegate = self;
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    NSString *tem = [[string componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]componentsJoinedByString:@""];
//    if (![string isEqualToString:tem]) {
//        return NO;
//    }
//    return YES;
//}

@end
