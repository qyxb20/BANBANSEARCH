//
//  appPayView.m
//  masaLiveNewApp
//
//  Created by ccc on 2024/1/11.
//

#import "appPayView.h"

#define h5url @"http://192.168.1.122:8086"
@interface appPayView ()<SKProductsRequestDelegate,SKPaymentTransactionObserver>
@property (nonatomic,strong) SKProductsRequest *request;
@property (nonatomic,strong) NSArray *products;
@property (nonatomic,strong) NSSet *productIdentifiers;
@property (nonatomic,strong) NSMutableSet *purchasedProducts;
@property (nonatomic,strong) SKProduct *product;
@property (nonatomic,copy) NSString *OrderNo;
@property (nonatomic, strong) NSString *productId;

@end
@implementation appPayView


-(void)dealloc{
    
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];

}
//内购开始
-(void)applePay:(NSDictionary *)dic{

    [self.delegate applePayShowHUD];
    NSDictionary *dics = @{@"shopId":dic[@"shopId"],
                           @"amount":dic[@"amount"],
                           @"payType":@"0"
                          };
    [NetwortTool getAppPayOrderWithParm:dics Success:^(id  _Nonnull responseObject) {
        self.OrderNo = responseObject[@"orderNumber"];//订单
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
        
        
        NSSet *set= [NSSet setWithObject:@"BANBANVIP.jp.cn"]; // 替换为产品 ID
      
        
                self.request = [[SKProductsRequest alloc] initWithProductIdentifiers:set];
        
                self.request.delegate = self;
                [self.request start];
    } failure:^(NSError * _Nonnull error) {
        [self.delegate applePayFail];
        ToastShow(error.userInfo[@"httpError"],@"矢量 20",RGB(0xFF830F));
    }];
//    [Tool getRequestWithAction:@"Charge.getIosOrder"  params:dics success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
//        if (code == 0) {
//            NSString *infos = [[info firstObject] valueForKey:@"orderid"];
//            self.OrderNo = infos;//订单
            //苹果支付ID
    
    

//        }
//        else{
//            [self.delegate applePayHUD];
//            dispatch_async(dispatch_get_main_queue(), ^{
//
//                [MBProgressHUD showError:msg];
//            });
//        }
//
//    } fail:^(NSError * _Nonnull error) {
//        
//    }];
   
}
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
   
//    [self.delegate applePayHUD];
    
    self.products = response.products;
    self.request = nil;
    for (SKProduct *product in response.products) {
       NSLog(@"已获取到产品信息 %@,%@,%@",product.localizedTitle,product.localizedDescription,product.price);
        self.product = product;
    }
    if (!self.product) {
        
        NSLog(@"无法获取商品信息");
      
        return;
    }
    //3.获取到产品信息，加入支付队列
    SKMutablePayment *payment = [SKMutablePayment paymentWithProduct:self.product];
    payment.applicationUsername = self.OrderNo;
   
//    NSString *uuidStr =  [UIDevice currentDevice].identifierForVendor.UUIDString;
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}
- (void)recordTransaction:(SKPaymentTransaction *)transaction {
}
- (void)provideContent:(NSString *)productIdentifier {
    [_purchasedProducts addObject:productIdentifier];
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction *transaction in transactions)
    {
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased:
                //购买成功
//                [self completeTransaction:transaction];
//                [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
              
                [self verifyReceipt:transaction];
                NSLog(@"交易完成");
                break;
            case SKPaymentTransactionStateFailed:
//                [self failedTransaction:transaction];
            {
                NSLog(@"交易失败");
                if (transaction.error.userInfo[NSUnderlyingErrorKey] != NULL) {
                    NSError *error = transaction.error.userInfo[NSUnderlyingErrorKey];
                    if (error.code == 3532) {
                        [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                        NSMutableDictionary *payDic = [NSMutableDictionary dictionary];
                        payDic[@"result"] = [NSNumber numberWithInt:2];
                        //                                        [[NSNotificationCenter defaultCenter] postNotificationName:EPayFinishNotificationName object:payDic];
                        NSLog(@"您目前已订阅此项目");
                        return;
                    }else{
                        [self failedTransaction:transaction];
                    }
                }
               
//                NSMutableDictionary *payDic = [NSMutableDictionary dictionary];
//                payDic[@"result"] = [NSNumber numberWithInt:1];
                //                                [[NSNotificationCenter defaultCenter] postNotificationName:EPayFinishNotificationName object:payDic];
                
            }
                                        
               
                break;
            case SKPaymentTransactionStateRestored:
//                [self restoreTransaction:transaction];
            { [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                NSMutableDictionary *payDic = [NSMutableDictionary dictionary];
                payDic[@"result"] = [NSNumber numberWithInt:1];
                //                            [[NSNotificationCenter defaultCenter] postNotificationName:EPayFinishNotificationName object:payDic];
                NSLog(@"已经购买过商品");
            }
                break;
           
            default:
                break;
        }
    }
}
- (void)completeTransaction:(SKPaymentTransaction *)transaction {
    
    //LYLSLog(@"completeTransaction...");
//    [self recordTransaction: transaction];
//    [self provideContent: transaction.payment.productIdentifier];
//    [self verifyReceipt:transaction];
//    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    
}
#pragma mark 服务器验证购买凭据
- (void) verifyReceipt:(SKPaymentTransaction *)transaction
{
    
//    NSURL *receiptURL = [[NSBundle mainBundle] appStoreReceiptURL];
//      NSData *receiptData = [NSData dataWithContentsOfURL:receiptURL];
   
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[[NSBundle mainBundle] appStoreReceiptURL]];
    NSData *transData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:nil error:nil];
    NSString *encodeStr = [transData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    

   
//    //苹果：域名+/Appapi/Pay/notify_ios
    [self.delegate applePayHUD:self.OrderNo res:encodeStr];
//    [self.delegate applePaySuccess];
    
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    

}
- (void)restoreTransaction:(SKPaymentTransaction *)transaction {
    [self recordTransaction: transaction];
    [self provideContent: transaction.originalTransaction.payment.productIdentifier];
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
//    ToastShow(@"用户已恢复购买",@"chenggong",RGB(0x5EC907));
    dispatch_async(dispatch_get_main_queue(), ^{

        [MBProgressHUD hideHUDForView:self animated:YES];
    });
}
- (void)failedTransaction:(SKPaymentTransaction *)transaction {
//    dispatch_async(dispatch_get_main_queue(), ^{
//
//    [MBProgressHUD hideHUDForView:self animated:YES];
//        if (transaction.error.code != SKErrorPaymentCancelled)
//        {
//            [self showAlertView:transaction.error.localizedDescription];
//            NSLog(@"Transaction error: %@", transaction.error.localizedDescription);
//        }else{
//          
//            
//        }
//        });
    [self.delegate applePayFail];

//    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}
- (void)showAlertView:(NSString *)message
{
    
    [self.delegate applePayShowMess:message];

}


@end
