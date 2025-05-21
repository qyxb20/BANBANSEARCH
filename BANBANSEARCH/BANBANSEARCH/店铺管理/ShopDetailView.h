//
//  ShopDetailView.h
//  BANBANSEARCH
//
//  Created by apple on 2025/4/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShopDetailView : UIView
+ (instancetype)initViewNIB;
- (void)updateData:(NSDictionary *)dicData;
@end

NS_ASSUME_NONNULL_END
