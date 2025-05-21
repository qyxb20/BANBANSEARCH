//
//  AccountTool.h
//  Netneto
//
//  Created by 才诗琦 on 2024/9/12.
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"
#import "SaveManager.h"
#import "NSString+tool.h"
NS_ASSUME_NONNULL_BEGIN
#define account [AccountTool sharedManager]
@class UserInfoModel;
@interface AccountTool : NSObject
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *accessToken;
@property (nonatomic, strong) UserInfoModel *userInfo;
@property (nonatomic, strong) NSArray *bankArray;

- (void)Kitout;
+ (AccountTool *)sharedManager;


- (BOOL)isLogin;
- (void)logout;
- (void)loadResource;
- (void)setIqkeyboardmanager:(BOOL)enable;
@end

NS_ASSUME_NONNULL_END
