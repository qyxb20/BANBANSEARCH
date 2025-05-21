//
//  AccountTool.m
//  Netneto
//
//  Created by 才诗琦 on 2024/9/12.
//

#import "AccountTool.h"
static AccountTool *_manager = nil;
@implementation AccountTool
+ (AccountTool *)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[AccountTool alloc] init];
    });
    return _manager;
}

- (instancetype)init {
    if (self = [super init]) {
        NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"Token"];
        if (token) {
            _accessToken = token;
        }
        UserInfoModel *model = [SaveManager getUserInfoModel];
        if (model) {
            _userInfo = model;
//            _userId = model.userId;
        }
    }
    return self;
}



#pragma mark - 存储token

-(void)setUserInfo:(UserInfoModel *)userInfo{
    _userInfo = userInfo;
    [SaveManager saveUserInfoModel:userInfo];
}
- (BOOL)isLogin {
    NSLog(@"是否有token:%@",[NSString isNullStr:account.userInfo.accessToken]);
    return [NSString isNullStr:account.userInfo.accessToken].length > 0 ;
}
-(void)Kitout{
    [SaveManager clearAll];
    account.userId = @"";

    account.userInfo = nil;
    account.userInfo.accessToken = @"";
   
    CSQAlertView *alert = [[CSQAlertView alloc] initWithOtherTitle:@"アカウント通知" Message:@"他のデバイスでログイン中です。このデバイスで続ける場合は、再ログインしてください。" btnTitle:@"確定" btnClick:^{
           [[NSNotificationCenter defaultCenter]postNotificationName:@"uploadUserInfo" object:nil];
            [self  logoutCancel];
        LoginViewController *vc = [[LoginViewController alloc] init];
        vc.isKitout = @"1";
        [APPDELEGATE.window.rootViewController pushController:vc];

        }];
    @weakify(self);
    [alert setHideBlock:^{
        @strongify(self);
        [SaveManager clearAll];
        account.userId = @"";
        account.userInfo = nil;
        [[NSNotificationCenter defaultCenter]postNotificationName:@"uploadUserInfo" object:nil];
 
        
    }];
        [alert show];
}
#pragma mark - 登出
- (void)logout {
    [SaveManager clearAll];
    account.userId = @"";

    account.userInfo = nil;
    account.userInfo.accessToken = @"";
   
    if (self.isLogin) {
       
    }else{
       
    }
}
- (void)logoutCancel {
   
    [SaveManager clearAll];
    account.userId = @"";
    
    account.userInfo = nil;
    account.userInfo.accessToken = @"";
    
    if (self.isLogin) {
        
    }else{
      
    }
}

#pragma mark - 加载资源
- (void)loadResource {
    
}
- (void)setIqkeyboardmanager:(BOOL)enable {
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
//    manager.enableAutoToolbar = enable;
    manager.shouldResignOnTouchOutside = enable;
    manager.toolbarDoneBarButtonItemAccessibilityLabel = @"完了";
    manager.enable = enable;
}
@end
