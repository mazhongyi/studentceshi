//
//  UINavigationBar+WRAddition.m
//  StoryBoardDemo
//
//  Created by wangrui on 2017/4/9.
//  Copyright © 2017年 wangrui. All rights reserved.
//
//  Github地址：https://github.com/wangrui460/WRNavigationBar

#import "WRNavigationBar.h"
#import <objc/runtime.h>
#import "sys/utsname.h"

@implementation WRNavigationBar

+ (BOOL)isIphoneX {
    BOOL isIPhoneX = NO;
    if (@available(iOS 11.0, *)) {
       isIPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;
    }
    return isIPhoneX;
}

+ (CGFloat)navBarBottom {
    return [self isIphoneX] ? 88 : 64;
}
+ (CGFloat)tabBarHeight {
    return [self isIphoneX] ? 83 : 49;
}
+ (CGFloat)screenWidth {
    return [UIScreen mainScreen].bounds.size.width;
}
+ (CGFloat)screenHeight {
    return [UIScreen mainScreen].bounds.size.height;
}

+ (CGFloat)statusBarHeight {
    return [UIApplication sharedApplication].statusBarFrame.size.height;
}

+ (CGFloat)defaultNavBarHeight {
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        if (@available(iOS 12.0, *)) {
            return 50;
        }
    }
    return 44;
}


+ (BOOL)isRoundCornerScreen {
    BOOL round = NO;
    
    // 判断安全区域, 只支持 iOS11 以上
    if (@available(iOS 11.0, *)) {
        UIEdgeInsets inset = [WRNavigationBar mainWindowSafeAreaInsets];
        round = round || inset.top > 0;
        round = round || inset.right > 0;
        round = round || inset.bottom > 0;
        round = round || inset.left > 0;
    }
    
    return round;
}

+ (UIEdgeInsets) mainWindowSafeAreaInsets {
    if (@available(iOS 11.0, *)) {
        return [UIApplication sharedApplication].windows.firstObject.safeAreaInsets;
    } else {
        // Fallback on earlier versions
        return UIEdgeInsetsZero;
    }
}

///设备的状态栏高度, 不管状态栏是否显示
+ (CGFloat)defaultStatusBarHeight {
    if (![WRNavigationBar isRoundCornerScreen]) {
        //非全面屏, 默认就是20
        return 20;
    }else {
        UIEdgeInsets inset = [WRNavigationBar mainWindowSafeAreaInsets];
        UIInterfaceOrientation statusBarOrientation = UIApplication.sharedApplication.statusBarOrientation;
        switch (statusBarOrientation) {
            case UIInterfaceOrientationPortrait:
                return inset.top;
                break;
            case UIInterfaceOrientationPortraitUpsideDown:
                return inset.bottom;
                break;
            case UIInterfaceOrientationLandscapeLeft:
                return inset.left;
                break;
            case UIInterfaceOrientationLandscapeRight:
                return inset.right;
                break;
            default:
                return inset.top;
                break;
        }
    }
    
}

//整个顶部导航的高度（状态栏加导航栏）
+ (CGFloat) defaultNavBarBottom{
    CGFloat height = [WRNavigationBar defaultStatusBarHeight] + [WRNavigationBar defaultNavBarHeight];
    NSLog(@"defaultNavBarBottom height === %@",@(height));
    return height;
}

