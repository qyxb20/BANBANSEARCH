//
//  NSString+UUID.h
//  BANBANSEARCH
//
//  Created by apple on 2025/5/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (UUID)
+ (NSString *)getUUID;
 
@end
 
 
@interface KeyChainStore : NSObject
 
// 将UUID保存到钥匙串
+ (void)save:(NSString *)service data:(id)data;
// 读取保存到钥匙串的UUID
+ (id)load:(NSString *)service;
// 删除保存到钥匙串的UUID
+ (void)deleteKeyData:(NSString *)service;
 
@end

NS_ASSUME_NONNULL_END
