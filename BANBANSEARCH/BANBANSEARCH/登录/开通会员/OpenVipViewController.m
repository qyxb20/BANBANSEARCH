//
//  OpenVipViewController.m
//  BANBANSEARCH
//
//  Created by apple on 2025/4/14.
//

#import "OpenVipViewController.h"
#import "appPayView.h"

@interface OpenVipViewController ()<applePayDelegate>
{
    appPayView *applePays;//苹果支付
    
}
@property (weak, nonatomic) IBOutlet UIButton *openVipBtn;
@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;
@property (weak, nonatomic) IBOutlet UIButton *xieyi;
//@property (weak, nonatomic) IBOutlet UIView *yueView;
//@property (weak, nonatomic) IBOutlet UIView *jiView;
//@property (weak, nonatomic) IBOutlet UIView *banView;
//@property (weak, nonatomic) IBOutlet UIView *wanView;
//@property (weak, nonatomic) IBOutlet UILabel *yueL;
//@property (weak, nonatomic) IBOutlet UILabel *jiL;
//@property (weak, nonatomic) IBOutlet UILabel *banL;
//@property (weak, nonatomic) IBOutlet UILabel *oneL;
//@property (weak, nonatomic) IBOutlet UIButton *yueBtn;
//@property (weak, nonatomic) IBOutlet UIButton *jiBtn;
//@property (weak, nonatomic) IBOutlet UIButton *banBtn;
//@property (weak, nonatomic) IBOutlet UIButton *oneBtn;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, assign) NSInteger index;

@end

