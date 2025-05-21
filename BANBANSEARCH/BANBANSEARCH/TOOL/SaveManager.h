//
//  SaveManager.h
//  Netneto
//
//  Created by 才诗琦 on 2024/9/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SaveManager : NSObject


+ (void)saveUserInfoModel:(UserInfoModel *)model;
+ (UserInfoModel *)getUserInfoModel;
+(NSDictionary *)getShopData;
+ (void)saveShopData:(NSDictionary *)dic;
+ (void)clearAll;
+ (void)saveSearchHistoryData:(NSDictionary *)dic;
+ (NSDictionary *)getSearchHistoryData;
@end

NS_ASSUME_NONNULL_END
