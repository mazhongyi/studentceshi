//
//  CYLHomeViewController.m
//  CYLTabBarController
//
//  v1.21.x Created by 微博@iOS程序犭袁 ( http://weibo.com/luohanchenyilong/ ) on 10/20/15.
//  Copyright © 2018 https://github.com/ChenYilong . All rights reserved.
//

#import "CYLHomeViewController.h"
//#import "CYLTabBarControllerConfig.h"
//#import "CYLPlusButtonSubclass.h"
#import "MainTabBarController.h"
//#import "CYLMainRootViewController.h"
//#import <MJRefresh/MJRefresh.h>
@interface CYLHomeViewController() <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *data;

@end
@implementation CYLHomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 初始化示例数据
    self.data = @[@"Item 1", @"Item 2", @"Item 3", @"Item 4", @"Item 5", @"Item 5", @"Item 5", @"Item 5", @"Item 5", @"Item 5", @"Item 5", @"Item 5", @"Item 5", @"Item 5", @"Item 5", @"Item 5", @"Item 5", @"Item 5", @"Item 5", @"Item 5", @"Item 5", @"Item 5", @"Item 5", @"Item 5", @"Item 5", @"Item 5", @"Item 5", @"Item 5", @"Item 5"];
    
    // 创建并设置TableView
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
    
    
    
    
//    [UITabBar appearance].translucent = false;
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = self.data[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"You selected cell number: %ld", (long)indexPath.row);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
















//#pragma mark - View lifecycle
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    self.zx_navBarBackgroundColor = [UIColor orangeColor];
//    self.view.backgroundColor = [UIColor greenColor];
//    
//    
//    
////    self.view.backgroundColor = [UIColor whiteColor];
////    self.navigationItem.title = @"首页(3)"; //✅sets navigation bar title.The right way to set the title of the navigation
////    self.tabBarItem.title = @"首页";   //❌sets tab bar title. Even the `tabBarItem.title` changed, this will be ignored in tabbar.
//    //self.title = @"首页1";                //❌sets both of these. Do not do this‼️‼️This may cause something strange like this : http://i68.tinypic.com/282l3x4.jpg .
////    [self.navigationController.tabBarItem setBadgeValue:@"3"];
////    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"refresh TabBar" style:UIBarButtonItemStylePlain target:self action:@selector(refreshTabBar:)];
////    __weak __typeof(self) weakSelf = self;
////    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
////        //Call this Block When enter the refresh status automatically
////        NSUInteger delaySeconds = 1;
////        dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delaySeconds * NSEC_PER_SEC));
////        dispatch_after(when, dispatch_get_main_queue(), ^{
////            [weakSelf.tableView.mj_header endRefreshing];
////        });
////    }];
//    
////    if (@available(iOS 15.0, *)) {
////            UINavigationBarAppearance *appperance = [[UINavigationBarAppearance alloc] init];
////            //添加背景色
////            appperance.backgroundColor = [UIColor redColor];
////            appperance.shadowImage = [[UIImage alloc]init];
////            appperance.shadowColor = nil;
////            //设置字体颜色大小
//////            [appperance setTitleTextAttributes:@{NSForegroundColorAttributeName:k_title_color,NSFontAttributeName:TEXT_BIG_S_FONT18}];
////            self.navigationController.navigationBar.standardAppearance = appperance;
////            self.navigationController.navigationBar.scrollEdgeAppearance = appperance;
////            self.navigationController.navigationBar.compactAppearance = appperance;
////            self.navigationController.navigationBar.compactScrollEdgeAppearance = appperance;
////        }
//}
//
//- (void)refresh {
////    [self.tableView.mj_header beginRefreshing];
////    NSUInteger delaySeconds = 1;
////    dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delaySeconds * NSEC_PER_SEC));
////    dispatch_after(when, dispatch_get_main_queue(), ^{
////        [self.tableView.mj_header endRefreshing];
////    });
//}
//
//- (void)refreshTabBar:(id)sender {
//    [self createNewTabBardynamically];
//}
//
//- (void)createNewTabBardynamically {
////    id<UIApplicationDelegate> delegate = ((id<UIApplicationDelegate>)[[UIApplication sharedApplication] delegate]);
////    UIWindow *window = delegate.window;
////    CYLMainRootViewController *rootController = (CYLMainRootViewController *)window.rootViewController;
////    [rootController createNewTabBarWithContext:NSStringFromClass([self class])];
//}
//
//#pragma mark - Methods
//
//- (void)configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
//    [[cell textLabel] setText:[NSString stringWithFormat:@"%@ CYLTabBarController %@", self.tabBarItem.title, @(indexPath.row)]];
//}
//
//#pragma mark - Table view
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString * CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
//    [self configureCell:cell forIndexPath:indexPath];
//    return cell;
//}
//
//#pragma mark - UINavigationControllerDelegate
//
//- (void)navigationController:(UINavigationController *)navigationController
//       didShowViewController:(UIViewController *)viewController
//                    animated:(BOOL)animate {
//    if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//        if ([navigationController.viewControllers count] == 1) {
//            navigationController.interactivePopGestureRecognizer.enabled = NO;
//        } else {
//            navigationController.interactivePopGestureRecognizer.enabled = YES;
//        }
//    }
//}
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 30;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    NSNumber *badgeNumber = @(indexPath.row);
//    self.navigationItem.title = [NSString stringWithFormat:@"首页(%@)", badgeNumber]; //sets navigation bar title.
//    
////    [self.navigationController.tabBarItem setBadgeValue:[NSString stringWithFormat:@"%@", badgeNumber]];
//    
////    CYLTabBarControllerConfig *tabBarControllerConfig = [[CYLTabBarControllerConfig alloc] init];
////    CYLTabBarController *tabBarController = tabBarControllerConfig.tabBarController;
////    tabBarController.delegate = self;
////
//    [self cyl_showBadgeValue:[NSString stringWithFormat:@"%@", @(indexPath.row)] animationType:CYLBadgeAnimationTypeScale];
//    [self pushToNewViewController];
//}
//
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self pushToNewViewController];
//}
//
//- (void)pushToNewViewController {
////    CYLBaseViewController *viewController = [CYLBaseViewController new];
////    viewController.view.backgroundColor = [UIColor orangeColor];
////    [viewController cyl_setNavigationBarHidden:YES];
////    [self.navigationController  pushViewController:viewController animated:YES];
//}

@end
