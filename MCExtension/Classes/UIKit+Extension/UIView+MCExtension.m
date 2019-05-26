//
//  UIView+MCExtension.h
//
//  Created by maocheng on 2017/6/12.
//  Copyright © 2017年 All rights reserved.
//

#import "UIView+MCExtension.h"
#import <ReactiveObjC/UIGestureRecognizer+RACSignalSupport.h>
#import <ReactiveObjC/RACSignal.h>

@implementation UIView (MCExtension)


#pragma mark - frame extension

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)maxX
{
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)minX
{
    return CGRectGetMinX(self.frame);
}

- (CGFloat)maxY
{
    return CGRectGetMaxY(self.frame);
}

- (CGFloat)minY
{
    return CGRectGetMinY(self.frame);
}

#pragma mark -chain

+ (instancetype)instance
{
    return [[self alloc] init];
}

- (UIView * (^)(CGFloat x))MC_x
{
    return ^UIView *(CGFloat x) {
        self.x = x;
        return self;
    };
}

- (UIView *(^)(CGFloat))MC_MaxX
{
    return ^UIView *(CGFloat maxX) {
        self.x = maxX - self.width;
        return self;
    };
}

- (UIView *(^)(CGFloat))MC_MaxY
{
    return ^UIView *(CGFloat maxY) {
        self.y = maxY - self.height;
        return self;
    };
}

- (UIView *(^)(CGFloat))MC_centerX
{
    return ^UIView *(CGFloat centerX) {
        self.centerX = centerX;
        return self;
    };
}

- (UIView *(^)(CGFloat))MC_centerY
{
    return ^UIView *(CGFloat centerY) {
        self.centerY = centerY;
        return self;
    };
}

- (UIView * (^)(CGFloat y))MC_y {
    return ^UIView *(CGFloat y) {
        self.y = y;
        return self;
    };
}
- (UIView * (^)(CGFloat width))MC_width {
    return ^UIView *(CGFloat width) {
        self.width = width;
        return self;
    };
}
- (UIView * (^)(CGFloat height))MC_height {
    return ^UIView *(CGFloat height) {
        self.height = height;
        return self;
    };
}
- (UIView * (^)(CGRect frame))MC_frame {
    return ^UIView *(CGRect frame) {
        self.frame = frame;
        return self;
    };
}

- (UIView * (^)(UIColor *))MC_backgroundColor
{
    return ^UIView *(UIColor *backgoundColor) {
        self.backgroundColor = backgoundColor;
        return self;
    };
}

- (instancetype)MC_clipToBounds
{
    self.clipsToBounds = YES;
    return self;
}

- (instancetype (^)(UIView *))MC_addTo
{
    return ^(UIView *superView) {
        [superView addSubview:self];
        return self;
    };
}

- (UIView * (^)(CGFloat radius))MC_raduis
{
    return ^UIView *(CGFloat raduis) {
        self.layer.cornerRadius = raduis;
        return self;
    };
}

- (UIView * (^)(UIColor *borderColor))MC_borderColor
{
    return ^UIView *(UIColor *borderColor) {
        self.layer.borderWidth = 1;
        self.layer.borderColor = borderColor.CGColor;
        return self;
    };
}

- (instancetype)MC_sizeToFit
{
    [self sizeToFit];
    return self;
}


#pragma mark - 添加xib配置属性

- (void)setBorderColor:(UIColor *)borderColor
{
    self.layer.borderColor = borderColor.CGColor;
}

- (UIColor *)BorderColor
{
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    self.layer.borderWidth = borderWidth;
}

- (CGFloat)BorderWidth
{
    return self.layer.borderWidth;
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
    //    [self MC_setCornerRadius:cornerRadius];
    // 设置栅格化后，图层会被渲染成图片，并且缓存，再次使用时，不会重新渲染
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

- (CGFloat)CornerRadius
{
    return self.layer.cornerRadius;
}

- (void)setRadiusScopeH:(CGFloat)scope
{
    CGFloat selfHeight = [UIScreen mainScreen].bounds.size.height * scope;
    [self setCornerRadius:selfHeight * 0.5];
}

- (void)setRadiusScopeW:(CGFloat)scope
{
    CGFloat selfHeight = [UIScreen mainScreen].bounds.size.width * scope;
    [self setCornerRadius:selfHeight * 0.5];
}

- (CGFloat)RadiusScopeW
{
    return 0; // just hide warning
}

- (CGFloat)RadiusScopeH
{
    return 0; // just hide warning
}

- (UIView *)MC_duplicate
{
    NSData *tempArchive = [NSKeyedArchiver archivedDataWithRootObject:self];
    return [NSKeyedUnarchiver unarchiveObjectWithData:tempArchive];
}

- (void)MC_setCornerRadius:(CGFloat)cornerRadius {
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:cornerRadius];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.frame = self.bounds;
    self.layer.mask = layer;
}