@implementation OpenVipViewController
-(void)initData{
    UIView *leftButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 25, 17)];
    UIButton *returnBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 17)];
       [leftButtonView addSubview:returnBtn];
       [returnBtn setImage:[UIImage imageNamed:@"returnfanhuizuo"] forState:UIControlStateNormal];
       [returnBtn addTarget:self action:@selector(returnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftCunstomButtonView = [[UIBarButtonItem alloc] initWithCustomView:leftButtonView];
      self.navigationItem.leftBarButtonItem = leftCunstomButtonView;

    
}
-(void)returnClick{
//    [self.navigationController popViewControllerAnimated:NO];
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[ShopManagerViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
  
//    [self dismissViewControllerAnimated:NO completion:nil];
}
-(void)viewDidLoad{
    [super viewDidLoad];
    [self initData];
    self.title = @"会員登録";
    NSString *str = [NSString stringWithFormat:@"支払いに関する規約を確認し、同意しました。"];
    NSMutableAttributedString *attstring = [[NSMutableAttributedString alloc] initWithString:str];
   
        NSRange rang =NSMakeRange(0, 9);
    
    [attstring addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:rang];
    // 设置颜色
    [attstring addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:227 / 255.0 green:201 / 255.0 blue:150 / 255.0 alpha:1] range:rang];
    [self.xieyi setAttributedTitle:attstring forState:UIControlStateNormal];
    self.xieyi.titleLabel.numberOfLines = 0;
    //    self.agreeTX.linkTextAttributes = @{NSForegroundColorAttributeName: [UIColor colorWithRed:187 / 255.0 green:19 / 255.0 blue:41 / 255.0 alpha:1]}; // 设置链接颜色
//    _index = 0;
//    self.yueView.backgroundColor = RGB(0xFAE2BF);
//    self.yueView.layer.borderColor = RGB(0xC3936E).CGColor;
//    self.yueL.textColor = RGB(0x814F14);
//    self.yueBtn.selected = YES;
//    
//    self.jiView.backgroundColor = RGB_ALPHA(0xF2F2F2,0.4);
//    self.jiView.layer.borderColor = RGB(0xE5E5E5).CGColor;
//    self.jiL.textColor = RGB(0x808080);
//    self.jiBtn.selected = NO;
//    
//    self.banView.backgroundColor = RGB_ALPHA(0xF2F2F2,0.4);
//    self.banView.layer.borderColor = RGB(0xE5E5E5).CGColor;
//    self.banL.textColor = RGB(0x808080);
//    self.banBtn.selected = NO;
//    
//    self.wanView.backgroundColor = RGB_ALPHA(0xF2F2F2,0.4);
//    self.wanView.layer.borderColor = RGB(0xE5E5E5).CGColor;
//    self.oneL.textColor = RGB(0x808080);
//    self.oneBtn.selected = NO;
//    @weakify(self);
//    [self.yueView addTapAction:^(UIView * _Nonnull view) {
//        @strongify(self);
//        self.index = 0;
//        self.yueView.backgroundColor = RGB(0xFAE2BF);
//        self.yueView.layer.borderColor = RGB(0xC3936E).CGColor;
//        self.yueL.textColor = RGB(0x814F14);
//        self.yueBtn.selected = YES;
//        
//        self.jiView.backgroundColor = RGB_ALPHA(0xF2F2F2,0.4);
//        self.jiView.layer.borderColor = RGB(0xE5E5E5).CGColor;
//        self.jiL.textColor = RGB(0x808080);
//        self.jiBtn.selected = NO;
//        
//        self.banView.backgroundColor = RGB_ALPHA(0xF2F2F2,0.4);
//        self.banView.layer.borderColor = RGB(0xE5E5E5).CGColor;
//        self.banL.textColor = RGB(0x808080);
//        self.banBtn.selected = NO;
//        
//        self.wanView.backgroundColor = RGB_ALPHA(0xF2F2F2,0.4);
//        self.wanView.layer.borderColor = RGB(0xE5E5E5).CGColor;
//        self.oneL.textColor = RGB(0x808080);
//        self.oneBtn.selected = NO;
//    }];
//    [self.jiView addTapAction:^(UIView * _Nonnull view) {
//        @strongify(self);
//        self.index = 1;
//        self.jiView.backgroundColor = RGB(0xFAE2BF);
//        self.jiView.layer.borderColor = RGB(0xC3936E).CGColor;
//        self.jiL.textColor = RGB(0x814F14);
//        self.jiBtn.selected = YES;
//        
//        self.yueView.backgroundColor = RGB_ALPHA(0xF2F2F2,0.4);
//        self.yueView.layer.borderColor = RGB(0xE5E5E5).CGColor;
//        self.yueL.textColor = RGB(0x808080);
//        self.yueBtn.selected = NO;
//        
//        self.banView.backgroundColor = RGB_ALPHA(0xF2F2F2,0.4);
//        self.banView.layer.borderColor = RGB(0xE5E5E5).CGColor;
//        self.banL.textColor = RGB(0x808080);
//        self.banBtn.selected = NO;
//        
//        self.wanView.backgroundColor = RGB_ALPHA(0xF2F2F2,0.4);
//        self.wanView.layer.borderColor = RGB(0xE5E5E5).CGColor;
//        self.oneL.textColor = RGB(0x808080);
//        self.oneBtn.selected = NO;
//    }];
//    [self.banView addTapAction:^(UIView * _Nonnull view) {
//        @strongify(self);
//        self.index = 2;
//        self.banView.backgroundColor = RGB(0xFAE2BF);
//        self.banView.layer.borderColor = RGB(0xC3936E).CGColor;
//        self.banL.textColor = RGB(0x814F14);
//        self.banBtn.selected = YES;
//        
//        self.jiView.backgroundColor = RGB_ALPHA(0xF2F2F2,0.4);
//        self.jiView.layer.borderColor = RGB(0xE5E5E5).CGColor;
//        self.jiL.textColor = RGB(0x808080);
//        self.jiBtn.selected = NO;
//        
//        self.yueView.backgroundColor = RGB_ALPHA(0xF2F2F2,0.4);
//        self.yueView.layer.borderColor = RGB(0xE5E5E5).CGColor;
//        self.yueL.textColor = RGB(0x808080);
//        self.yueBtn.selected = NO;
//        
//        self.wanView.backgroundColor = RGB_ALPHA(0xF2F2F2,0.4);
//        self.wanView.layer.borderColor = RGB(0xE5E5E5).CGColor;
//        self.oneL.textColor = RGB(0x808080);
//        self.oneBtn.selected = NO;
//    }];
//    [self.wanView addTapAction:^(UIView * _Nonnull view) {
//        @strongify(self);
//        self.index = 3;
//        self.wanView.backgroundColor = RGB(0xFAE2BF);
//        self.wanView.layer.borderColor = RGB(0xC3936E).CGColor;
//        self.oneL.textColor = RGB(0x814F14);
//        self.oneBtn.selected = YES;
//        
//        self.jiView.backgroundColor = RGB_ALPHA(0xF2F2F2,0.4);
//        self.jiView.layer.borderColor = RGB(0xE5E5E5).CGColor;
//        self.jiL.textColor = RGB(0x808080);
//        self.jiBtn.selected = NO;
//        
//        self.banView.backgroundColor = RGB_ALPHA(0xF2F2F2,0.4);
//        self.banView.layer.borderColor = RGB(0xE5E5E5).CGColor;
//        self.banL.textColor = RGB(0x808080);
//        self.banBtn.selected = NO;
//        
//        self.yueView.backgroundColor = RGB_ALPHA(0xF2F2F2,0.4);
//        self.yueView.layer.borderColor = RGB(0xE5E5E5).CGColor;
//        self.yueL.textColor = RGB(0x808080);
//        self.yueBtn.selected = NO;
//    }];
//    
    
//    [self getData];
    // Do any additional setup after loading the view from its nib.
}
-(void)getData{
    [NetwortTool getPlansWithParm:@{} Success:^(id  _Nonnull responseObject) {
        NSLog(@"获取的产品周期：%@",responseObject);
        self.dataArray = responseObject;
        } failure:^(NSError * _Nonnull error) {
            
        }];
}
- (IBAction)buyVip:(UIButton *)sender {
    if (!self.agreeBtn.selected) {
        ToastShow(@"支払いに関する規約に同意するチェックボックスを確認してください。",@"矢量 20",RGB(0xFD9329));
        return;
    }
    if([SKPaymentQueue canMakePayments]) {
        applePays = [[appPayView alloc]init];
        applePays.delegate = self;
        [applePays applePay:@{@"shopId":self.shopId,@"amount":@"550"}];
 } else {
    NSLog(@"🐯🐯 未开启内购权限");
}

   
   
}
- (IBAction)choseClick:(UIButton *)sender {
    if (!sender.selected) {
        sender.selected = YES;
    }
    else{
        sender.selected = NO;
    }
}

- (IBAction)agreeClick:(UIButton *)sender {
    //跳转协议
    MineWebKitViewController *vc = [[MineWebKitViewController alloc] init];
    vc.url =@"https://banbansearch.net/pay.html";
    [self.navigationController pushController:vc];
}




/******************   内购  ********************/
-(void)applePayHUD:(NSString *)orderNumber res:(NSString *)receipt{
   
    
    [NetwortTool getVerifyIosPayReceiptWithParm:@{@"receipt":receipt,@"orderNumber":orderNumber} Success:^(id  _Nonnull responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
//        dispatch_async(dispatch_get_main_queue(), ^{
           
//            ToastShow(@"操作成功",@"chenggong",RGB(0xFD9329));

                [[NSNotificationCenter defaultCenter]postNotificationName:@"uploadShopInfo" object:nil];
                for (UIViewController *controller in self.navigationController.viewControllers) {
                    if ([controller isKindOfClass:[ShopManagerViewController class]]) {
                        [self.navigationController popToViewController:controller animated:YES];
                    }
                }
              
           

    } failure:^(NSError * _Nonnull error) {
        
    }];
    
}
-(void)applePayFail{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
       
    });
}
-(void)applePayShowHUD{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    });
}
- (void)applePayShowMess:(NSString *)mess{
    
}
//内购成功
-(void)applePaySuccess{
    NSLog(@"苹果支払いが完了しました。");
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD];
        
//        [MBProgressHUD showError:@"支払いが完了しました。"];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"uploadShopInfo" object:nil];
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[ShopManagerViewController class]]) {
                [self.navigationController popToViewController:controller animated:YES];
            }
        }
        
    });
//    [self.navigationController popViewControllerAnimated:NO];

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
