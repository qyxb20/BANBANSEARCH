//
//  addressModel.h
//  BANBANSEARCH
//
//  Created by apple on 2025/4/21.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface addressModel : BaseModel
///地址id
@property (nonatomic, copy) NSString *addrId;
///收货人
@property (nonatomic, copy) NSString *receiver;
///省
@property (nonatomic, copy) NSString *province;
///市
@property (nonatomic, copy) NSString *city;
///区
@property (nonatomic, copy) NSString *area;
///地址
@property (nonatomic, copy) NSString *addr;
///手机
@property (nonatomic, copy) NSString *mobile;
///是否默认地址
@property (nonatomic, copy) NSString *commonAddr;
///省id
@property (nonatomic, copy) NSString *provinceId;
///市id
@property (nonatomic, copy) NSString *cityId;
///区id
@property (nonatomic, copy) NSString *areaId;
///邮编
@property (nonatomic, copy) NSString *postCode;
@end
NS_ASSUME_NONNULL_END