//- (void)zx_setNavGradientBacFrom:(UIColor *)fromColor to:(UIColor *)toColor{
////    if(self.zx_navBar){
//        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
//        gradientLayer.startPoint = CGPointMake(0, 0);
//        gradientLayer.endPoint = CGPointMake(1, 0);
//        gradientLayer.colors = [NSArray arrayWithObjects:(id)fromColor.CGColor,(id)toColor.CGColor,nil];
////    if(zx_gradientLayer){
////        if(_zx_gradientLayer){
////            [_zx_gradientLayer removeFromSuperlayer];
////        }
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(CGFLOAT_MIN * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [self.layer insertSublayer:gradientLayer atIndex:0];
//        });
//    
//       // self.zx_navBar.zx_gradientLayer = gradientLayer;
//  //  }
//    
//}

//- (void)setZx_gradientLayer:(CAGradientLayer *)zx_gradientLayer{
//    if(!zx_gradientLayer && _zx_gradientLayer){
//        [_zx_gradientLayer removeFromSuperlayer];
//    }
//    if(zx_gradientLayer){
//        if(_zx_gradientLayer){
//            [_zx_gradientLayer removeFromSuperlayer];
//        }
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(CGFLOAT_MIN * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [self.layer insertSublayer:zx_gradientLayer atIndex:0];
//        });
//    }
//    _zx_gradientLayer = zx_gradientLayer;
//}


@end


//=============================================================================
#pragma mark - default navigationBar barTintColor、tintColor and statusBarStyle YOU CAN CHANGE!!!
//=============================================================================

@implementation WRNavigationBar (WRDefault)

static char kWRIsLocalUsedKey;
static char kWRWhiteistKey;
static char kWRBlacklistKey;

static char kWRDefaultNavBarBarTintColorKey;
static char kWRDefaultNavBarBackgroundImageKey;
static char kWRDefaultNavBarTintColorKey;
static char kWRDefaultNavBarTitleColorKey;
static char kWRDefaultStatusBarStyleKey;
static char kWRDefaultNavBarShadowImageHiddenKey;

static char kGradientLayerKey;



+ (BOOL)isLocalUsed {
    id isLocal = objc_getAssociatedObject(self, &kWRIsLocalUsedKey);
    return (isLocal != nil) ? [isLocal boolValue] : NO;
}
+ (void)wr_local {
    objc_setAssociatedObject(self, &kWRIsLocalUsedKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
+ (void)wr_widely {
    objc_setAssociatedObject(self, &kWRIsLocalUsedKey, @(NO), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (NSArray<NSString *> *)whitelist {
    NSArray<NSString *> *list = (NSArray<NSString *> *)objc_getAssociatedObject(self, &kWRWhiteistKey);
    return (list != nil) ? list : nil;
}
+ (void)wr_setWhitelist:(NSArray<NSString *> *)list {
    NSAssert([self isLocalUsed], @"白名单是在设置 局部使用 该库的情况下使用的");
    objc_setAssociatedObject(self, &kWRWhiteistKey, list, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
+ (NSArray<NSString *> *)blacklist {
    NSArray<NSString *> *list = (NSArray<NSString *> *)objc_getAssociatedObject(self, &kWRBlacklistKey);
    return (list != nil) ? list : nil;
}
+ (void)wr_setBlacklist:(NSArray<NSString *> *)list {
    NSAssert(list, @"list 不能设置为nil");
    NSAssert(![self isLocalUsed], @"黑名单是在设置 广泛使用 该库的情况下使用的");
    objc_setAssociatedObject(self, &kWRBlacklistKey, list, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (BOOL)needUpdateNavigationBar:(UIViewController *)vc {
    NSString *vcStr = NSStringFromClass(vc.class);
    if ([self isLocalUsed]) {
        return [[self whitelist] containsObject:vcStr]; // 当白名单里 有 表示需要更新
    } else {
        return ![[self blacklist] containsObject:vcStr];// 当黑名单里 没有 表示需要更新
    }
}

+ (UIColor *)defaultNavBarBarTintColor {
    UIColor *color = (UIColor *)objc_getAssociatedObject(self, &kWRDefaultNavBarBarTintColorKey);
    return (color != nil) ? color : [UIColor whiteColor];
}
+ (void)wr_setDefaultNavBarBarTintColor:(UIColor *)color {
    objc_setAssociatedObject(self, &kWRDefaultNavBarBarTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (UIImage *)defaultNavBarBackgroundImage {
    UIImage *image = (UIImage *)objc_getAssociatedObject(self, &kWRDefaultNavBarBackgroundImageKey);
    return image;
}
+ (void)wr_setDefaultNavBarBackgroundImage:(UIImage *)image {
    objc_setAssociatedObject(self, &kWRDefaultNavBarBackgroundImageKey, image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (UIColor *)defaultNavBarTintColor {
    UIColor *color = (UIColor *)objc_getAssociatedObject(self, &kWRDefaultNavBarTintColorKey);
    return (color != nil) ? color : [UIColor colorWithRed:0 green:0.478431 blue:1 alpha:1.0];
}
+ (void)wr_setDefaultNavBarTintColor:(UIColor *)color {
    objc_setAssociatedObject(self, &kWRDefaultNavBarTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (UIColor *)defaultNavBarTitleColor {
    UIColor *color = (UIColor *)objc_getAssociatedObject(self, &kWRDefaultNavBarTitleColorKey);
    return (color != nil) ? color : [UIColor blackColor];
}
+ (void)wr_setDefaultNavBarTitleColor:(UIColor *)color {
    objc_setAssociatedObject(self, &kWRDefaultNavBarTitleColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (UIStatusBarStyle)defaultStatusBarStyle {
    id style = objc_getAssociatedObject(self, &kWRDefaultStatusBarStyleKey);
    return (style != nil) ? [style integerValue] : UIStatusBarStyleDefault;
}
+ (void)wr_setDefaultStatusBarStyle:(UIStatusBarStyle)style {
    objc_setAssociatedObject(self, &kWRDefaultStatusBarStyleKey, @(style), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (BOOL)defaultNavBarShadowImageHidden {
    id hidden = objc_getAssociatedObject(self, &kWRDefaultNavBarShadowImageHiddenKey);
    return (hidden != nil) ? [hidden boolValue] : NO;
}
+ (void)wr_setDefaultNavBarShadowImageHidden:(BOOL)hidden {
    objc_setAssociatedObject(self, &kWRDefaultNavBarShadowImageHiddenKey, @(hidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (CGFloat)defaultNavBarBackgroundAlpha {
    return 1.0;
}

//颜色渐变过程产生的颜色
+ (UIColor *)middleColor:(UIColor *)fromColor toColor:(UIColor *)toColor percent:(CGFloat)percent {
    CGFloat fromRed = 0;
    CGFloat fromGreen = 0;
    CGFloat fromBlue = 0;
    CGFloat fromAlpha = 0;
    [fromColor getRed:&fromRed green:&fromGreen blue:&fromBlue alpha:&fromAlpha];
    
    CGFloat toRed = 0;
    CGFloat toGreen = 0;
    CGFloat toBlue = 0;
    CGFloat toAlpha = 0;
    [toColor getRed:&toRed green:&toGreen blue:&toBlue alpha:&toAlpha];
    
    CGFloat newRed = fromRed + (toRed - fromRed) * percent;
    CGFloat newGreen = fromGreen + (toGreen - fromGreen) * percent;
    CGFloat newBlue = fromBlue + (toBlue - fromBlue) * percent;
    CGFloat newAlpha = fromAlpha + (toAlpha - fromAlpha) * percent;
    return [UIColor colorWithRed:newRed green:newGreen blue:newBlue alpha:newAlpha];
}

//透明度渐变过程
+ (CGFloat)middleAlpha:(CGFloat)fromAlpha toAlpha:(CGFloat)toAlpha percent:(CGFloat)percent {
    return fromAlpha + (toAlpha - fromAlpha) * percent;
}

+(void)zx_setNavGradientBacFrom:(UIColor *)fromColor to:(UIColor *)toColor{
//    if(self.zx_navBar){
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1, 0);
        gradientLayer.colors = [NSArray arrayWithObjects:(id)fromColor.CGColor,(id)toColor.CGColor,nil];
    
   
//    if(zx_gradientLayer){
//        if(_zx_gradientLayer){
//            [_zx_gradientLayer removeFromSuperlayer];
//        }
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(CGFLOAT_MIN * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//          //  
//            
//            [self.
//        });
    

    
}

//- (void)zx_setNavGradientBacFrom:(UIColor *)fromColor to:(UIColor *)toColor{
//    if(self.zx_navBar){
//        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
//        gradientLayer.startPoint = CGPointMake(0, 0);
//        gradientLayer.endPoint = CGPointMake(1, 0);
//        gradientLayer.colors = [NSArray arrayWithObjects:(id)fromColor.CGColor,(id)toColor.CGColor,nil];
//        self.zx_navBar.zx_gradientLayer = gradientLayer;
//    }
//    
//}

- (void)setGradientBackgroundWithColors:(NSArray<UIColor *> *)colors {
    // 移除任何现有的渐变层
      CAGradientLayer *existingLayer = objc_getAssociatedObject(self, &kGradientLayerKey);
      if (existingLayer) {
          [existingLayer removeFromSuperlayer];
      }

      // 创建一个新的渐变层
      CAGradientLayer *gradientLayer = [CAGradientLayer layer];
      gradientLayer.frame = self.bounds;

      // 将 UIColor 转换为 CGColor
      NSMutableArray *cgColors = [NSMutableArray array];
      for (UIColor *color in colors) {
          [cgColors addObject:(__bridge id)color.CGColor];
      }
      gradientLayer.colors = cgColors;

      // 可选：设置渐变方向
      gradientLayer.startPoint = CGPointMake(0.0, 0.5);
      gradientLayer.endPoint = CGPointMake(1.0, 0.5);

      // 将渐变层插入到导航栏图层的底部
      [self.layer insertSublayer:gradientLayer atIndex:0];

      // 使用关联对象存储渐变层
      objc_setAssociatedObject(self, &kGradientLayerKey, gradientLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  

}

@end


//=============================================================================
#pragma mark - UINavigationBar
//=============================================================================
@implementation UINavigationBar (WRAddition)

static char kWRBackgroundViewKey;
static char kWRBackgroundImageViewKey;
static char kWRBackgroundImageKey;

- (UIView *)backgroundView {
    return (UIView *)objc_getAssociatedObject(self, &kWRBackgroundViewKey);
}

- (CGRect) backgroundViewFrame {
    //根据真实的状态栏高度来计算
    CGRect barFrame = self.frame;
    CGFloat height = barFrame.origin.y + barFrame.size.height;
    return CGRectMake(0, 0, self.bounds.size.width, height);
}

- (void)setBackgroundView:(UIView *)backgroundView {
    if (backgroundView) {
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wr_keyboardDidShow) name:UIKeyboardDidShowNotification object:nil];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wr_keyboardWillHide) name:UIKeyboardWillHideNotification object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(wr_statusBarFrameDidChange) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
    } else {
//        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
//        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
    }
    objc_setAssociatedObject(self, &kWRBackgroundViewKey, backgroundView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// 解决 presentViewController后 导航栏消失问题
- (void)insertSubview:(UIView *)view atIndex:(NSInteger)index {
    [super insertSubview:view atIndex:index];
    if ([view isKindOfClass:NSClassFromString(@"_UIBarBackground")]) {
        //        view.clipsToBounds = YES;
        if (![view.subviews containsObject:self.backgroundView]) {
            [view insertSubview:self.backgroundView atIndex:0];
        }
    }
}

- (UIImageView *)backgroundImageView {
    return (UIImageView *)objc_getAssociatedObject(self, &kWRBackgroundImageViewKey);
}
- (void)setBackgroundImageView:(UIImageView *)bgImageView {
    objc_setAssociatedObject(self, &kWRBackgroundImageViewKey, bgImageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIImage *)backgroundImage {
    return (UIImage *)objc_getAssociatedObject(self, &kWRBackgroundImageKey);
}
- (void)setBackgroundImage:(UIImage *)image {
    objc_setAssociatedObject(self, &kWRBackgroundImageKey, image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// set navigationBar backgroundImage
- (void)wr_setBackgroundImage:(UIImage *)image {
    [self.backgroundView removeFromSuperview];
    self.backgroundView = nil;
    if (self.backgroundImageView == nil) {
        // add a image(nil color) to _UIBarBackground make it clear
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        if (self.subviews.count > 0) {
            self.backgroundImageView = [[UIImageView alloc] initWithFrame:[self backgroundViewFrame]];
            self.backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            
            // _UIBarBackground is first subView for navigationBar
            [self.subviews.firstObject insertSubview:self.backgroundImageView atIndex:0];
        }
    }else {
        //当已经存在该View的时候, 更新frame, 防止frame不同步
        self.backgroundImageView.frame = [self backgroundViewFrame];
    }
    self.backgroundImage = image;
    self.backgroundImageView.image = image;
}

// set navigationBar barTintColor
- (void)wr_setBackgroundColor:(UIColor *)color {
    [self.backgroundImageView removeFromSuperview];
    self.backgroundImageView = nil;
    self.backgroundImage = nil;
    if (self.backgroundView == nil) {
        // add a image(nil color) to _UIBarBackground make it clear
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.backgroundView = [[UIView alloc] initWithFrame:[self backgroundViewFrame]];
        self.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        // _UIBarBackground is first subView for navigationBar
        [self.subviews.firstObject insertSubview:self.backgroundView atIndex:0];
    }else {
        //当已经存在该View的时候, 更新frame, 防止frame不同步
        self.backgroundView.frame = [self backgroundViewFrame];
    }
    self.backgroundView.backgroundColor = color;
}

- (void)wr_keyboardDidShow {
//    [self wr_restoreUIBarBackgroundFrame];
}
- (void)wr_keyboardWillHide {
//    [self wr_restoreUIBarBackgroundFrame];
}
- (void)wr_restoreUIBarBackgroundFrame {
    // IQKeyboardManager change _UIBarBackground frame sometimes, so I need restore it
    for (UIView *view in self.subviews) {
        Class _UIBarBackgroundClass = NSClassFromString(@"_UIBarBackground");
        if (_UIBarBackgroundClass != nil) {
            if ([view isKindOfClass:_UIBarBackgroundClass]) {
                view.frame = CGRectMake(0, self.frame.size.height-[WRNavigationBar defaultNavBarBottom], [WRNavigationBar screenWidth], [WRNavigationBar defaultNavBarBottom]);
            }
        }
    }
}

// set _UIBarBackground alpha (_UIBarBackground subviews alpha <= _UIBarBackground alpha)
- (void)wr_setBackgroundAlpha:(CGFloat)alpha {
    UIView *barBackgroundView = self.subviews.firstObject;
    if (@available(iOS 11.0, *))
    {   // sometimes we can't change _UIBarBackground alpha
        for (UIView *view in barBackgroundView.subviews) {
            view.alpha = alpha;
        }
    } else {
        barBackgroundView.alpha = alpha;
    }
}

- (void)wr_setBarButtonItemsAlpha:(CGFloat)alpha hasSystemBackIndicator:(BOOL)hasSystemBackIndicator {
    for (UIView *view in self.subviews) {
        if (hasSystemBackIndicator == YES)
        {   // _UIBarBackground/_UINavigationBarBackground对应的view是系统导航栏，不需要改变其透明度
            Class _UIBarBackgroundClass = NSClassFromString(@"_UIBarBackground");
            if (_UIBarBackgroundClass != nil) {
                if ([view isKindOfClass:_UIBarBackgroundClass] == NO) {
                    view.alpha = alpha;
                }
            }
            
            Class _UINavigationBarBackground = NSClassFromString(@"_UINavigationBarBackground");
            if (_UINavigationBarBackground != nil) {
                if ([view isKindOfClass:_UINavigationBarBackground] == NO) {
                    view.alpha = alpha;
                }
            }
        }
        else {
            // 这里如果不做判断的话，会显示 backIndicatorImage
            if ([view isKindOfClass:NSClassFromString(@"_UINavigationBarBackIndicatorView")] == NO) {
                Class _UIBarBackgroundClass = NSClassFromString(@"_UIBarBackground");
                if (_UIBarBackgroundClass != nil) {
                    if ([view isKindOfClass:_UIBarBackgroundClass] == NO) {
                        view.alpha = alpha;
                    }
                }
                
                Class _UINavigationBarBackground = NSClassFromString(@"_UINavigationBarBackground");
                if (_UINavigationBarBackground != nil) {
                    if ([view isKindOfClass:_UINavigationBarBackground] == NO) {
                        view.alpha = alpha;
                    }
                }
            }
        }
    }
}

// 设置导航栏在垂直方向上平移多少距离   CGAffineTransformMakeTranslation  平移
- (void)wr_setTranslationY:(CGFloat)translationY {
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
}

/// 获取当前导航栏在垂直方向上偏移了多少
- (CGFloat)wr_getTranslationY {
    return self.transform.ty;
}

#pragma mark - call swizzling methods active 主动调用交换方法
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL needSwizzleSelectors[1] = {
            @selector(setTitleTextAttributes:)
        };
        //交换设置标题属性的方法
        for (int i = 0; i < 1;  i++) {
            SEL selector = needSwizzleSelectors[i];
            NSString *newSelectorStr = [NSString stringWithFormat:@"wr_%@", NSStringFromSelector(selector)];
            Method originMethod = class_getInstanceMethod(self, selector);
            Method swizzledMethod = class_getInstanceMethod(self, NSSelectorFromString(newSelectorStr));
            method_exchangeImplementations(originMethod, swizzledMethod);
        }
    });
}

- (void)wr_setTitleTextAttributes:(NSDictionary<NSString *,id> *)titleTextAttributes {
    NSMutableDictionary<NSString *,id> *newTitleTextAttributes = [titleTextAttributes mutableCopy];
    if (newTitleTextAttributes == nil) {
        return;
    }
    
    NSDictionary<NSString *,id> *originTitleTextAttributes = self.titleTextAttributes;
    if (originTitleTextAttributes == nil) {
        [self wr_setTitleTextAttributes:newTitleTextAttributes];
        return;
    }
    
    __block UIColor *titleColor;
    [originTitleTextAttributes enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([key isEqual:NSForegroundColorAttributeName]) {
            titleColor = (UIColor *)obj;
            *stop = YES;
        }
    }];
    
    if (titleColor == nil) {
        [self wr_setTitleTextAttributes:newTitleTextAttributes];
        return;
    }
    
    //当新主题没有设置title颜色时使用原有title颜色
    if (newTitleTextAttributes[NSForegroundColorAttributeName] == nil) {
        newTitleTextAttributes[NSForegroundColorAttributeName] = titleColor;
    }
    [self wr_setTitleTextAttributes:newTitleTextAttributes];
}

/**
 当状态栏frame变化的时候, 更新backgroundView的frame
 */
- (void)wr_statusBarFrameDidChange {
    CGRect frame = [self backgroundViewFrame];
    UIView *back = [self backgroundView];
    if (back) {
        back.frame = frame;
    }
    UIView *image = [self backgroundImageView];
    if (image) {
        image.frame = frame;
    }
}

@end

@interface UIViewController (Addition)
- (void)setPushToCurrentVCFinished:(BOOL)isFinished;
@end

//==========================================================================
#pragma mark - UINavigationController
//==========================================================================
@implementation UINavigationController (WRAddition)

static CGFloat wrPopDuration = 0.12;
static int wrPopDisplayCount = 0;
- (CGFloat)wrPopProgress {
    CGFloat all = 60 * wrPopDuration;
    int current = MIN(all, wrPopDisplayCount);
    return current / all;
}

static CGFloat wrPushDuration = 0.10;
static int wrPushDisplayCount = 0;
- (CGFloat)wrPushProgress {
    CGFloat all = 60 * wrPushDuration;
    int current = MIN(all, wrPushDisplayCount);
    return current / all;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return [self.topViewController wr_statusBarStyle];
}

- (void)setNeedsNavigationBarUpdateForBarBackgroundImage:(UIImage *)backgroundImage {
    [self.navigationBar wr_setBackgroundImage:backgroundImage];
}
- (void)setNeedsNavigationBarUpdateForBarTintColor:(UIColor *)barTintColor {
    [self.navigationBar wr_setBackgroundColor:barTintColor];
}
- (void)setNeedsNavigationBarUpdateForBarBackgroundAlpha:(CGFloat)barBackgroundAlpha {
    [self.navigationBar wr_setBackgroundAlpha:barBackgroundAlpha];
}
- (void)setNeedsNavigationBarUpdateForTintColor:(UIColor *)tintColor {
    self.navigationBar.tintColor = tintColor;
}
- (void)setNeedsNavigationBarUpdateForShadowImageHidden:(BOOL)hidden {
    self.navigationBar.shadowImage = (hidden == YES) ? [UIImage new] : nil;
}
- (void)setNeedsNavigationBarUpdateForTitleColor:(UIColor *)titleColor {
    NSDictionary *titleTextAttributes = [self.navigationBar titleTextAttributes];
    if (titleTextAttributes == nil) {
        self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:titleColor};
        return;
    }
    NSMutableDictionary *newTitleTextAttributes = [titleTextAttributes mutableCopy];
    newTitleTextAttributes[NSForegroundColorAttributeName] = titleColor;
    self.navigationBar.titleTextAttributes = newTitleTextAttributes;
}

- (void)updateNavigationBarWithFromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC progress:(CGFloat)progress {
    //下面的判断修复了部分黑名单失效的问题, 是由TZImagePickerController的作者提出来的
    if (![WRNavigationBar needUpdateNavigationBar:toVC]) {
        return;
    }
    // change navBarBarTintColor
    UIColor *fromBarTintColor = [fromVC wr_navBarBarTintColor];
    UIColor *toBarTintColor = [toVC wr_navBarBarTintColor];
    UIColor *newBarTintColor = [WRNavigationBar middleColor:fromBarTintColor toColor:toBarTintColor percent:progress];
    if ([WRNavigationBar needUpdateNavigationBar:fromVC] || [WRNavigationBar needUpdateNavigationBar:toVC]) {
        [self setNeedsNavigationBarUpdateForBarTintColor:newBarTintColor];
    }
    
    // change navBarTintColor
    UIColor *fromTintColor = [fromVC wr_navBarTintColor];
    UIColor *toTintColor = [toVC wr_navBarTintColor];
    UIColor *newTintColor = [WRNavigationBar middleColor:fromTintColor toColor:toTintColor percent:progress];
    if ([WRNavigationBar needUpdateNavigationBar:fromVC]) {
        [self setNeedsNavigationBarUpdateForTintColor:newTintColor];
    }
    
    // change navBarTitleColor（在wr_popToViewController:animated:方法中直接改变标题颜色）
    UIColor *fromTitleColor = [fromVC wr_navBarTitleColor];
    UIColor *toTitleColor = [toVC wr_navBarTitleColor];
    UIColor *newTitleColor = [WRNavigationBar middleColor:fromTitleColor toColor:toTitleColor percent:progress];
    [self setNeedsNavigationBarUpdateForTitleColor:newTitleColor];
    
    // change navBar _UIBarBackground alpha
    CGFloat fromBarBackgroundAlpha = [fromVC wr_navBarBackgroundAlpha];
    CGFloat toBarBackgroundAlpha = [toVC wr_navBarBackgroundAlpha];
    CGFloat newBarBackgroundAlpha = [WRNavigationBar middleAlpha:fromBarBackgroundAlpha toAlpha:toBarBackgroundAlpha percent:progress];
    [self setNeedsNavigationBarUpdateForBarBackgroundAlpha:newBarBackgroundAlpha];
}

#pragma mark - call swizzling methods active 主动调用交换方法
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL needSwizzleSelectors[5] = {
            NSSelectorFromString(@"_updateInteractiveTransition:"),
            @selector(popToViewController:animated:),
            @selector(popToRootViewControllerAnimated:),
            @selector(pushViewController:animated:),
            @selector(popViewControllerAnimated:)
        };
        
        for (int i = 0; i < 5;  i++) {
            SEL selector = needSwizzleSelectors[i];
            NSString *newSelectorStr = [[NSString stringWithFormat:@"wr_%@", NSStringFromSelector(selector)] stringByReplacingOccurrencesOfString:@"__" withString:@"_"];
            Method originMethod = class_getInstanceMethod(self, selector);
            Method swizzledMethod = class_getInstanceMethod(self, NSSelectorFromString(newSelectorStr));
            method_exchangeImplementations(originMethod, swizzledMethod);
        }
    });
}

- (NSArray<UIViewController *> *)wr_popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // pop 的时候直接改变 barTintColor、tintColor
    [self setNeedsNavigationBarUpdateForTitleColor:[viewController wr_navBarTitleColor]];
    [self setNeedsNavigationBarUpdateForTintColor:[viewController wr_navBarTintColor]];
    __block CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(popNeedDisplay)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    [CATransaction setCompletionBlock:^{
        [displayLink invalidate];
        displayLink = nil;
        wrPopDisplayCount = 0;
    }];
    [CATransaction setAnimationDuration:wrPopDuration];
    [CATransaction begin];
    NSArray<UIViewController *> *vcs = [self wr_popToViewController:viewController animated:animated];
    [CATransaction commit];
    return vcs;
}

- (NSArray<UIViewController *> *)wr_popToRootViewControllerAnimated:(BOOL)animated {
    __block CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(popNeedDisplay)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    [CATransaction setCompletionBlock:^{
        [displayLink invalidate];
        displayLink = nil;
        wrPopDisplayCount = 0;
    }];
    [CATransaction setAnimationDuration:wrPopDuration];
    [CATransaction begin];
    NSArray<UIViewController *> *vcs = [self wr_popToRootViewControllerAnimated:animated];
    [CATransaction commit];
    return vcs;
}

- (UIViewController *)wr_popViewControllerAnimated:(BOOL)animated{
    __block CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(popNeedDisplay)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    [CATransaction setCompletionBlock:^{
        [displayLink invalidate];
        displayLink = nil;
        wrPopDisplayCount = 0;
    }];
    [CATransaction setAnimationDuration:wrPopDuration];
    [CATransaction begin];
    UIViewController *vc = [self wr_popViewControllerAnimated:animated];
    [CATransaction commit];
    return vc;
}

// change navigationBar barTintColor smooth before pop to current VC finished
- (void)popNeedDisplay {
    if (self.topViewController != nil && self.topViewController.transitionCoordinator != nil) {
        wrPopDisplayCount += 1;
        CGFloat popProgress = [self wrPopProgress];
        UIViewController *fromVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIViewController *toVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextToViewControllerKey];
        [self updateNavigationBarWithFromVC:fromVC toVC:toVC progress:popProgress];
    }
}

- (void)wr_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    __block CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(pushNeedDisplay)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    [CATransaction setCompletionBlock:^{
        [displayLink invalidate];
        displayLink = nil;
        wrPushDisplayCount = 0;
        [viewController setPushToCurrentVCFinished:YES];
    }];
    [CATransaction setAnimationDuration:wrPushDuration];
    [CATransaction begin];
    [self wr_pushViewController:viewController animated:animated];
    [CATransaction commit];
}

// change navigationBar barTintColor smooth before push to current VC finished or before pop to current VC finished
- (void)pushNeedDisplay {
    if (self.topViewController != nil && self.topViewController.transitionCoordinator != nil) {
        wrPushDisplayCount += 1;
        CGFloat pushProgress = [self wrPushProgress];
        UIViewController *fromVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIViewController *toVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextToViewControllerKey];
        [self updateNavigationBarWithFromVC:fromVC toVC:toVC progress:pushProgress];
    }
}

#pragma mark - deal the gesture of return
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    __weak typeof (self) weakSelf = self;
    id<UIViewControllerTransitionCoordinator> coor = [self.topViewController transitionCoordinator];
    if ([coor initiallyInteractive] == YES) {
        NSString *sysVersion = [[UIDevice currentDevice] systemVersion];
        if ([sysVersion floatValue] >= 10) {
            [coor notifyWhenInteractionChangesUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
                __strong typeof (self) pThis = weakSelf;
                [pThis dealInteractionChanges:context];
            }];
        } else {
            [coor notifyWhenInteractionEndsUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
                __strong typeof (self) pThis = weakSelf;
                [pThis dealInteractionChanges:context];
            }];
        }
        return YES;
    }
    
    NSUInteger itemCount = self.navigationBar.items.count;
    NSUInteger n = self.viewControllers.count >= itemCount ? 2 : 1;
    UIViewController *popToVC = self.viewControllers[self.viewControllers.count - n];
    [self popToViewController:popToVC animated:YES];
    if (@available(iOS 13.0, *)) {
        return NO;
    }
    return YES;
}

// deal the gesture of return break off
- (void)dealInteractionChanges:(id<UIViewControllerTransitionCoordinatorContext>)context {
    void (^animations) (UITransitionContextViewControllerKey) = ^(UITransitionContextViewControllerKey key){
        UIViewController *vc = [context viewControllerForKey:key];
        UIColor *curColor = [vc wr_navBarBarTintColor];
        CGFloat curAlpha = [vc wr_navBarBackgroundAlpha];
        [self setNeedsNavigationBarUpdateForBarTintColor:curColor];
        [self setNeedsNavigationBarUpdateForBarBackgroundAlpha:curAlpha];
    };
    
    // after that, cancel the gesture of return
    if ([context isCancelled] == YES) {
        double cancelDuration = 0;
        [UIView animateWithDuration:cancelDuration animations:^{
            animations(UITransitionContextFromViewControllerKey);
        }];
    } else {
        // after that, finish the gesture of return
        double finishDuration = [context transitionDuration] * (1 - [context percentComplete]);
        [UIView animateWithDuration:finishDuration animations:^{
            animations(UITransitionContextToViewControllerKey);
        }];
    }
}

- (void)wr_updateInteractiveTransition:(CGFloat)percentComplete {
    UIViewController *fromVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextToViewControllerKey];
    [self updateNavigationBarWithFromVC:fromVC toVC:toVC progress:percentComplete];
    [self wr_updateInteractiveTransition:percentComplete];
}

@end


//==========================================================================
#pragma mark - UIViewController
//==========================================================================
@implementation UIViewController (WRAddition)

static char kWRPushToCurrentVCFinishedKey;
static char kWRPushToNextVCFinishedKey;
static char kWRNavBarBackgroundImageKey;
static char kWRNavBarBarTintColorKey;
static char kWRNavBarBackgroundAlphaKey;
static char kWRNavBarTintColorKey;
static char kWRNavBarTitleColorKey;
static char kWRStatusBarStyleKey;
static char kWRNavBarShadowImageHiddenKey;
static char kWRCustomNavBarKey;
static char kWRSystemNavBarBarTintColorKey;
static char kWRSystemNavBarTintColorKey;
static char kWRSystemNavBarTitleColorKey;

// navigationBar barTintColor can not change by currentVC before fromVC push to currentVC finished
- (BOOL)pushToCurrentVCFinished {
    id isFinished = objc_getAssociatedObject(self, &kWRPushToCurrentVCFinishedKey);
    return (isFinished != nil) ? [isFinished boolValue] : NO;
}
- (void)setPushToCurrentVCFinished:(BOOL)isFinished {
    objc_setAssociatedObject(self, &kWRPushToCurrentVCFinishedKey, @(isFinished), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// navigationBar barTintColor can not change by currentVC when currentVC push to nextVC finished
- (BOOL)pushToNextVCFinished {
    id isFinished = objc_getAssociatedObject(self, &kWRPushToNextVCFinishedKey);
    return (isFinished != nil) ? [isFinished boolValue] : NO;
}
- (void)setPushToNextVCFinished:(BOOL)isFinished {
    objc_setAssociatedObject(self, &kWRPushToNextVCFinishedKey, @(isFinished), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// navigationBar backgroundImage
- (UIImage *)wr_navBarBackgroundImage {
    UIImage *image = (UIImage *)objc_getAssociatedObject(self, &kWRNavBarBackgroundImageKey);
    image = (image == nil) ? [WRNavigationBar defaultNavBarBackgroundImage] : image;
    return image;
}
- (void)wr_setNavBarBackgroundImage:(UIImage *)image {
    if ([[self wr_customNavBar] isKindOfClass:[UINavigationBar class]]) {
        //  UINavigationBar *navBar = (UINavigationBar *)[self wr_customNavBar];
        //  [navBar wr_setBackgroundImage:image];
    } else {
        objc_setAssociatedObject(self, &kWRNavBarBackgroundImageKey, image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

// navigationBar systemBarTintColor
- (UIColor *)wr_systemNavBarBarTintColor {
    return (UIColor *)objc_getAssociatedObject(self, &kWRSystemNavBarBarTintColorKey);
}
- (void)wr_setSystemNavBarBarTintColor:(UIColor *)color {
    objc_setAssociatedObject(self, &kWRSystemNavBarBarTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)wr_navBarBarTintColor {
    UIColor *barTintColor = (UIColor *)objc_getAssociatedObject(self, &kWRNavBarBarTintColorKey);
    if (![WRNavigationBar needUpdateNavigationBar:self]) {
        if ([self wr_systemNavBarBarTintColor] == nil) {
            barTintColor = self.navigationController.navigationBar.barTintColor;
        } else {
            barTintColor = [self wr_systemNavBarBarTintColor];
        }
    }
    return (barTintColor != nil) ? barTintColor : [WRNavigationBar defaultNavBarBarTintColor];
}
- (void)wr_setNavBarBarTintColor:(UIColor *)color {
    objc_setAssociatedObject(self, &kWRNavBarBarTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([[self wr_customNavBar] isKindOfClass:[UINavigationBar class]]) {
        //  UINavigationBar *navBar = (UINavigationBar *)[self wr_customNavBar];
        //  [navBar wr_setBackgroundColor:color];
    } else {
        BOOL isRootViewController = (self.navigationController.viewControllers.firstObject == self);
        if (([self pushToCurrentVCFinished] == YES || isRootViewController == YES) && [self pushToNextVCFinished] == NO) {
            [self.navigationController setNeedsNavigationBarUpdateForBarTintColor:color];
        }
    }
}

// navigationBar _UIBarBackground alpha
- (CGFloat)wr_navBarBackgroundAlpha {
    id barBackgroundAlpha = objc_getAssociatedObject(self, &kWRNavBarBackgroundAlphaKey);
    return (barBackgroundAlpha != nil) ? [barBackgroundAlpha floatValue] : [WRNavigationBar defaultNavBarBackgroundAlpha];
}
- (void)wr_setNavBarBackgroundAlpha:(CGFloat)alpha {
    objc_setAssociatedObject(self, &kWRNavBarBackgroundAlphaKey, @(alpha), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([[self wr_customNavBar] isKindOfClass:[UINavigationBar class]]) {
        //  UINavigationBar *navBar = (UINavigationBar *)[self wr_customNavBar];
        //  [navBar wr_setBackgroundAlpha:alpha];
    } else {
        BOOL isRootViewController = (self.navigationController.viewControllers.firstObject == self);
        if (([self pushToCurrentVCFinished] == YES || isRootViewController == YES) && [self pushToNextVCFinished] == NO) {
            [self.navigationController setNeedsNavigationBarUpdateForBarBackgroundAlpha:alpha];
        }
    }
}

// navigationBar systemTintColor
- (UIColor *)wr_systemNavBarTintColor {
    return (UIColor *)objc_getAssociatedObject(self, &kWRSystemNavBarTintColorKey);
}
- (void)wr_setSystemNavBarTintColor:(UIColor *)color {
    objc_setAssociatedObject(self, &kWRSystemNavBarTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// navigationBar tintColor
- (UIColor *)wr_navBarTintColor {
    UIColor *tintColor = (UIColor *)objc_getAssociatedObject(self, &kWRNavBarTintColorKey);
    if (![WRNavigationBar needUpdateNavigationBar:self]) {
        if ([self wr_systemNavBarTintColor] == nil) {
            tintColor = self.navigationController.navigationBar.tintColor;
        } else {
            tintColor = [self wr_systemNavBarTintColor];
        }
    }
    return (tintColor != nil) ? tintColor : [WRNavigationBar defaultNavBarTintColor];
}
- (void)wr_setNavBarTintColor:(UIColor *)color {
    objc_setAssociatedObject(self, &kWRNavBarTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([[self wr_customNavBar] isKindOfClass:[UINavigationBar class]]) {
        //  UINavigationBar *navBar = (UINavigationBar *)[self wr_customNavBar];
        //  navBar.tintColor = color;
    } else {
        if ([self pushToNextVCFinished] == NO) {
            [self.navigationController setNeedsNavigationBarUpdateForTintColor:color];
        }
    }
}

// navigationBar systemTitleColor
- (UIColor *)wr_systemNavBarTitleColor {
    return (UIColor *)objc_getAssociatedObject(self, &kWRSystemNavBarTitleColorKey);
}
- (void)wr_setSystemNavBarTitleColor:(UIColor *)color {
    objc_setAssociatedObject(self, &kWRSystemNavBarTitleColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// navigationBarTitleColor
- (UIColor *)wr_navBarTitleColor {
    UIColor *titleColor = (UIColor *)objc_getAssociatedObject(self, &kWRNavBarTitleColorKey);
    if (![WRNavigationBar needUpdateNavigationBar:self]) {
        if ([self wr_systemNavBarTitleColor] == nil) {
            titleColor = self.navigationController.navigationBar.titleTextAttributes[@"NSColor"];
        } else {
            titleColor = [self wr_systemNavBarTitleColor];
        }
    }
    return (titleColor != nil) ? titleColor : [WRNavigationBar defaultNavBarTitleColor];
}
- (void)wr_setNavBarTitleColor:(UIColor *)color {
    objc_setAssociatedObject(self, &kWRNavBarTitleColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([[self wr_customNavBar] isKindOfClass:[UINavigationBar class]]) {
        //  UINavigationBar *navBar = (UINavigationBar *)[self wr_customNavBar];
        //  navBar.titleTextAttributes = @{NSForegroundColorAttributeName:color};
    } else {
        if ([self pushToNextVCFinished] == NO) {
            [self.navigationController setNeedsNavigationBarUpdateForTitleColor:color];
        }
    }
}

// statusBarStyle
- (UIStatusBarStyle)wr_statusBarStyle {
    id style = objc_getAssociatedObject(self, &kWRStatusBarStyleKey);
    return (style != nil) ? [style integerValue] : [WRNavigationBar defaultStatusBarStyle];
}
- (void)wr_setStatusBarStyle:(UIStatusBarStyle)style {
    objc_setAssociatedObject(self, &kWRStatusBarStyleKey, @(style), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setNeedsStatusBarAppearanceUpdate];
}

// shadowImage
- (void)wr_setNavBarShadowImageHidden:(BOOL)hidden {
    objc_setAssociatedObject(self, &kWRNavBarShadowImageHiddenKey, @(hidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self.navigationController setNeedsNavigationBarUpdateForShadowImageHidden:hidden];
}
- (BOOL)wr_navBarShadowImageHidden {
    id hidden = objc_getAssociatedObject(self, &kWRNavBarShadowImageHiddenKey);
    return (hidden != nil) ? [hidden boolValue] : [WRNavigationBar defaultNavBarShadowImageHidden];
}

// custom navigationBar
- (UIView *)wr_customNavBar {
    UIView *navBar = objc_getAssociatedObject(self, &kWRCustomNavBarKey);
    return (navBar != nil) ? navBar : [UIView new];
}
- (void)wr_setCustomNavBar:(UINavigationBar *)navBar {
    objc_setAssociatedObject(self, &kWRCustomNavBarKey, navBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL needSwizzleSelectors[4] = {
            @selector(viewWillAppear:),
            @selector(viewWillDisappear:),
            @selector(viewDidAppear:),
            @selector(viewDidDisappear:)
        };
        
        for (int i = 0; i < 4;  i++) {
            SEL selector = needSwizzleSelectors[i];
            NSString *newSelectorStr = [NSString stringWithFormat:@"wr_%@", NSStringFromSelector(selector)];
            Method originMethod = class_getInstanceMethod(self, selector);
            Method swizzledMethod = class_getInstanceMethod(self, NSSelectorFromString(newSelectorStr));
            method_exchangeImplementations(originMethod, swizzledMethod);
        }
    });
}

- (void)wr_viewWillAppear:(BOOL)animated {
    if ([self canUpdateNavigationBar]) {
        if (![WRNavigationBar needUpdateNavigationBar:self]) {
            if ([self wr_systemNavBarBarTintColor] == nil) {
                [self wr_setSystemNavBarBarTintColor:[self wr_navBarBarTintColor]];
            }
            if ([self wr_systemNavBarTintColor] == nil) {
                [self wr_setSystemNavBarTintColor:[self wr_navBarTintColor]];
            }
            if ([self wr_systemNavBarTitleColor] == nil) {
                [self wr_setSystemNavBarTitleColor:[self wr_navBarTitleColor]];
            }
            [self.navigationController setNeedsNavigationBarUpdateForTintColor:[self wr_navBarTintColor]];
        }
        [self setPushToNextVCFinished:NO];
        [self.navigationController setNeedsNavigationBarUpdateForTitleColor:[self wr_navBarTitleColor]];
    }
    [self wr_viewWillAppear:animated];
}

- (void)wr_viewWillDisappear:(BOOL)animated {
    if ([self canUpdateNavigationBar] == YES) {
        [self setPushToNextVCFinished:YES];
    }
    [self wr_viewWillDisappear:animated];
}

- (void)wr_viewDidAppear:(BOOL)animated
{
    if ([self isRootViewController] == NO) {
        self.pushToCurrentVCFinished = YES;
    }
    if ([self canUpdateNavigationBar] == YES)
    {
        UIImage *barBgImage = [self wr_navBarBackgroundImage];
        if (barBgImage != nil) {
            [self.navigationController setNeedsNavigationBarUpdateForBarBackgroundImage:barBgImage];
        } else {
            if ([WRNavigationBar needUpdateNavigationBar:self]) {
                [self.navigationController setNeedsNavigationBarUpdateForBarTintColor:[self wr_navBarBarTintColor]];
            }
        }
        [self.navigationController setNeedsNavigationBarUpdateForBarBackgroundAlpha:[self wr_navBarBackgroundAlpha]];
        [self.navigationController setNeedsNavigationBarUpdateForTintColor:[self wr_navBarTintColor]];
        [self.navigationController setNeedsNavigationBarUpdateForTitleColor:[self wr_navBarTitleColor]];
        [self.navigationController setNeedsNavigationBarUpdateForShadowImageHidden:[self wr_navBarShadowImageHidden]];
    }
    [self wr_viewDidAppear:animated];
}

- (void)wr_viewDidDisappear:(BOOL)animated {
    if (![WRNavigationBar needUpdateNavigationBar:self] && !self.navigationController) {
        [self wr_setSystemNavBarBarTintColor:nil];
        [self wr_setSystemNavBarTintColor:nil];
        [self wr_setSystemNavBarTitleColor:nil];
    }
    [self wr_viewDidDisappear:animated];
}

- (BOOL)canUpdateNavigationBar {
    return [self.navigationController.viewControllers containsObject:self];
}

- (BOOL)isRootViewController
{
    UIViewController *rootViewController = self.navigationController.viewControllers.firstObject;
    if ([rootViewController isKindOfClass:[UITabBarController class]] == NO) {
        return rootViewController == self;
    } else {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        return [tabBarController.viewControllers containsObject:self];
    }
}


@end
