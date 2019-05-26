//
//  NSObject+MCLanguage.h
//
//  Created by maocheng on 2017/6/12.
//  Copyright © 2017年 All rights reserved.
//

#import "NSObject+MCLanguage.h"

@implementation NSObject (MCLanguage)

/** 转化为繁体 */
- (id)toTran {
    return [self convertToTran:@(YES)];
}

/** 转化为简体 */
- (id)toSimp {
    return [self convertToTran:@(NO)];
}

/** 转化为繁体与否 */
- (id)convertToTran:(NSNumber *)isTran {
    return nil;
    // to-do: 子类必须继承
}

/** 转化为本地语言 */
- (id)toLocal {
    BOOL isSimp = [self isSimp];
    
    if (isSimp) {
        return [self toSimp];
    } else {
        return [self toTran];
    }
}

- (BOOL)isTran {
    return ![self isSimp];
}

- (BOOL)isSimp {
    NSString *lan = [[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] objectAtIndex:0];
    if ([lan rangeOfString:@"Hans"].length > 0) {
        return YES;
    }
    return NO;
}

@end

@implementation NSString (MCLanguage)

/** 转化为繁体与否 */
- (NSString *)convertToTran:(NSNumber *)isTran {
    NSMutableString *back = [[NSMutableString alloc] init];
    NSString *tableName = [isTran boolValue]?@"MCCC-Tran":@"MCCC-Simp";
    
    static NSBundle *frameworkBundle = nil;
    if (!frameworkBundle) {
        NSString *mainBundlePath = [[NSBundle mainBundle] resourcePath];
        NSString *frameworkBundlePath = [mainBundlePath stringByAppendingPathComponent:@"MCChineseConvert.bundle"];
        frameworkBundle = [NSBundle bundleWithPath:frameworkBundlePath];
        if (![frameworkBundle isLoaded]) {
            [frameworkBundle load];
        }
    }
    
    if (nil == frameworkBundle) {
        NSLog(@"*** 找不到 MCChineseConvert.bundle/%@", tableName);
        return self;
    }
    
    for (NSInteger i = 0; i< self.length; i++) {
        NSString *string = [self substringWithRange:NSMakeRange(i, 1)];
        
        NSString *stringNew = NSLocalizedStringFromTableInBundle(string, tableName, frameworkBundle, nil);
        
        if (nil == stringNew) {
            [back appendString:string];
        } else {
            [back appendString:stringNew];
        }
    }
    return back;
}

@end

#pragma mark - UIView (MCLanguage)

@implementation UIView (MCLanguage)

- (id)convertToTran:(NSNumber *)isTran {
    if ([self isKindOfClass:[UIView class]]) {
        [[self subviews] makeObjectsPerformSelector:@selector(convertToTran:) withObject:isTran];
    }
    return nil;
}
@end

#pragma mark - UILabel (MCLanguage)

@implementation UILabel (MCLanguage)

- (id)convertToTran:(NSNumber *)isTran {
    NSString *text = self.text;
    self.text = [text convertToTran:isTran];
    return nil;
}

@end

#pragma mark - UITextField (MCLanguage)

@implementation UITextField (MCLanguage)
- (id)convertToTran:(NSNumber *)isTran {
    NSString *text = self.text;
    self.text = [text convertToTran:isTran];
    
    self.placeholder = [self.placeholder convertToTran:isTran];
    
    if (self.leftView) {
        [self.leftView convertToTran:isTran];
    }
    
    if (self.rightView) {
        [self.rightView convertToTran:isTran];
    }
    return nil;
}
@end

#pragma mark - UITextView (MCLanguage)

@implementation UITextView (MCLanguage)
- (id)convertToTran:(NSNumber *)isTran {
    NSString *text = self.text;
    self.text = [text convertToTran:isTran];
    return nil;
}
@end

#pragma mark - UIButton (MCLanguage)

@implementation UIButton (MCLanguage)
- (id)convertToTran:(NSNumber *)isTran {
    NSString *title = [self titleForState:UIControlStateNormal];
    title = [title convertToTran:isTran];
    [self setTitle:title forState:UIControlStateNormal];
    
    title = [self titleForState:UIControlStateSelected];
    title = [title convertToTran:isTran];
    [self setTitle:title forState:UIControlStateSelected];
    
    return nil;
}
@end

#pragma mark - UISegmentedControl (MCLanguage)

@implementation UISegmentedControl (MCLanguage)
- (id)convertToTran:(NSNumber *)isTran {
    UISegmentedControl *view = (UISegmentedControl *)self;
    for (NSInteger i = 0; i < view.numberOfSegments; i++) {
        NSString *title = [view titleForSegmentAtIndex:i];
        [view setTitle:[title convertToTran:isTran] forSegmentAtIndex:i];
    }
    return nil;
}
@end

#pragma mark - UIToolbar (MCLanguage)

@implementation UIToolbar (MCLanguage)
- (id)convertToTran:(NSNumber *)isTran {
    UIToolbar *view = (UIToolbar *)self;
    for (UIBarItem *item in view.items) {
        NSString *title = [item title];
        [item setTitle:[title convertToTran:isTran]];
    }
    return nil;
}
@end

