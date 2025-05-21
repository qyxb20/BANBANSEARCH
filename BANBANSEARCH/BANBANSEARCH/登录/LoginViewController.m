//
//  LoginViewController.m
//  BANBANSEARCH
//
//  Created by apple on 2025/4/7.
//

#import "LoginViewController.h"

@interface LoginViewController ()<UITextFieldDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
//@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;
@property (weak, nonatomic) IBOutlet UITextField *userTF;
@property (weak, nonatomic) IBOutlet UITextField *passTF;
@property (weak, nonatomic) IBOutlet UIButton *eyeBtn;
@property (nonatomic, assign) NSInteger timecount;
@property (nonatomic, strong) dispatch_source_t timer;
@property (weak, nonatomic) IBOutlet UIButton *returnBtn;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (weak, nonatomic) IBOutlet UIButton *choseBtn;
@property (weak, nonatomic) IBOutlet UITextView *agreeTX;

@end

@implementation LoginViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}
-(void)initData{
    UIView *leftButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    UIButton *returnBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
       [leftButtonView addSubview:returnBtn];
       [returnBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
       [returnBtn addTarget:self action:@selector(returnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftCunstomButtonView = [[UIBarButtonItem alloc] initWithCustomView:leftButtonView];
      self.navigationItem.leftBarButtonItem = leftCunstomButtonView;

    
}
-(void)returnClick{
    if ([self.isKitout isEqual:@"1"]) {
        [self.navigationController popToRootViewControllerAnimated:NO];
    }else{
        [self.navigationController popViewControllerAnimated:NO];
    }
//    [self dismissViewControllerAnimated:NO completion:nil];
}
-(void)viewDidLoad{
    [super viewDidLoad];
    [self initData];
    self.loginBtn.backgroundColor = [UIColor blackColor];
    [self.loginBtn setTitle:@"ログイン" forState:UIControlStateNormal];
    [self.returnBtn setTitle:@"戻る" forState:UIControlStateNormal];
    [self.returnBtn setImage:[UIImage imageNamed:@"路径 1 (7)"] forState:UIControlStateNormal];
    [self.returnBtn layoutButtonWithButtonStyle:ButtonStyleImageLeftTitleRight imageTitleSpace:18];
    [self.returnBtn addTarget:self action:@selector(returnClick) forControlEvents:UIControlEventTouchUpInside];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(returnKeyBord)];
    [self.view addGestureRecognizer:tap];
    
    self.userTF.delegate = self;
    
   
    
    NSString *str = [NSString stringWithFormat:@"本サービスの利用規約およびプライバシーポリシーを確認し、内容に同意します。"];
    NSMutableAttributedString *attstring = [[NSMutableAttributedString alloc] initWithString:str];
   
    NSString *valueString = [[NSString stringWithFormat:@"firstPerson://1"] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSString *valueString1 = [[NSString stringWithFormat:@"secondPerson://2"] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSRange rang1 =NSMakeRange([NSString stringWithFormat:@"本サービスの"].length, [NSString stringWithFormat:@"利用規約"].length);
    
    NSRange rang2 =NSMakeRange(13, 10);
    
    [attstring addAttribute:NSLinkAttributeName value:valueString range:rang1];
    [attstring addAttribute:NSLinkAttributeName value:valueString1 range:rang2];
  
    [attstring addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:rang1];
    // 设置颜色
    [attstring addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:187 / 255.0 green:19 / 255.0 blue:41 / 255.0 alpha:1] range:rang1];
    // 设置下划线
    [attstring addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:rang2];
    // 设置颜色
    [attstring addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:187 / 255.0 green:19 / 255.0 blue:41 / 255.0 alpha:1] range:rang2];
   
    self.agreeTX.linkTextAttributes = @{NSForegroundColorAttributeName: [UIColor colorWithRed:187 / 255.0 green:19 / 255.0 blue:41 / 255.0 alpha:1]}; // 设置链接颜色

    self.agreeTX.delegate = self;
    self.agreeTX.attributedText =attstring;
    self.agreeTX.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0); // 上 左 下 右
    self.agreeTX.textAlignment = NSTextAlignmentLeft; // 设置文本居中
    self.agreeTX.editable = NO; // 如果你不希望用户编辑文本，设置为NO
}
- (BOOL)textView:(UITextView*)textView shouldInteractWithURL:(NSURL*)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction {
 
    if ([[URL scheme] isEqualToString:@"firstPerson"]) {
        [self handleTap];
        return NO;
    } else if ([[URL scheme] isEqualToString:@"secondPerson"]) {
        [self handleTapY];
        return NO;
    }
 
    return YES;
 
}
//隐私协议
-(void)handleTapY{
    MineWebKitViewController *vc = [[MineWebKitViewController alloc] init];
    
    vc.url =@"https://banbansearch.net/privacy_policy.html";
    [self.navigationController pushController:vc];
    

}
//用户协议
-(void)handleTap{
  

    MineWebKitViewController *vc = [[MineWebKitViewController alloc] init];
    vc.url =@"https://banbansearch.net/user_protocol.html";
    [self.navigationController pushController:vc];
}
- (IBAction)choseClick:(UIButton *)sender {
    if (!sender.selected) {
        sender.selected = YES;
    }else{
        sender.selected = NO;
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSUInteger newLength = textField.text.length + string.length - range.length;
   
    return newLength <= 50;
}

-(void)returnKeyBord{
    if ([self.userTF isFirstResponder]) {
        [self.userTF resignFirstResponder];
        
    }
    else  if ([self.passTF isFirstResponder]) {
        [self.passTF resignFirstResponder];
    }
}

- (IBAction)eyeClick:(UIButton *)sender {
    if (!sender.selected) {
        sender.selected =YES;
       
        self.passTF.secureTextEntry = NO;
    }else{
        sender.selected = NO;
        self.passTF.secureTextEntry = YES;
    }
}
//发送验证码
- (IBAction)getCode:(UIButton *)sender {
    
    if (self.userTF.text.length == 0) {
        ToastShow(@"メールアドレスを入力してください。",@"矢量 20",RGB(0xFD9329));
        return;
    }
   
    NSString *str = [NSString stringWithFormat:@"validateAccount=%@",self.userTF.text];
   
    [HudView showHudForView:self.view];
    [NetwortTool loginWithGetCode:str Success:^(id  _Nonnull responseObject) {
        ToastShow(@"認証コードを送信しました。\nご登録のメールアドレスをご確認ください。", @"chenggong",RGB(0x5EC907));
        [self startDaoTime];
    } failure:^(NSError * _Nonnull error) {
        [HudView hideHudForView:self.view];
        ToastShow(error.userInfo[@"httpError"],@"矢量 20",RGB(0xFF830F));
    }];
//    [self startDaoTime];
    
}
-(void)startDaoTime{
    [HudView hideHudForView:self.view];
    self.timecount = 120;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if (self.timecount <= 1) {
            [self uninitTimer];
            dispatch_async(dispatch_get_main_queue(), ^{
                //倒计时结束
                self.timecount = 120;
                [self changeResendBtnStatus:YES];
                [self.codeBtn setTitle:@"認証コード送信" forState:UIControlStateNormal];
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                //倒计时进行中
                [self changeResendBtnStatus:NO];
                [self.codeBtn setTitle:[NSString stringWithFormat:@"%ld s",self.timecount] forState:UIControlStateNormal];
            });
            self.timecount--;
        }
    });
    dispatch_resume(_timer);
}
- (void)uninitTimer {
    if (_timer) {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}
- (void)changeResendBtnStatus:(BOOL)enable {
    self.codeBtn.enabled = enable;
  
}
- (IBAction)loginClick:(id)sender {
    if (self.userTF.text.length == 0) {
        ToastShow(@"メールアドレスを入力してください。",@"矢量 20",RGB(0xFD9329));
        return;
    }
    if (self.passTF.text.length == 0) {
        ToastShow(@"認証コードを入力してください。",@"矢量 20",RGB(0xFD9329));
        return;
    }
    
//    
    if (!self.choseBtn.selected) {
//        ToastShow(@"请勾选协议",@"矢量 20",RGB(0xFD9329));
//        return;
        CSQAlertView *alert = [[CSQAlertView alloc] initWithCutomOrderTitle:@"利用規約およびプライバシーポリシー" Message:@"本サービスの利用規約およびプライバシーポリシーを確認し、内容に同意します。" btnTitle:@"同意してログイン" cancelBtnTitle:@"キャンセル" btnClick:^{
            [self login];
        } cancelBlock:^{
            
        }];
       
        
        
            [alert show];
        [alert setLinkYin:^{
            [alert hide];
            MineWebKitViewController *vc = [[MineWebKitViewController alloc] init];
            
            vc.url =@"https://banbansearch.net/privacy_policy.html";
            [self.navigationController pushController:vc];
        }];
        [alert setLinkYong:^{
            [alert hide];
//            跳转用户协议
            MineWebKitViewController *vc = [[MineWebKitViewController alloc] init];
            vc.url =@"https://banbansearch.net/user_protocol.html";
            [self.navigationController pushController:vc];
        }];
        return;
    }

  
    [self login];
}
///登录
-(void)login{
    NSString *uuidStr =  [UIDevice currentDevice].identifierForVendor.UUIDString;
    NSDictionary *parm = @{@"userName":self.userTF.text,@"verificationCode":self.passTF.text,@"loginUuid": uuidStr};
    
    [NetwortTool loginWithCode:parm Success:^(id  _Nonnull responseObject) {
//        account.userInfo.accessToken = responseObject[@"accessToken"];
        account.userInfo = [UserInfoModel mj_objectWithKeyValues:responseObject];
        [self returnClick];
    } failure:^(NSError * _Nonnull error) {
        ToastShow(error.userInfo[@"httpError"],@"矢量 20",RGB(0xFF830F));
    }];
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
