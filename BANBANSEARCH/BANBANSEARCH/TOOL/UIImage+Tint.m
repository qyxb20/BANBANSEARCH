//
//  UIImage+Tint.m
//  BANBANSEARCH
//
//  Created by apple on 2025/5/6.
//

#import "UIImage+Tint.h"

@implementation UIImage (Tint)

- (UIImage *)imageWithTintColors:(UIColor *)tintColor
{
    return [self imageWithTintColor:tintColor blendMode:kCGBlendModeDestinationIn];
}
 
- (UIImage *)imageWithGradientTintColor:(UIColor *)tintColor
{
    return [self imageWithTintColor:tintColor blendMode:kCGBlendModeOverlay];
}
 
- (UIImage *)imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode
{
    //We want to keep alpha, set opaque to NO; Use 0.0f for scale to use the scale factor of the device’s main screen.
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [tintColor setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
 
    //Draw the tinted image in context
    [self drawInRect:bounds blendMode:blendMode alpha:1.0f];
 
    if (blendMode != kCGBlendModeDestinationIn) {
        [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    }
 
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
 
    return tintedImage;
}

+ (UIImage *)imagewithImage:(UIImage *)image

{

CGFloat width = image.size.width;

//因为实际的截图还是系统的剪切框截出来的图片,所以这里处理成我们自己实际需要的比例

CGFloat resultH = (width - 36) * 160 / 375;

CGFloat height = image.size.height;

CGRect rect = CGRectMake(0, (height - resultH) * 0.5, width, resultH);

CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], rect);

UIImage *thumbScale = [UIImage imageWithCGImage:imageRef];

CGImageRelease(imageRef);

return thumbScale;

}
@end
