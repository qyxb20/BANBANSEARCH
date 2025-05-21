//
//  shopInforView.h
//  BANBANSEARCH
//
//  Created by apple on 2025/5/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface shopInforView : UIView
+ (instancetype)initViewNIB;
+ (shopInforView *)sharedManager;
- (void)updateData:(NSDictionary *)dicData;
- (CGFloat)getShortHeight;
- (CGFloat)getLongHeight;
@property(nonatomic, copy) void (^callBlock) (NSString *callStr);
@end

NS_ASSUME_NONNULL_END
