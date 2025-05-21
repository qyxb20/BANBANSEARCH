//
//  UserInfoModel.h
//  Netneto
//
//  Created by SHOKEN ITO on 2024/9/24.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserInfoModel : BaseModel
@property (nonatomic, copy) NSString *accessToken;
@property (nonatomic, copy) NSString *expiresIn;
@property (nonatomic, copy) NSString *refreshToken;
@property (nonatomic, copy) NSString *userId;
/**生日*/
@property (nonatomic, copy) NSString *name;
/**是否是商户 1是 0否*/
@property (nonatomic, copy) NSString *phone;
/**昵称*/
@property (nonatomic, copy) NSString *email;
/**头像*/
@property (nonatomic, copy) NSString *huiName;
/**性别*/
@property (nonatomic, copy) NSString *shopName;
/**用户状态 0禁用 1正常*/
@property (nonatomic, copy) NSString *type;
/**uid*/
@property (nonatomic, copy) NSString *add;
 /**账户*/
@property (nonatomic, copy) NSString *danName;
 /**邮箱*/
@property (nonatomic, copy) NSString *shopPhone;
 /**手机*/
@property (nonatomic, copy) NSString *startTime;
 /**userID*/
@property (nonatomic, copy) NSString *endTime;
 /**是否为管理员*/
@property (nonatomic, copy) NSString *xiu;

 /**是否关注*/
@property (nonatomic, copy) NSString *xiNum;

 /**是否禁言*/
@property (nonatomic, copy) NSString *shopUrl;
 /**是否被踢出房间*/
@property (nonatomic, copy) NSString *remark;
 
@property (nonatomic, copy) NSString *emailCode;

@property (nonatomic, copy) NSString *addDetail;


@end

NS_ASSUME_NONNULL_END
