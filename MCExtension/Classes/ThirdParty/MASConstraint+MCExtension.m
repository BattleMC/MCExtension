//
//  MASConstraint+MCExtension.h
//
//  Created by maocheng on 2017/6/12.
//  Copyright © 2017年 All rights reserved.
//

#import "MASConstraint+MCExtension.h"

@implementation MASConstraint (MCExtension)

- (NSNumber *)MC_constant
{
    NSLayoutConstraint *constraint = [self valueForKeyPath:@"layoutConstraint"];
    return @(constraint.constant);
}

@end