#pragma mark - UITabBar (MCLanguage)

@implementation UITabBar (MCLanguage)
- (id)convertToTran:(NSNumber *)isTran {
    UITabBar *view = (UITabBar *)self;
    for (UIBarItem *item in view.items) {
        NSString *title = [item title];
        [item setTitle:[title convertToTran:isTran]];
    }
    return nil;
}
@end

#pragma mark - UINavigationBar (MCLanguage)

@implementation UINavigationBar (MCLanguage)
- (id)convertToTran:(NSNumber *)isTran {
    UINavigationBar *view = (UINavigationBar *)self;
    for (UIBarItem *item in view.items) {
        NSString *title = [item title];
        [item setTitle:[title convertToTran:isTran]];
    }
    return nil;
}
@end

#pragma mark - UINavigationItem (MCLanguage)

@implementation UINavigationItem (MCLanguage)

/** 转化为繁体与否 */
- (id)convertToTran:(NSNumber *)isTran {
    UINavigationItem *view = (UINavigationItem *)self;
    if (view.title && view.title.length > 0) {
        view.title = [view.title convertToTran:isTran];
    }
    
    if (view.titleView) {
        [view.titleView toLocal];
    }
    
    if (view.leftBarButtonItem) {
        [view.leftBarButtonItem toLocal];
    } else if (view.leftBarButtonItems) {
        [view.leftBarButtonItems makeObjectsPerformSelector:@selector(convertToTran:) withObject:isTran];
    }
    
    if (view.rightBarButtonItem) {
        [view.rightBarButtonItem toLocal];
    } else if (view.rightBarButtonItems) {
        [view.rightBarButtonItems makeObjectsPerformSelector:@selector(convertToTran:) withObject:isTran];
    }
    return nil;
}
@end

#pragma mark - UITableView (MCLanguage)
@implementation UITableView (MCLanguage)
- (id)convertToTran:(NSNumber *)isTran {
    [self.subviews makeObjectsPerformSelector:@selector(convertToTran:) withObject:isTran];
    
    return nil;
}

/** 转化为繁体 */
- (void)reloadDataToTran {
    [self reloadDataToTran:@YES];
}

/** 转化为简体 */
- (void)reloadDataToSimp {
    [self reloadDataToTran:@NO];
    
}

/** 转化为本地语言 */
- (void)reloadDataToLocal {
    if (self.isTran) {
        [self reloadDataToTran];
    } else {
        [self reloadDataToSimp];
    }
}

- (void)reloadDataToTran:(NSNumber *)isTran {
    [self reloadData];
    [self convertToTran:isTran];
}

@end

@implementation NSArray (MCLanguage)
- (id)convertToTran:(NSNumber *)isTran {
    
    for (NSObject *object in self) {
        [object convertToTran:isTran];
    }
    return nil;
}

@end

@implementation NSDictionary (MCLanguage)
- (id)convertToTran:(NSNumber *)isTran {
    
    for (NSString *key in [self allKeys]) {
        NSObject *object = [self objectForKey:key];
        [object convertToTran:isTran];
    }
    return nil;
}

@end

@implementation UIAlertView (MCLanguage)
- (id)convertToTran:(NSNumber *)isTran {
    
    self.title = [[self title] convertToTran:isTran];
    self.message = [self.message convertToTran:isTran];
    
    if (self.alertViewStyle == UIAlertViewStylePlainTextInput) {
        for (NSInteger i = 0; i < 100; i++) {
            UITextField *field = [self textFieldAtIndex:i];
            if (field) {
                field.placeholder = [field.placeholder convertToTran:isTran];
            } else {
                break;
            }
        }
    }
    
    return nil;
}
@end


#pragma mark - UITableViewCell (MCLanguage)

@implementation UITableViewCell (MCLanguage)
- (id)convertToTran:(NSNumber *)isTran {
    [self.subviews makeObjectsPerformSelector:@selector(convertToTran:) withObject:isTran];
    
    [[self.contentView subviews] makeObjectsPerformSelector:@selector(convertToTran:) withObject:isTran];
    
    return nil;
}
@end

#pragma mark - UIViewController (MCLanguage)

@implementation UIViewController (MCLanguage)

- (id)convertToTran:(NSNumber *)isTran {
    [self.view convertToTran:isTran]; //转化view
    
    if (self.title) { // 转化标题
        self.title = [self.title convertToTran:isTran];
    }
    
    if (self.navigationController.navigationBar) { //转化导航栏
        [self.navigationController.navigationBar convertToTran:isTran];
    }
    
    if (self.navigationController.toolbar) { //转化工具栏
        [self.navigationController.navigationController.toolbar convertToTran:isTran];
    }
    
    if (self.tabBarController.tabBar) { //转化标签栏
        [self.tabBarController.tabBar convertToTran:isTran];
    }
    
    if (self.navigationItem) { //转化navigation栏
        [self.navigationItem convertToTran:isTran];
    }
    return nil;
}
@end
