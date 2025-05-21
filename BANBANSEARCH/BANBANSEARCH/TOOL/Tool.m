//
//  Tool.m
//  BANBANSEARCH
//
//  Created by apple on 2025/4/14.
//

#import "Tool.h"
const double a = 6378245.0;
const double ee = 0.00669342162296594323;
const double pi = 3.14159265358979324;

@implementation Tool
#pragma mark -根据宽度求高度
/**
 @param text 计算的内容
 @param width 计算的宽度
 @param font font字体大小
 @return 放回label的高度
 */
 
+ (CGFloat)getLabelHeightWithText:(NSString *)text width:(CGFloat)width font: (CGFloat)font
 
{
 
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
 
                                     options:NSStringDrawingUsesLineFragmentOrigin
 
                                  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil];
 
    
  
    return rect.size.height;
 
}
#pragma mark -根据高度求宽度
/**
 @param text 计算的内容
 @param height 计算的高度
 @param font font字体大小
 @return 放回label的宽度
 */
+ (CGFloat)getLabelWidthWithText:(NSString *)text height:(CGFloat)height font: (CGFloat)font
 
{
 
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
 
                                     options:NSStringDrawingUsesLineFragmentOrigin
 
                                  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil];
 
    
 
    return rect.size.width;
 
}
+ (CGFloat)getLabelWidthWithText:(NSString *)text height:(CGFloat)height custonfont: (UIFont *)font
 
{
 
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
 
                                     options:NSStringDrawingUsesLineFragmentOrigin
 
                                  attributes:@{NSFontAttributeName:font} context:nil];
 
    
 
    return rect.size.width;
 
}
- (UIImage*)convertImageToGreyScale:(UIImage*) image
{
    // Create image rectangle with current image width/height
    CGRect imageRect = CGRectMake(0, 0, image.size.width, image.size.height);
    
    // Grayscale color space
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    
    // Create bitmap content with current image size and grayscale colorspace
    CGContextRef context = CGBitmapContextCreate(nil, image.size.width, image.size.height, 8, 0, colorSpace, kCGImageAlphaNone);
    
    // Draw image into current context, with specified rectangle
    // using previously defined context (with grayscale colorspace)
    CGContextDrawImage(context, imageRect, [image CGImage]);
    
    // Create bitmap image info from pixel data in current context
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    
    // Create a new UIImage object
    UIImage *newImage = [UIImage imageWithCGImage:imageRef];
    
    // Release colorspace, context and bitmap information
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    CFRelease(imageRef);
    
    // Return the new grayscale image
    return newImage;
}

+(CLLocationCoordinate2D)transformFromWGSToGCJ:(CLLocationCoordinate2D)wgsLoc
{
    CLLocationCoordinate2D adjustLoc;
    if([self isLocationOutOfChina:wgsLoc]){
        adjustLoc = wgsLoc;
    }else{
        double adjustLat = [self transformLatWithX:wgsLoc.longitude - 105.0 withY:wgsLoc.latitude - 35.0];
        double adjustLon = [self transformLonWithX:wgsLoc.longitude - 105.0 withY:wgsLoc.latitude - 35.0];
        double radLat = wgsLoc.latitude / 180.0 * pi;
        double magic = sin(radLat);
        magic = 1 - ee * magic * magic;
        double sqrtMagic = sqrt(magic);
        adjustLat = (adjustLat * 180.0) / ((a * (1 - ee)) / (magic * sqrtMagic) * pi);
        adjustLon = (adjustLon * 180.0) / (a / sqrtMagic * cos(radLat) * pi);
        adjustLoc.latitude = wgsLoc.latitude + adjustLat;
        adjustLoc.longitude = wgsLoc.longitude + adjustLon;
    }
    return adjustLoc;
}
  
//判断是不是在中国
+(BOOL)isLocationOutOfChina:(CLLocationCoordinate2D)location
{
    if (location.longitude < 72.004 || location.longitude > 137.8347 || location.latitude < 0.8293 || location.latitude > 55.8271)
        return YES;
    return NO;
}
  
+(double)transformLatWithX:(double)x withY:(double)y
{
    double lat = -100.0 + 2.0 * x + 3.0 * y + 0.2 * y * y + 0.1 * x * y + 0.2 * sqrt(abs(x));
    lat += (20.0 * sin(6.0 * x * pi) + 20.0 *sin(2.0 * x * pi)) * 2.0 / 3.0;
    lat += (20.0 * sin(y * pi) + 40.0 * sin(y / 3.0 * pi)) * 2.0 / 3.0;
    lat += (160.0 * sin(y / 12.0 * pi) + 320 * sin(y * pi / 30.0)) * 2.0 / 3.0;
    return lat;
}
  
+(double)transformLonWithX:(double)x withY:(double)y
{
    double lon = 300.0 + x + 2.0 * y + 0.1 * x * x + 0.1 * x * y + 0.1 * sqrt(abs(x));
    lon += (20.0 * sin(6.0 * x * pi) + 20.0 * sin(2.0 * x * pi)) * 2.0 / 3.0;
    lon += (20.0 * sin(x * pi) + 40.0 * sin(x / 3.0 * pi)) * 2.0 / 3.0;
    lon += (150.0 * sin(x / 12.0 * pi) + 300.0 * sin(x / 30.0 * pi)) * 2.0 / 3.0;
    return lon;
}
@end
