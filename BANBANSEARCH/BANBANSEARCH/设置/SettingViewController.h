//
//  SettingViewController.h
//  BANBANSEARCH
//
//  Created by apple on 2025/4/7.
//

#import <UIKit/UIKit.h>
#import "UIViewController+MMDrawerController.h"
#import "ResignViewController.h"
#import "AccountTool.h"
#define WIDTH ([UIScreen mainScreen].bounds.size.width)
#define HEIGHT ([UIScreen mainScreen].bounds.size.height)
NS_ASSUME_NONNULL_BEGIN

@interface SettingViewController : UIViewController
@property (nonatomic, copy) void (^LoginClickBlock) (NSDictionary *dic);
@end

NS_ASSUME_NONNULL_END
