//
//  AddressSelView.h
//  Netneto
//
//  Created by SHOKEN ITO on 2024/9/27.
//


#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface AddressSelView : UIView
+ (instancetype)initViewNIB;
-(void)upshow:(NSString *)addStr areId:(NSInteger )areId cityAreId:(NSInteger )cityareId code:(NSString *)code;
@property(nonatomic, copy) void (^sureBlock) (NSString *addressStr,NSString *postalCode,NSInteger cityAreaId,NSInteger areaId);
@end

NS_ASSUME_NONNULL_END
