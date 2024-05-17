//
//  AppDelegate.m
//  opsddddddd
//
//  Created by mazhongyi on 2024/5/15.
//

#import "AppDelegate.h"
//#import "CYLPlusButtonSubclass.h"
#import "CustomTabBarController.h"

#import "ZXNavigationBarNavigationController.h"
#import "CYLHomeViewController.h"



@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    [UIApplication sharedApplication].statusBarHidden = NO;
////    [self setUpNavigationBarAppearance];
//    // 设置主窗口,并设置根控制器
//    self.window = [[UIWindow alloc] init];
//    self.window.frame = [UIScreen mainScreen].bounds;
//   
//    CustomTabBarController *rootViewController = [[CustomTabBarController alloc] init];
//    [self.window setRootViewController:rootViewController];
//    [self.window makeKeyAndVisible];
    //    ZXNavigationBarNavigationController *nav = [[ZXNavigationBarNavigationController alloc]initWithRootViewController:vc];
    
    UIWindow *window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    CustomTabBarController *vc = [[CustomTabBarController alloc]init];
//    ZXNavigationBarNavigationController *nav = [[ZXNavigationBarNavigationController alloc]initWithRootViewController:vc];
    window.rootViewController = vc;
    [window makeKeyAndVisible];
    self.window = window;
    return YES;
  
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wmethod-signatures"
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
//    //设置强制旋转屏幕
//    if (self.cyl_isForceLandscape) {
//        //只支持横屏
//        return UIInterfaceOrientationMaskLandscape;
//    } else {
//        //只支持竖屏
        return UIInterfaceOrientationMaskPortrait;
   // }
}
#pragma clang diagnostic pop

/**
 *  设置navigationBar样式
 */
- (void)setUpNavigationBarAppearance {
    
//    if(@available(iOS 15.0,*)){
//           UINavigationBarAppearance * appearance = [[UINavigationBarAppearance alloc] init];
//           [appearance setBackgroundImage:[UIImage imageNamed:@"NavBar64"]];
//           [appearance setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:24 weight:UIFontWeightBold]}];
//           self.navigationBar.standardAppearance = appearance;
//           self.navigationBar.scrollEdgeAppearance = appearance;
//       }else{
//           [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavBar64"] forBarMetrics:UIBarMetricsDefault];
//           [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:24 weight:UIFontWeightBold]}];
//           
//           [self.navigationBar setTintColor:UIColor.whiteColor];
//       }
    
//    if (@available(iOS 15.0,*)) {
//        UINavigationBarAppearance *apperance = [[UINavigationBarAppearance alloc]init];
//        apperance.backgroundColor = [UIColor redColor];
//        apperance.shadowImage = [[UIImage alloc]init];
//        apperance.shadowColor = nil;
//        
//        [apperance setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
//        self.
//        
//        
//    }
    
    
    
//    // 获取UINavigationBar外观代理
//    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
//
//    // 设置背景颜色
//    UIColor *backgroundColor = [UIColor grayColor];
//
//    // 设置文字属性
//    NSDictionary *textAttributes = @{
//        NSFontAttributeName : [UIFont boldSystemFontOfSize:18],
//        NSForegroundColorAttributeName : [UIColor blackColor]
//    };
//
//    // 设置导航栏背景颜色
//    [navigationBarAppearance setBarTintColor:backgroundColor];
//
//    // 设置导航栏标题文字属性
//    [navigationBarAppearance setTitleTextAttributes:textAttributes];
//
//    // 设置导航栏按钮颜色
//    [navigationBarAppearance setTintColor:[UIColor blackColor]];
//
//    // 设置导航栏为不透明
//    [navigationBarAppearance setTranslucent:NO];
//    
//    
//    UIImage *backgroundImage = [self imageWithColor:[UIColor grayColor]];
//    [navigationBarAppearance setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
//    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
//    UIColor *backgroundColor = [UIColor grayColor];
//    NSDictionary *textAttributes = nil;
//    UIColor *labelColor =   [UIColor blackColor];
//    [navigationBarAppearance setTranslucent:NO];
//    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
//        textAttributes = @{
//                           NSFontAttributeName : [UIFont boldSystemFontOfSize:18],
//                           NSForegroundColorAttributeName : labelColor,
//                           };
//    } else {
//#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
//        textAttributes = @{
//                           UITextAttributeFont : [UIFont boldSystemFontOfSize:18],
//                           UITextAttributeTextColor : labelColor,
//                           UITextAttributeTextShadowColor : [UIColor clearColor],
//                           UITextAttributeTextShadowOffset : [NSValue valueWithUIOffset:UIOffsetZero],
//                           };
//#endif
//    }
//    [navigationBarAppearance setBarTintColor:backgroundColor];
//    [navigationBarAppearance setTitleTextAttributes:textAttributes];
}
// Helper method to create an image with a specific color
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
