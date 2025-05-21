//
//  Tool.h
//  BANBANSEARCH
//
//  Created by apple on 2025/4/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Tool : NSObject
#pragma mark -根据宽度求高度
+ (CGFloat)getLabelHeightWithText:(NSString *)text width:(CGFloat)width font: (CGFloat)font;
#pragma mark -根据高度求宽度
+ (CGFloat)getLabelWidthWithText:(NSString *)text height:(CGFloat)height font: (CGFloat)font;
+ (CGFloat)getLabelWidthWithText:(NSString *)text height:(CGFloat)height custonfont: (UIFont *)font;
- (UIImage*)convertImageToGreyScale:(UIImage*) image;
+(CLLocationCoordinate2D)transformFromWGSToGCJ:(CLLocationCoordinate2D)wgsLoc;
+(BOOL)isLocationOutOfChina:(CLLocationCoordinate2D)location;
@end

NS_ASSUME_NONNULL_END
