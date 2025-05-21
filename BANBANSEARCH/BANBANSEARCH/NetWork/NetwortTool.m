//
//  NetwortTool.m
//  Netneto
//
//  Created by SHOKEN ITO on 2024/9/19.
//

#import "NetwortTool.h"

@implementation NetwortTool
#pragma mark - 生成订单
+ (void)getAppPayOrderWithParm:(NSDictionary *)parm Success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    [NetWorkRequest postWithUrl:RequestURL(@"/p/order/createOrder") parameters:parm success:success failure:failure];
    
}
#pragma mark - 获取产品周期
+ (void)getPlansWithParm:(NSDictionary *)parm Success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    [NetWorkRequest postWithUrl:RequestURL(@"/p/order/getPlans") parameters:parm success:success failure:failure];
    
}
#pragma mark - 验证订单
+ (void)getVerifyIosPayReceiptWithParm:(NSDictionary *)parm Success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    [NetWorkRequest postWithUrl:RequestURL(@"/p/applePay/verifyIosPayReceipt") parameters:parm success:success failure:failure];
    
}



#pragma mark-登录
+(void)loginWithCode:(NSDictionary *)parm Success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    [NetWorkRequest postWithUrl:RequestURL(@"/login/verification") parameters:parm success:success failure:failure];
     
     
}

#pragma mark-获取验证
+(void)loginWithGetCode:(NSString *)parm Success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
//    [NetWorkRequest postWithUrl:RequestURL(@"/login/sendVerificationCode") parameters:parm success:success failure:failure];
    [NetWorkRequest  postWithFormUrl:RequestURL(@"/login/sendVerificationCode") parameters:parm success:success failure:failure];
     
}

#pragma mark-通过code获取省市区信息
+(void)getListByPostCodeWithParm:(NSDictionary *)parm Success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    [NetWorkRequest getWithUrl:RequestURL(@"/p/area/listByPostCode") parameters:parm success:success failure:failure];
}

#pragma mark-模糊获取会场名称
+(void)getVenuesNameWithParm:(NSDictionary *)parm Success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    
    [NetWorkRequest getWithUrl:RequestURL(@"/p/area/getVenuesName") parameters:parm success:success failure:failure];
}
#pragma mark-根据距离获取附近会场和店铺
+(void)getNearShopWithParm:(NSDictionary *)parm Success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    [NetWorkRequest getWithUrl:RequestURL(@"/index/getNearShop") parameters:parm success:success failure:failure];
}
#pragma mark-获取省市区信息
+(void)getAddAreaListWithParm:(NSDictionary *)parm Success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    [NetWorkRequest getWithUrl:RequestURL(@"/p/area/listByPid") parameters:parm success:success failure:failure];

}
#pragma mark-添加店铺
+(void)addShopWithParm:(NSDictionary *)parm Success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    [NetWorkRequest postWithUrl:RequestURL(@"/p/shop/addShop") parameters:parm success:success failure:failure];
     
     
}
#pragma mark-修改店铺
+(void)updateShopWithParm:(NSDictionary *)parm Success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    [NetWorkRequest postWithUrl:RequestURL(@"/p/shop/updateShop") parameters:parm success:success failure:failure];
     
}
#pragma mark-删除店铺
+(void)deleteByShopIdWithParm:(NSDictionary *)parm Success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
//    [NetWorkRequest postWithUrl:RequestURL(@"/p/shop/deleteByShopId") parameters:parm success:success failure:failure];
     
    [NetWorkRequest  postWithFormUrl:RequestURL(@"/p/shop/deleteByShopId") parameters:[NSString stringWithFormat:@"shopId=%@",parm[@"shopId"]] success:success failure:failure];
     
}


#pragma mark-获取我的店铺
+(void)getShopWithParm:(NSDictionary *)parm Success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    [NetWorkRequest getWithUrl:RequestURL(@"/p/shop/getShop") parameters:parm success:success failure:failure];

     
}
#pragma mark-店铺详情
+(void)getShopInfoWithParm:(NSDictionary *)parm Success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    [NetWorkRequest getWithUrl:RequestURL(@"/index/getShopInfo") parameters:parm success:success failure:failure];

     
}
#pragma mark-会场详情
+(void)getVenvesInfoWithParm:(NSDictionary *)parm Success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    [NetWorkRequest getWithUrl:RequestURL(@"/index/getVenvesInfo") parameters:parm success:success failure:failure];

     
}
#pragma mark-模糊搜索地址
+(void)getAreaByQueryParamWithParm:(NSDictionary *)parm Success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    [NetWorkRequest getWithUrl:RequestURL(@"/index/getAreaByQueryParam") parameters:parm success:success failure:failure];

     
}
#pragma mark-获取经纬度
+(void)getLatAndLngWithParm:(NSDictionary *)parm Success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    [NetWorkRequest getWithUrl:RequestURL(@"/p/area/getLatAndLng") parameters:parm success:success failure:failure];

//    [NetWorkRequest  getWithFormUrl:RequestURL(@"/p/area/getLatAndLng") parameters:[NSString stringWithFormat:@"shopName=%@",parm[@"shopName"]] success:success failure:failure];
//    
}


#pragma mark-退出登录
+(void)getlogOutWithParm:(NSDictionary *)parm Success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    [NetWorkRequest postWithUrl:RequestURL(@"/logOut") parameters:parm success:success failure:failure];

     
}
#pragma mark-注销理由
+(void)getCancelMsgWithParm:(NSDictionary *)parm Success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    [NetWorkRequest postWithUrl:RequestURL(@"/p/user/cancelMsg") parameters:parm success:success failure:failure];

     
}
#pragma mark-注销用户
+(void)getCancelUserWithParm:(NSDictionary *)parm Success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
//    [NetWorkRequest postWithUrl:RequestURL(@"/p/user/cancelUser") parameters:parm success:success failure:failure];

        [NetWorkRequest  postWithFormUrl:RequestURL(@"/p/user/cancelUser") parameters:[NSString stringWithFormat:@"cancelOption=%@&cancelNotes=%@",parm[@"cancelOption"],parm[@"cancelNotes"]] success:success failure:failure];

}




@end
