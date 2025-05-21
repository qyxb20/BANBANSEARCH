//
//  ShopManagerViewController.h
//  BANBANSEARCH
//
//  Created by apple on 2025/4/14.
//

#import <UIKit/UIKit.h>
#import "SaveManager.h"
#import "ShopManagerTableViewCell.h"
#import "UIButton+tool.h"
#import "ResignViewController.h"
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
NS_ASSUME_NONNULL_BEGIN

@interface ShopManagerViewController : UIViewController

@end

NS_ASSUME_NONNULL_END
