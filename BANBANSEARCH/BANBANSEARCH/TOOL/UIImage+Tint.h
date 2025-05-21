//
//  UIImage+Tint.h
//  BANBANSEARCH
//
//  Created by apple on 2025/5/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Tint)
- (UIImage *)imageWithTintColors:(UIColor *)tintColor;
- (UIImage *)imageWithGradientTintColor:(UIColor *)tintColor;
+ (UIImage *)imagewithImage:(UIImage *)image;
@end

NS_ASSUME_NONNULL_END
