//
//  MBProgressHUD+JH.h
//  masaLiveNewApp
//
//  Created by ccc on 2023/12/18.
//

#import "MBProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN

@interface MBProgressHUD (JH)
+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;
+ (void)showError:(NSString *)error;

+ (MBProgressHUD *)showMessage:(NSString *)message;
#pragma mark 显示一些信息
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;
@end

NS_ASSUME_NONNULL_END
