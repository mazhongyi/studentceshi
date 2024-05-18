//
//  CustomTabBarController.m
//  opsddddddd
//
//  Created by mazhongyi on 2024/5/16.
//
#import "CustomTabBarController.h"
#import <CYLTabBarController/CYLTabBarController.h>
#import "MainTabBarController.h"
#import "CYLPlusButtonSubclass.h"

@implementation CustomTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBarHidden = YES;
    [self createNewTabBar];
}

- (CYLTabBarController *)createNewTabBar {
    [CYLPlusButtonSubclass registerPlusButton];
    return [self createNewTabBarWithContext:nil];
}

- (CYLTabBarController *)createNewTabBarWithContext:(NSString *)context {
    MainTabBarController *tabBarController = [[MainTabBarController alloc] initWithContext:context];
    self.viewControllers = @[tabBarController];
    return tabBarController;
}

@end
