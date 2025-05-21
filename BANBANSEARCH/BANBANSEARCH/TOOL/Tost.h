//
//  Tost.h
//  BANBANSEARCH
//
//  Created by apple on 2025/4/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
#define ToastShow(s,a,r) [Tost showText:s withImgName:a color:r]
#define WIDTH ([UIScreen mainScreen].bounds.size.width)
#define HEIGHT ([UIScreen mainScreen].bounds.size.height)
@interface Tost : NSObject
+ (void)showText:(NSString *)text withImgName:(NSString *)imgName color:(UIColor *)color;
+ (void)showText:(NSString *)text inView:(UIView *)view withImgName:(NSString *)imgName color:(UIColor *)color;
+ (void)showText:(NSString *)text yOffset:(float)yOffset withImgName:(NSString *)imgName color:(UIColor *)color;
+ (void)showText:(NSString *)text inView:(UIView *_Nullable)view yOffset:(float)yOffset withImgName:(NSString *)imgName color:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
