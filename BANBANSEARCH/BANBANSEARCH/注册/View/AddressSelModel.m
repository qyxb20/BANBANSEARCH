//
//  AddressSelModel.m
//  BANBANSEARCH
//
//  Created by apple on 2025/4/21.
//

#import "AddressSelModel.h"

@implementation AddressSelModel
-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.areaId = [dic[@"areaId"] intValue];
        self.areaName = [NSString stringWithFormat:@"%@",[NSString isNullStr:dic[@"areaName"]]];
        self.areaNameHalfAngle = [NSString stringWithFormat:@"%@",[NSString isNullStr:dic[@"areaNameHalfAngle"]]];
        self.postalCode = [NSString stringWithFormat:@"%@",[NSString isNullStr:dic[@"postalCode"]]];
        self.selectedState = NO;

           }
   
    return self;
}

-(instancetype)modelWithDic:(NSDictionary *)dic{
    AddressSelModel *model = [[AddressSelModel alloc] initWithDic:dic];
    return model;
}
@end
