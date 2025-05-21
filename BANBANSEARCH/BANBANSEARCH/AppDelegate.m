//
//  AppDelegate.m
//  BANBANSEARCH
//
//  Created by apple on 2025/4/7.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    ViewController *mainVc = [[ViewController alloc] init];
    UINavigationController *mainNavi = [[UINavigationController alloc] initWithRootViewController:mainVc];
    
//    SettingViewController *setVc = [[SettingViewController alloc] init];
//    UINavigationController *setNavi = [[UINavigationController alloc] initWithRootViewController:setVc];
//    MMDrawerController *rootVC = [[MMDrawerController alloc] initWithCenterViewController:mainNavi leftDrawerViewController:setNavi];
//    
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = mainNavi;
    [self.window makeKeyWindow];
    [GMSServices provideAPIKey:@"AIzaSyCgIm-9V6TUfffovsH-KR8Ykz60xd-2w9M"];
//    [GMSPlacesClient provideAPIKey:@"AIzaSyDH-PMsWfvGWxjZtP2GeyUonZgwi27iFME"];
//    self.servicesHandle = [GMSServices sharedServices];
    [self setIqkeyboardmanager:YES];
    
    return YES;
}

- (void)setIqkeyboardmanager:(BOOL)enable {
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enableAutoToolbar = enable;
    manager.shouldResignOnTouchOutside = enable;
    manager.enable = enable;
}


@end