- (void)MC_addShadowToView
{
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = [UIColor grayColor].CGColor;//shadowColor阴影颜色
    self.layer.shadowOffset = CGSizeMake(1,1);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    self.layer.shadowOpacity = 0.12;//阴影透明度，默认0
    self.layer.shadowRadius = 8;//阴影半径，默认3
}

- (void)MC_addShadowToViewWithColor:(UIColor *)color offset:(CGSize)offset {
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = color.CGColor?:[UIColor grayColor].CGColor;//shadowColor阴影颜色
    self.layer.shadowOffset = offset;//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    self.layer.shadowOpacity = 0.5;//阴影透明度，默认0
    self.layer.shadowRadius = 3;//阴影半径，默认3
}

- (void)MC_addShadowToViewWithColor:(UIColor *)color offset:(CGSize)offset size:(CGFloat)size {
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = color.CGColor?:[UIColor grayColor].CGColor;//shadowColor阴影颜色
    self.layer.shadowOffset = offset;//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    self.layer.shadowOpacity = 0.5;//阴影透明度，默认0
    self.layer.shadowRadius = size == 0 ? 3 : size;//阴影半径，默认3
}

- (void)MC_addBlurEffectStyle:(UIBlurEffectStyle)style
{
    // 给背景添加毛玻璃效果
    UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:style];
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    visualEffectView.frame = self.bounds;
    
    [self addSubview:visualEffectView];
}

- (void)MC_addGradientLayerWithBeginColor:(UIColor *)beginColor endColor:(UIColor *)endColor cornerRadius:(CGFloat)cornerRadius
{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.bounds;
    gradient.colors = @[(id)beginColor.CGColor,(id)endColor.CGColor];
    gradient.startPoint = CGPointMake(0, 0.5);
    gradient.endPoint = CGPointMake(1, 0.5);
    gradient.cornerRadius = cornerRadius;
    [self.layer insertSublayer:gradient atIndex:0];
}

- (void)MC_addCorner:(CGFloat)cornerRadius borderWidth:(CGFloat)width borderColor:(UIColor *)color
{
    if (cornerRadius != 0) {
        self.layer.cornerRadius = cornerRadius;
    }
    self.layer.borderWidth = width;
    self.layer.borderColor = color.CGColor;
}

- (BOOL)MC_intersectWithView:(UIView *)view
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGRect selfRect = [self convertRect:self.bounds toView:window];
    CGRect viewRect = [view convertRect:view.bounds toView:window];
    return CGRectIntersectsRect(selfRect, viewRect);
}

- (UIView *)MC_snapshotViewAfterScreenUpdates:(BOOL)afterUpdates
{
    if([UIDevice currentDevice].systemVersion.floatValue >= 10.0) {
        UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);
        CGContextRef context = UIGraphicsGetCurrentContext();
        [self.layer renderInContext:context];
        UIImage *targetImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        UIImageView *snapView = [[UIImageView alloc] initWithImage:targetImage];
        snapView.frame = self.frame;
        return snapView;
    }else {
        return [self snapshotViewAfterScreenUpdates:afterUpdates];
    }
}

- (void)MC_tapOnView:(void(^)(UITapGestureRecognizer *tap))tapCallback
{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:nil action:nil];
    [self addGestureRecognizer:tap];
    [tap.rac_gestureSignal subscribeNext:^(id x) {
        if (tapCallback) {
            tapCallback(x);
        }
    }];
}

- (void)MC_longPressBySecond:(NSInteger)second onView:(void(^)(UILongPressGestureRecognizer *longPress))pressCallback {
   self.userInteractionEnabled = YES;
   UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:nil action:nil];
   longPress.minimumPressDuration = second;
   [self addGestureRecognizer:longPress];
   [longPress.rac_gestureSignal subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
       if (pressCallback) {
           pressCallback(x);
       }
   }];
}

+ (NSString *)defaultIdentifier
{
    return NSStringFromClass([self class]);
}

+ (UINib *)defaultNib
{
    UINib *nib = [UINib nibWithNibName:[self defaultIdentifier] bundle:[NSBundle bundleForClass:self.class]];
//    return [UINib nibWithNibName:[self defaultIdentifier] bundle:nil];
    return nib;
}

- (UIImage *)MC_screenshot
{
    return [self MC_screenshotForCroppingRect:self.bounds];
}

- (UIImage *)MC_screenshotForCroppingRect:(CGRect)croppingRect
{
    UIGraphicsBeginImageContextWithOptions(croppingRect.size, NO, [UIScreen mainScreen].scale);
    // Create a graphics context and translate it the view we want to crop so
    // that even in grabbing (0,0), that origin point now represents the actual
    // cropping origin desired:
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (context == NULL) return nil;
    CGContextTranslateCTM(context, -croppingRect.origin.x, -croppingRect.origin.y);
    
    [self layoutIfNeeded];
    [self.layer renderInContext:context];
    
    UIImage *screenshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenshotImage;
}

@end
