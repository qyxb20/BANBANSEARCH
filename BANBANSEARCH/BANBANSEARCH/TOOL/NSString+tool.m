//
//  NSString+tool.m
//  Netneto
//
//  Created by SHOKEN ITO on 2024/9/25.
//

#import "NSString+tool.h"

@implementation NSString (tool)
+ (NSString *)isNullStr:(id)str {
    if (([str isEqual:[NSNull null]] || str == nil || [str isEqual:@""]|| [str isEqual:@"<null>"])) {
        return @"";
    }
    return str;
}

+ (NSString *)isReplacStr:(NSString *)str {
    NSString *newStr = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    return newStr;
}

@end
