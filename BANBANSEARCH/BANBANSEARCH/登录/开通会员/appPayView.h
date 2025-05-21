//
//  appPayView.h
//  masaLiveNewApp
//
//  Created by ccc on 2024/1/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol applePayDelegate <NSObject>

-(void)applePayHUD:(NSString *)orderNumber res:(NSString *)receipt;
-(void)applePayShowHUD;
-(void)applePaySuccess;
-(void)applePayFail;
-(void)applePayShowMess:(NSString *)mess;
@end
@interface appPayView : UIView
@property(nonatomic,assign)id<applePayDelegate>delegate;

typedef void (^applePayBlock)(id arrays);

-(void)applePay:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
