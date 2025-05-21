//
//  NetwortTool.h
//  Netneto
//
//  Created by SHOKEN ITO on 2024/9/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetwortTool : NSObject
#pragma mark - 1生成订单
+ (void)getAppPayOrderWithParm:(NSDictionary *)parm Success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
#pragma mark - 获取产品周期
+ (void)getPlansWithParm:(NSDictionary *)parm Success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
#pragma mark - 2验证订单
+ (void)getVerifyIosPayReceiptWithParm:(NSDictionary *)parm Success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

#pragma mark-3验证码登录
+(void)loginWithCode:(NSDictionary *)parm Success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
#pragma mark-4获取验证
+(void)loginWithGetCode:(NSString *)parm Success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
#pragma mark-5通过code获取省市区信息
+(void)getListByPostCodeWithParm:(NSDictionary *)parm Success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
#pragma mark-6模糊获取会场名称
+(void)getVenuesNameWithParm:(NSDictionary *)parm Success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
#pragma mark-7获取省市区信息
+(void)getAddAreaListWithParm:(NSDictionary *)parm Success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
#pragma mark-8根据距离获取附近会场和店铺
+(void)getNearShopWithParm:(NSDictionary *)parm Success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
#pragma mark-9添加店铺
+(void)addShopWithParm:(NSDictionary *)parm Success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
#pragma mark-10修改店铺
+(void)updateShopWithParm:(NSDictionary *)parm Success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
#pragma mark-11删除店铺
+(void)deleteByShopIdWithParm:(NSDictionary *)parm Success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
#pragma mark-12获取我的店铺
+(void)getShopWithParm:(NSDictionary *)parm Success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
#pragma mark-13店铺详情
+(void)getShopInfoWithParm:(NSDictionary *)parm Success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
#pragma mark-14会场详情
+(void)getVenvesInfoWithParm:(NSDictionary *)parm Success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
#pragma mark-15退出登录
+(void)getlogOutWithParm:(NSDictionary *)parm Success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
#pragma mark-16注销理由
+(void)getCancelMsgWithParm:(NSDictionary *)parm Success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
#pragma mark-17注销用户
+(void)getCancelUserWithParm:(NSDictionary *)parm Success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
#pragma mark-18获取经纬度
+(void)getLatAndLngWithParm:(NSDictionary *)parm Success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
#pragma mark-19模糊搜索地址
+(void)getAreaByQueryParamWithParm:(NSDictionary *)parm Success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;









@end

NS_ASSUME_NONNULL_END
