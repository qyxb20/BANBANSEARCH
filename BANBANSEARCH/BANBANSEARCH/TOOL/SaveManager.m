//
//  SaveManager.m
//  Netneto
//
//  Created by 才诗琦 on 2024/9/12.
//

#import "SaveManager.h"

@implementation SaveManager

+ (void)saveUserInfoModel:(UserInfoModel *)model{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"SaveUserInfoModel"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(UserInfoModel *)getUserInfoModel{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"SaveUserInfoModel"];
    UserInfoModel *userinfo = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return userinfo;
}
+ (void)saveShopData:(NSDictionary *)dic{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dic];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"SaveShopData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (void)saveSearchHistoryData:(NSDictionary *)dic{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dic];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"SearchHistoryData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSDictionary *)getSearchHistoryData{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"SearchHistoryData"];
    NSDictionary *dic = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return dic;
    
}
+(NSDictionary *)getShopData{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"SaveShopData"];
    UserInfoModel *userinfo = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return userinfo;
}
+ (void)clearAll {

    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SaveUserInfoModel"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
  
}
@end
