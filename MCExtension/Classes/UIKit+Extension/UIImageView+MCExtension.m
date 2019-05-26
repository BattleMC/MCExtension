//
//  UIImageView+MCExtension.h
//
//  Created by maocheng on 2017/6/12.
//  Copyright © 2017年 All rights reserved.
//

#import "UIImageView+MCExtension.h"

@implementation UIImageView (MCExtension)

- (UIImageView *(^)(NSString * _Nonnull))MC_imageNamed
{
    return ^UIImageView *(NSString *imageName) {
        self.image = [UIImage imageNamed:imageName];
        return self;
    };
}
- (UIImageView * (^)(UIViewContentMode mode))MC_mode
{
    return ^UIImageView *(UIViewContentMode contentMode) {
        self.contentMode = contentMode;
        return self;
    };
}

@end
