//
//  ResignViewController.m
//  BANBANSEARCH
//
//  Created by apple on 2025/4/7.
//

#define BASE_RANGE_TAG  10000
#import "ResignViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import <CloudKit/CloudKit.h>
@interface ResignViewController()<UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextViewDelegate,TZImagePickerControllerDelegate,SelectorDelegate,WQDatePickerDelegate,GKImagePickerDelegate>
{
    UIButton *loginBtn;
    MBProgressHUD *hud;
    UILabel *label;
    CLLocationCoordinate2D tempLocation;
    UIDatePicker *datePicker;
}
@property (nonatomic, strong) CLGeocoder *geocoder;
@property(nonatomic, strong)UIScrollView *scrollView;
///名前
@property(nonatomic, strong)CustomView *NameFView;
///手机号
@property(nonatomic, strong)CustomView *phoneTFView;

///邮箱
@property(nonatomic, strong)CustomView *emailTFView;

///会場名
@property(nonatomic, strong)CustomView *HuiNameView;

///名称（店舗名など）
@property(nonatomic, strong)CustomView *ShopNameView;
///営業形態
@property(nonatomic, strong)CustomView *YingView;
///邮政编码
@property(nonatomic, strong)CustomView *emailCodeView;
///住所
@property(nonatomic, strong)CustomView *addTFView;
///邮政编码
@property(nonatomic, strong)CustomView *addDetailView;



///担当者名（代表）
@property(nonatomic, strong)CustomView *DaiNameView;
///電話番号（店舗など）
@property(nonatomic, strong)CustomView *ShopPhoneView;
///営業開始時間
@property(nonatomic, strong)CustomView *startTimeView;
///営業終了時間
@property(nonatomic, strong)CustomView *endTimeView;
///定休日
@property(nonatomic, strong)CustomView *xiuView;

///席数
@property(nonatomic, strong)CustomView *XishuView;
///店铺Url
@property(nonatomic, strong)CustomView *ShopUrl;
///担当者写真
@property(nonatomic, strong)CustomLineView *UserPic;
///写真1
@property(nonatomic, strong)CustomLineView *Pic;

///フリーテキスト
@property(nonatomic, strong)UITextView *noteTX;

@property(nonatomic, strong)huiSelView *huiSelview;

@property(nonatomic, strong)AddressSelView *addSelectView;
@property (nonatomic, assign) NSInteger areaId;
@property (nonatomic, assign) NSInteger cityareaId;

@property(nonatomic, strong)NSString *danPicUrlStr;
@property(nonatomic, strong)NSString *xieZhenPicUrlStr;
@property(nonatomic, strong)NSString *venues_id;
@end

@implementation ResignViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"矩形 1"] forBarMetrics:UIBarMetricsDefault];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
    
}
-(void)returnClick{
    [self dismissViewControllerAnimated:NO completion:nil];
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)initData{
    UIView *leftButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 25, 17)];
    UIButton *returnBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 17)];
       [leftButtonView addSubview:returnBtn];
       [returnBtn setImage:[UIImage imageNamed:@"returnfanhuizuo"] forState:UIControlStateNormal];
       [returnBtn addTarget:self action:@selector(returnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftCunstomButtonView = [[UIBarButtonItem alloc] initWithCustomView:leftButtonView];
      self.navigationItem.leftBarButtonItem = leftCunstomButtonView;
    if ([self.dataDic allKeys].count > 0) {
        self.title = @"店舗情報変更";
    }else{
        self.title = @"新規登録";
    }
    self.areaId = 0;
    self.venues_id = @"";
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initData];

    self.view.backgroundColor = [UIColor colorWithRed:239 / 255.0 green:239 / 255.0 blue:239 / 255.0 alpha:1];
   
    datePicker.datePickerMode = UIDatePickerModeTime;
    
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.scrollEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_offset(0);
        make.top.mas_offset(15);
        make.bottom.mas_offset(-124);
    }];
    UIView *bgView = [[UIView alloc] init];
    bgView.frame = CGRectMake(15, 0, WIDTH - 30, 17 * 40 + 92 * 2 + 120);
    
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = 6;
    bgView.clipsToBounds = YES;
    [self.scrollView addSubview:bgView];
    
    self.NameFView.frame = CGRectMake(0, 0, WIDTH - 32, 40);
    [bgView addSubview:self.NameFView];
    self.phoneTFView.frame = CGRectMake(0, self.NameFView.bottom , WIDTH - 32, 40);
    [bgView addSubview:self.phoneTFView];
    self.emailTFView.frame = CGRectMake(0, self.phoneTFView.bottom , WIDTH - 32, 40);
    [bgView addSubview:self.emailTFView];
    self.HuiNameView.frame = CGRectMake(0, self.emailTFView.bottom , WIDTH - 32, 40);
    self.HuiNameView.customTF.delegate = self;
//    [self.HuiNameView.customTF initDropDownMenu:self.view frame:self.HuiNameView.frame];
   
    [bgView addSubview:self.HuiNameView];
    self.ShopNameView.frame = CGRectMake(0, self.HuiNameView.bottom , WIDTH - 32, 40);
    [bgView addSubview:self.ShopNameView];
    self.YingView.frame = CGRectMake(0, self.ShopNameView.bottom , WIDTH - 32, 40);
    [bgView addSubview:self.YingView];
    self.emailCodeView.frame = CGRectMake(0, self.YingView.bottom, WIDTH - 32, 40);
    [bgView addSubview:self.emailCodeView];
    self.addTFView.frame = CGRectMake(0, self.emailCodeView.bottom , WIDTH - 32, 40);
    [bgView addSubview:self.addTFView];
    self.addDetailView.frame = CGRectMake(0, self.addTFView.bottom , WIDTH - 32, 40);
    [bgView addSubview:self.addDetailView];
    self.DaiNameView.frame = CGRectMake(0, self.addDetailView.bottom , WIDTH - 32, 40);
    [bgView addSubview:self.DaiNameView];
    self.ShopPhoneView.frame = CGRectMake(0, self.DaiNameView.bottom , WIDTH - 32, 40);
    [bgView addSubview:self.ShopPhoneView];
    self.startTimeView.frame = CGRectMake(0, self.ShopPhoneView.bottom , WIDTH - 32, 40);
    [bgView addSubview:self.startTimeView];
    self.endTimeView.frame = CGRectMake(0, self.startTimeView.bottom , WIDTH - 32, 40);
    [bgView addSubview:self.endTimeView];
    self.xiuView.frame = CGRectMake(0, self.endTimeView.bottom , WIDTH - 32, 40);
    [bgView addSubview:self.xiuView];
    self.XishuView.frame = CGRectMake(0, self.xiuView.bottom , WIDTH - 32, 40);
    [bgView addSubview:self.XishuView];
    self.ShopUrl.frame = CGRectMake(0, self.XishuView.bottom , WIDTH - 32, 40);
    [bgView addSubview:self.ShopUrl];
    
    self.UserPic.frame = CGRectMake(0, self.ShopUrl.bottom, WIDTH - 32, 92);
    [bgView addSubview:self.UserPic];
    
    self.Pic.frame = CGRectMake(0, self.UserPic.bottom, WIDTH - 32, 92);
    [bgView addSubview:self.Pic];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, self.Pic.bottom + 15, WIDTH - 32, 14)];
    label.text = @"備考";
    label.font = [UIFont systemFontOfSize:12];
    [bgView addSubview:label];
    self.noteTX.frame = CGRectMake(20, label.bottom + 6 , WIDTH - 32 - 40, 140);
    [bgView addSubview:self.noteTX];
    
    
    
    [self.view addSubview:self.huiSelview];
    self.huiSelview.hidden = YES;
    [self.huiSelview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.mas_offset(0);
        make.top.mas_offset(self.HuiNameView.bottom);
    }];
    
    self.addSelectView = [AddressSelView initViewNIB];
    
    self.addSelectView.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    
    
    self.scrollView.contentSize = CGSizeMake(WIDTH,  self.noteTX.bottom + 20);
    self.addDetailView.userInteractionEnabled = YES;
    self.NameFView.customTF.delegate = self;
    self.phoneTFView.customTF.delegate = self;
    self.emailTFView.customTF.delegate = self;
    self.ShopNameView.customTF.delegate = self;
    self.YingView.customTF.delegate = self;
    self.emailCodeView.customTF.delegate = self;
    self.addTFView.customTF.delegate = self;
    self.addDetailView.customTF.delegate = self;
    self.DaiNameView.customTF.delegate = self;
    self.ShopPhoneView.customTF.delegate = self;
    self.startTimeView.customTF.delegate = self;
    self.endTimeView.customTF.delegate = self;
    self.xiuView.customTF.delegate = self;
    self.XishuView.customTF.delegate = self;
    self.ShopUrl.customTF.delegate = self;
    
    [self.startTimeView.customTF setEnabled: NO];
    self.endTimeView.customTF.enabled = NO;
    if ([self.dataDic allKeys].count != 0) {
        ///有数据 是编辑
        self.NameFView.customTF.text = self.dataDic[@"names"];
        
        self.ShopPhoneView.customTF.text = self.dataDic[@"shopMobile"];
        
        self.emailTFView.customTF.text = self.dataDic[@"shopMail"];
        
        self.HuiNameView.customTF.text = self.dataDic[@"venuesName"];
    
        self.ShopNameView.customTF.text = self.dataDic[@"shopName"];
        
        self.YingView.customTF.text = self.dataDic[@"shopTyps"];
        self.emailCodeView.customTF.text = self.dataDic[@"postalCode"];
        
        self.addTFView.customTF.text =  [NSString stringWithFormat:@"%@-%@-%@",self.dataDic[@"shopProvince"],self.dataDic[@"shopCity"],self.dataDic[@"shopArea"]];
        
        self.addDetailView.customTF.text = self.dataDic[@"shopAddress"];
       
        self.DaiNameView.customTF.text = self.dataDic[@"storeManager"];
       
        self.phoneTFView.customTF.text = self.dataDic[@"storeMobile"];
        
        self.startTimeView.customTF.text = [NSString isNullStr:self.dataDic[@"businessStartTime"]];
        
        self.endTimeView.customTF.text = [NSString isNullStr:self.dataDic[@"businessEndTime"]];
        
        self.xiuView.customTF.text = [NSString isNullStr:self.dataDic[@"restDay"]];
       
        self.XishuView.customTF.text = [NSString isNullStr:self.dataDic[@"seatCount"]];
       
        self.ShopUrl.customTF.text = [NSString isNullStr:self.dataDic[@"shopUrl"]];
        
        self.noteTX.text = [NSString isNullStr:self.dataDic[@"notes"]];
        
        self.danPicUrlStr = [NSString isNullStr:self.dataDic[@"storePhoto"]];
       
        [self.UserPic.picBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:self.danPicUrlStr] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"矩形 10"]];
        self.xieZhenPicUrlStr = [NSString isNullStr:self.dataDic[@"shopImage"]];
        [self.Pic.picBtn.imageView setContentMode:UIViewContentModeScaleAspectFit];
        [self.Pic.picBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:self.xieZhenPicUrlStr] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"矩形 10"]];
        self.venues_id = [NSString stringWithFormat:@"%@",self.dataDic[@"venuesId"]];
        [self.NameFView updateData];
        [self.phoneTFView updateData];
        [self.HuiNameView updateData];
        
        self.NameFView.userInteractionEnabled = NO;
        self.phoneTFView.userInteractionEnabled = NO;
        self.HuiNameView.customTF.enabled = NO;
        
        
        loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        loginBtn.layer.cornerRadius = 4;
        loginBtn.clipsToBounds = YES;
        loginBtn.backgroundColor = [UIColor colorWithRed:25 / 255.0 green:25 / 255.0 blue:30 / 255.0 alpha:1];
        [loginBtn setTitle:@"変更" forState:UIControlStateNormal];
        [self.view addSubview:loginBtn];
        [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_offset(16);
            make.trailing.mas_offset(-16);
            make.bottom.mas_offset(-25);
            make.height.mas_offset(48);
            
        }];
        @weakify(self)
        [loginBtn addTapAction:^(UIView * _Nonnull view) {
            @strongify(self)
            [self getLatAndLng];

        }];
        
    }else{
       ///无数据 是注册
        self.NameFView.userInteractionEnabled = YES;
        self.phoneTFView.userInteractionEnabled = YES;
        self.HuiNameView.userInteractionEnabled = YES;
        
        
        loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        loginBtn.layer.cornerRadius = 4;
        loginBtn.clipsToBounds = YES;
        loginBtn.backgroundColor = [UIColor colorWithRed:25 / 255.0 green:25 / 255.0 blue:30 / 255.0 alpha:1];
        [loginBtn setTitle:@"登録" forState:UIControlStateNormal];
        [self.view addSubview:loginBtn];
        [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_offset(16);
            make.trailing.mas_offset(-16);
            make.bottom.mas_offset(-25);
            make.height.mas_offset(48);
            
        }];
        @weakify(self)
        [loginBtn addTapAction:^(UIView * _Nonnull view) {
            @strongify(self)
            [self getLatAndLng];
            
        }];
    }

    self.addTFView.customTF.userInteractionEnabled = NO;
//    self.HuiNameView.customTF.userInteractionEnabled = NO;
    [self addButtonClick];
    
}
///获取会场坐标
-(void)getLatAndLng{
    if (self.NameFView.customTF.text.length == 0) {
        ToastShow(@"お名前を入力してください。", @"矢量 20",RGB(0xFD9329));
        return;
    }
    if (self.phoneTFView.customTF.text.length == 0) {
        ToastShow(@"ご自身の電話番号を入力してください。", @"矢量 20",RGB(0xFD9329));
        return;
    }
    if (self.emailTFView.customTF.text.length == 0) {
        ToastShow(@"メールアドレスを入力してください。", @"矢量 20",RGB(0xFD9329));
        return;
    }
    if (self.HuiNameView.customTF.text.length == 0) {
        ToastShow(@"会場名を選択または入力てください。", @"矢量 20",RGB(0xFD9329));
        return;
    }
    if ([NSString isNullStr:self.venues_id].length == 0) {
        ToastShow(@"該当する会場が存在しません。再度入力してください。", @"矢量 20",RGB(0xFD9329));
        return;
    }
    if (self.ShopNameView.customTF.text.length == 0) {
        ToastShow(@"店舗名称を入力してください。", @"矢量 20",RGB(0xFD9329));
        return;
    }
    if (self.YingView.customTF.text.length == 0) {
        ToastShow(@"営業形態を入力してください。", @"矢量 20",RGB(0xFD9329));
        return;
    }
    if (self.emailCodeView.customTF.text.length == 0) {
        ToastShow(@"郵便番号を入力してください（例：1234567）。", @"矢量 20",RGB(0xFD9329));
        return;
    }
    
    if (self.addTFView.customTF.text.length == 0) {
        ToastShow(@"都道府県・市区町村を入力してください。", @"矢量 20",RGB(0xFD9329));
        return;
    }
    if (self.addDetailView.customTF.text.length == 0) {
        ToastShow(@"建物名や部屋番号を含む詳細な住所を入力してください。", @"矢量 20",RGB(0xFD9329));
        return;
    }
    if (self.DaiNameView.customTF.text.length == 0) {
        ToastShow(@"店舗担当者の氏名を入力してください。", @"矢量 20",RGB(0xFD9329));
        return;
    }
    if (self.ShopPhoneView.customTF.text.length == 0) {
        ToastShow(@"店舗の電話番号を入力してください。", @"矢量 20",RGB(0xFD9329));
        return;
    }
   
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHONESTR];
    NSPredicate *phoneTest1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHONESTR1];
    NSPredicate *phoneTest2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHONESTR2];
    NSPredicate *phoneTest3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHONESTR3];
    NSPredicate *phoneTest4 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHONESTR4];
    NSPredicate *phoneTest5 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHONESTR5];
   
    BOOL phoneValid = [phoneTest evaluateWithObject:self.phoneTFView.customTF.text];
    BOOL phoneValid1 = [phoneTest1 evaluateWithObject:self.phoneTFView.customTF.text];
    BOOL phoneValid2 = [phoneTest2 evaluateWithObject:self.phoneTFView.customTF.text];
    BOOL phoneValid3 = [phoneTest3 evaluateWithObject:self.phoneTFView.customTF.text];
    BOOL phoneValid4 = [phoneTest4 evaluateWithObject:self.phoneTFView.customTF.text];
    BOOL phoneValid5 = [phoneTest5 evaluateWithObject:self.phoneTFView.customTF.text];

    if (!phoneValid && !phoneValid1 && !phoneValid2 && !phoneValid3 && !phoneValid4 && !phoneValid5) {
   
        ToastShow(@"正しい電話番号を入力してください。形式や桁数を確認し、ハイフン（-）を含めて入力してください。", @"矢量 20",RGB(0xFD9329));
        return;
    }
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", EMAILSTR];
    BOOL emailValid = [emailTest evaluateWithObject:self.emailTFView.customTF.text];

    if (!emailValid) {
     
        ToastShow(@"正しい形式でメールアドレスを入力してください。", @"矢量 20",RGB(0xFF830F));
        return;
    }
    BOOL phoneValidS = [phoneTest evaluateWithObject:self.ShopPhoneView.customTF.text];
    BOOL phoneValidS1 = [phoneTest1 evaluateWithObject:self.ShopPhoneView.customTF.text];
    BOOL phoneValidS2 = [phoneTest2 evaluateWithObject:self.ShopPhoneView.customTF.text];
    BOOL phoneValidS3 = [phoneTest3 evaluateWithObject:self.ShopPhoneView.customTF.text];
    BOOL phoneValidS4 = [phoneTest4 evaluateWithObject:self.ShopPhoneView.customTF.text];
    BOOL phoneValidS5 = [phoneTest5 evaluateWithObject:self.ShopPhoneView.customTF.text];

    if (!phoneValidS && !phoneValidS1 && !phoneValidS2 && !phoneValidS3 && !phoneValidS4 && !phoneValidS5) {
      
        ToastShow(@"正しい電話番号を入力してください。形式や桁数を確認し、ハイフン（-）を含めて入力してください。", @"矢量 20",RGB(0xFD9329));
        return;
    }
    
    
    NSString *Province = @"";
    NSString *City = @"";
    NSString *Area = @"";
    NSArray *arr = [self.addTFView.customTF.text componentsSeparatedByString:@"-"];
 
    Province = arr[0];
    City = arr[1];
    if (arr.count >2) {
        Area = arr[2];
    }
    
    NSString *add =[NSString stringWithFormat:@"%@%@%@%@%@",Province,City,Area,self.addDetailView.customTF.text,self.ShopNameView.customTF.text];
//    NSString *add =[NSString stringWithFormat:@"%@%@%@%@",Province,City,Area,self.addDetailView.customTF.text];

    [HudView showHudForView:self.view];
    [NetwortTool getLatAndLngWithParm:@{@"ShopName":add} Success:^(id  _Nonnull responseObject) {
        NSDictionary *dic = responseObject;
//        lat = "34.693466";
//        lng = "135.192281";
//        shopLat = "35.8774804";
//        shopLng = "139.8229168";
//        self->tempLocation = CLLocationCoordinate2DMake([dic[@"lat"] floatValue], [dic[@"lng"] floatValue]);
        [self sureClick:dic];
    } failure:^(NSError * _Nonnull error) {
        [HudView hideHudForView:self.view];
        ToastShow(error.userInfo[@"httpError"],@"矢量 20",RGB(0xFD9329));
    }];
}

-(void)addButtonClick{
    @weakify(self);
    [self.HuiNameView addTapAction:^(UIView * _Nonnull view) {
        @strongify(self);
       
    }];
    [self.addTFView addTapAction:^(UIView * _Nonnull view) {
        @strongify(self);
        [self.huiSelview hidView];
        self.huiSelview.hidden = YES;
        [self.view addSubview:self.addSelectView];
        if (![self.addTFView.customTF.text isEqual:@"都道府県・市区町村を入力してください。"] ) {
            [self.addSelectView upshow:self.addTFView.customTF.text areId:self.areaId cityAreId:self.cityareaId code:self.emailCodeView.customTF.text];
        }
        @weakify(self);
        [self.addSelectView setSureBlock:^(NSString * _Nonnull addressStr, NSString * _Nonnull postalCode, NSInteger cityAreaId, NSInteger areaId) {
            
            
            
            @strongify(self);
            self.areaId = areaId;
            self.cityareaId = cityAreaId;
            self.addTFView.customTF.text = addressStr;
            self.addTFView.customTF.textColor = [UIColor blackColor];
            self.emailCodeView.customTF.text = postalCode;
            
            
        }];
        
    }];
    [self.emailCodeView.search addTapAction:^(UIView * _Nonnull view) {
        [self.huiSelview hidView];
        self.huiSelview.hidden = YES;
        if (self.emailCodeView.customTF.text.length == 0) {
            ToastShow(@"郵便番号を入力してください（例：1234567）。", @"矢量 20",RGB(0xFD9329));
            return;
        }
        [self getAdd];
    }];
    [self.startTimeView addTapAction:^(UIView * _Nonnull view) {
        @strongify(self);
        [self.huiSelview hidView];
        self.huiSelview.hidden = YES;
        [self showTimeRangeSelectorStar:HHMM];
    }];
    [self.endTimeView addTapAction:^(UIView * _Nonnull view) {
        @strongify(self);
        [self.huiSelview hidView];
        self.huiSelview.hidden = YES;
        [self showTimeRangeSelectorEnd:HHMM];
    }];
    [self.UserPic.picBtn addTapAction:^(UIView * _Nonnull view) {
        @strongify(self);
        [self.huiSelview hidView];
        self.huiSelview.hidden = YES;
        [self showImageChoseAlert:1];
    }];
    [self.Pic.picBtn addTapAction:^(UIView * _Nonnull view) {
        @strongify(self);
        [self.huiSelview hidView];
        self.huiSelview.hidden = YES;
        [self showImageChoseAlert:2];
    }];

}
-(void)getAdd{
    [NetwortTool getListByPostCodeWithParm:@{@"postCode":self.emailCodeView.customTF.text} Success:^(id  _Nonnull responseObject) {
       
        NSLog(@"根据code获取地址：%@",responseObject);
        NSString *str = [NSString stringWithFormat:@"%@",responseObject];
        if ([str isEqual:@"<null>"]) {
            ToastShow(@"一致する住所が見つかりません。正しい郵便番号をご入力ください。", @"矢量 20",RGB(0xFD9329));
            self.addTFView.customTF.text = @"";
            
        }else{
            if (str.length > 0) {
                self.addTFView.customTF.text = str;
                
            }
        }
    } failure:^(NSError * _Nonnull error) {
        
        ToastShow(error.userInfo[@"httpError"],@"矢量 20",RGB(0xFD9329));
    }];
   
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([textField isEqual:self.emailCodeView.customTF]) {
        [self getAdd];
    }
    return YES;
}
///模糊查询会场及输入框限制输入长度
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSUInteger newLength = textField.text.length + string.length - range.length;
  
//    NSLog(@"输入的字：%@      %@",self.HuiNameView.customTF.text,str);
    if ([textField isEqual:self.HuiNameView.customTF]) {
        
        NSString *searchCount = [textField.text stringByReplacingCharactersInRange:range withString:string];
            
        if (searchCount.length == 0) {
            [self.huiSelview hidView];
            self.huiSelview.hidden = YES;
            return YES;
        }
        [NetwortTool getVenuesNameWithParm:@{@"queryParam":searchCount} Success:^(id  _Nonnull responseObject) {
            NSArray *arr = responseObject;
//            if (arr.count > 0) {
//                [textField updataWithArray:arr with:self.view.bounds];
//            }
            self.venues_id = @"";
            if (arr.count > 0) {
                self.huiSelview.hidden = NO;
                [self.huiSelview updataWithArray:arr withStr:self.HuiNameView.customTF.text];
                @weakify(self);
                [self.huiSelview setSelBlock:^(NSDictionary * _Nonnull selDic) {
    //                venues_id
                    
                    @strongify(self);
                    self.venues_id =[NSString stringWithFormat:@"%@",selDic[@"venues_id"]];
                    self.HuiNameView.customTF.text = selDic[@"venuesName"];
                    [self.huiSelview hidView];
                    self.huiSelview.hidden = YES;
                }];
            }
            else{
                [self.huiSelview hidView];
                self.huiSelview.hidden = YES;
            }
           
        } failure:^(NSError * _Nonnull error) {
            ToastShow(error.userInfo[@"httpError"],@"矢量 20",RGB(0xFD9329));
        }];
        
        return newLength <= 50;
    }
    else if([textField isEqual:self.emailCodeView.customTF]){
        self.addTFView.customTF.text = @"";
       
            return newLength <= 7;
        
    }
    else{
        if ([NSString isNullStr:self.venues_id].length == 0) {
            self.HuiNameView.customTF.text = @"";
        }
        [self.huiSelview hidView];
        self.huiSelview.hidden = YES;
        
       
        if (textField == self.NameFView.customTF || textField == self.ShopNameView.customTF || textField == self.ShopNameView.customTF || textField == self.xiuView.customTF || textField == self.DaiNameView.customTF || textField == self.YingView.customTF) {
            return newLength <= 50;
        }else if (textField == self.addDetailView.customTF || textField == self.emailTFView.customTF){
            return newLength <= 100;
        }
        else if (textField == self.phoneTFView.customTF || textField == self.ShopPhoneView.customTF){
            return newLength <= 13;
        }
        else if (textField == self.emailCodeView.customTF){
            return newLength <= 7;
        }
        else if (textField == self.startTimeView.customTF || textField == self.endTimeView.customTF){
            return newLength <= 5;
        }
        else if (textField == self.XishuView.customTF ){
            return newLength <= 20;
        }
        else if (textField == self.ShopUrl.customTF ){
            return newLength <= 255;
        }
        
    }
   
    return YES;
}
///选择照片、拍照
-(void)showImageChoseAlert:(NSInteger)taf{
    if (taf == 1) {
        
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *photoAlbumAction = [UIAlertAction actionWithTitle:@"アルバム" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self choseImgType:UIImagePickerControllerSourceTypePhotoLibrary tag:taf];
    }];
//    [photoAlbumAction setValue:RGB(0x333333) forKey:@"_titleTextColor"];
  
    UIAlertAction *takeAlbumAction = [UIAlertAction actionWithTitle:@"写真を撮る" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self choseImgType:UIImagePickerControllerSourceTypeCamera tag:taf];
    }];
//    [takeAlbumAction setValue:[UIColor blackColor] forKey:@"_titleTextColor"];
    
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"キャンセル" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
//    [cancle setValue:[UIColor blackColor] forKey:@"_titleTextColor"];
    [alert addAction:takeAlbumAction];
    [alert addAction:photoAlbumAction];
    [alert addAction:cancle];
    
    [self presentViewController:alert animated:YES completion:nil];
    }else {
        self.picker = [[GKImagePicker alloc] init];
        self.picker.view.tag = taf;
        self.picker.delegate = self;
        self.picker.cropper.cropSize = CGSizeMake(WIDTH - 36,(WIDTH - 36) / 2 * 1.1);   // (Optional) Default: CGSizeMake(320., 320.)
        self.picker.cropper.rescaleImage = YES;                // (Optional) Default: YES
        self.picker.cropper.rescaleFactor = 1.0;               // (Optional) Default: 1.0
        self.picker.cropper.dismissAnimated = YES;              // (Optional) Default: YES
        self.picker.cropper.overlayColor = [UIColor colorWithRed:0/255. green:0/255. blue:0/255. alpha:0.7];  // (Optional) Default: [UIColor colorWithRed:0/255. green:0/255. blue:0/255. alpha:0.7]
        self.picker.cropper.innerBorderColor = [UIColor colorWithRed:255./255. green:255./255. blue:255./255. alpha:0.7];   // (Optional) Default: [UIColor colorWithRed:0/255. green:0/255. blue:0/255. alpha:0.7]
        [self.picker presentPicker];
    }
}
-(void)choseImgType:(UIImagePickerControllerSourceType)sourceType tag:(NSInteger)tag{
    
    UIImagePickerController *imagePicker = [UIImagePickerController new];
    imagePicker.delegate = self;
    imagePicker.view.tag = tag;
    imagePicker.sourceType = sourceType;
    imagePicker.allowsEditing = YES;
    
    

    [self presentViewController:imagePicker animated:YES completion:nil];
   
}
- (void)imagePickerDidFinish:(GKImagePicker *)imagePicker withImage:(UIImage *)image {
    NSInteger tg = imagePicker.view.tag;
    [HudView showHudForView:self.view];
    [UploadElement UploadElementWithImage:image name:@"imagedefault" progress:^(CGFloat percent) {
       
    } success:^(id  _Nonnull responseObject) {
     
//            NSString *str =[NSString stringWithFormat:@"http://yueran.vip/%@",responseObject[@"data"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [HudView hideHudForView:self.view];
            ToastShow(@"画像アップロードが完了しました。", @"chenggong", RGB(0x5EC907));
            if (tg == 1) {
                self.danPicUrlStr = responseObject[@"data"];
//                [self.UserPic.picBtn.imageView setContentMode:UIViewContentModeScaleAspectFit];
//                [self.UserPic.picBtn setContentMode:UIViewContentModeScaleAspectFit];
                [self.UserPic.picBtn setBackgroundImage:image forState:UIControlStateNormal];
                
            }
            else{
                self.xieZhenPicUrlStr = responseObject[@"data"];
//                [self.Pic.picBtn.imageView setContentMode:UIViewContentModeScaleAspectFit];
                [self.Pic.picBtn setBackgroundImage:image forState:UIControlStateNormal];
            }
           
        });
       
        
    }];
    
//
//    [picker dismissViewControllerAnimated:YES completion:nil];
}
//    myImageView.contentMode = UIViewContentModeCenter;
//    myImageView.image = image;
//}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    NSInteger tg = picker.view.tag;
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
//    
   
    if ([type isEqual:@"public.image"]) {
      
        UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
//        image = [UIImage imagewithImage:image];
        [HudView showHudForView:self.view];
        [UploadElement UploadElementWithImage:image name:@"imagedefault" progress:^(CGFloat percent) {
           
        } success:^(id  _Nonnull responseObject) {
         
//            NSString *str =[NSString stringWithFormat:@"http://yueran.vip/%@",responseObject[@"data"]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [HudView hideHudForView:self.view];
                ToastShow(@"画像アップロードが完了しました。", @"chenggong", RGB(0x5EC907));
                if (tg == 1) {
                    self.danPicUrlStr = responseObject[@"data"];
//                    [self.UserPic.picBtn.imageView setContentMode:UIViewContentModeScaleAspectFit];
                    [self.UserPic.picBtn setBackgroundImage:image forState:UIControlStateNormal];
                    
                }
                else{
                    self.xieZhenPicUrlStr = responseObject[@"data"];
                  
                    [self.Pic.picBtn setBackgroundImage:image forState:UIControlStateNormal];
                }
               
            });
           
            
        }];
        
//        
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}
//开始时间选择
- (void)showTimeRangeSelectorStar:(TimeRangeType)rangeType{
    NSString *str = @"10:00";
    if (self.startTimeView.customTF.text.length >0) {
        str =self.startTimeView.customTF.text;
    }
    [BRDatePickerView showDatePickerWithMode:BRDatePickerModeHM title:@"開始時間の選択" selectValue:str resultBlock:^(NSDate * _Nullable selectDate, NSString * _Nullable selectValue) {
        self.startTimeView.customTF.text = selectValue;
    }];

}
//结束时间选择面
- (void)showTimeRangeSelectorEnd:(TimeRangeType)rangeType{
    NSString *str = @"21:00";
    if (self.endTimeView.customTF.text.length >0) {
        str =self.endTimeView.customTF.text;
    }
    [BRDatePickerView showDatePickerWithMode:BRDatePickerModeHM title:@"完了時間の選択" selectValue:str resultBlock:^(NSDate * _Nullable selectDate, NSString * _Nullable selectValue) {
        self.endTimeView.customTF.text = selectValue;
    }];

}
- (void)datePickerView:(ZLDatePickerView *)pickerView backTimeString:(NSString *)string To:(UIView *)view {
    if (view.tag == 1) {
        self.startTimeView.customTF.text = string;
    }
    else{
        self.endTimeView.customTF.text = string;
    }
   
}


//登录/变更按钮点击事件
-(void)sureClick:(NSDictionary *)dic{
    
   
    NSArray *arr = [self.addTFView.customTF.text componentsSeparatedByString:@"-"];
    NSString *Province = @"";
    NSString *City = @"";
    NSString *Area = @"";
//    CGFloat lat = tempLocation.latitude;
//    CGFloat lon = tempLocation.longitude;
    Province = arr[0];
    City = arr[1];
    if (arr.count >2) {
        Area = arr[2];
    }

    NSMutableDictionary *parm =[NSMutableDictionary dictionaryWithDictionary:@{
        @"names":[NSString isNullStr:self.NameFView.customTF.text],
        @"shopName":[NSString isNullStr:self.ShopNameView.customTF.text],
        @"shopMail":[NSString isNullStr:self.emailTFView.customTF.text],
        @"shopMobile":[NSString isNullStr:self.ShopPhoneView.customTF.text],
        @"venuesName":[NSString isNullStr:self.HuiNameView.customTF.text],
        @"postalCode":[NSString isNullStr:self.emailCodeView.customTF.text],
        @"shopProvince":Province,
        @"shopCity":City,
        @"shopArea":Area,
        @"shopAddress":[NSString isNullStr:self.addDetailView.customTF.text],
        @"shopLat":dic[@"lat"],
        @"shopLng":dic[@"lng"],
        @"shopTyps":[NSString isNullStr:self.YingView.customTF.text],
        @"businessStartTime":[NSString isNullStr:self.startTimeView.customTF.text],
        @"businessEndTime":[NSString isNullStr:self.endTimeView.customTF.text],
        @"restDay":[NSString isNullStr:self.xiuView.customTF.text],
        @"seatCount":[NSString isNullStr:self.XishuView.customTF.text],
        @"shopUrl":[NSString isNullStr:self.ShopUrl.customTF.text],
        @"shopImage":[NSString isNullStr:self.xieZhenPicUrlStr],
        @"storeManager":[NSString isNullStr:self.DaiNameView.customTF.text],
        @"storePhoto":[NSString isNullStr:self.danPicUrlStr],
        @"storeMobile":[NSString isNullStr:self.phoneTFView.customTF.text],
        @"notes":[NSString isNullStr:self.noteTX.text],
        @"userId":account.userInfo.userId,
        @"venuesId":self.venues_id
    }] ;
    
    if ([self.dataDic allKeys].count > 0) {
        [parm setObject:self.dataDic[@"shopId"] forKey:@"shopId"];
        [NetwortTool updateShopWithParm:parm Success:^(id  _Nonnull responseObject) {
            [HudView hideHudForView:self.view];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"uploadShopInfo" object:nil];
                [self.navigationController popViewControllerAnimated:NO];
           
          
        } failure:^(NSError * _Nonnull error) {
            [HudView hideHudForView:self.view];
            ToastShow(error.userInfo[@"httpError"],@"矢量 20",RGB(0xFD9329));
        }];
    }else{
        [NetwortTool addShopWithParm:parm Success:^(id  _Nonnull responseObject) {
            [HudView hideHudForView:self.view];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"uploadShopInfo" object:nil];
            OpenVipViewController *vc = [[OpenVipViewController alloc] init];
            vc.shopId = responseObject[@"shopId"];
            [self.navigationController pushViewController:vc animated:NO];
            
        } failure:^(NSError * _Nonnull error) {
            [HudView hideHudForView:self.view];
            ToastShow(error.userInfo[@"httpError"],@"矢量 20",RGB(0xFD9329));
        }];
        
    }


}




#pragma mark-定休日
-(CustomView *)xiuView{
    if (!_xiuView) {
        _xiuView = [CustomView initViewNIB];
        _xiuView.titleLabel.text =@"定休日";
        _xiuView.customTF.placeholder =@"例：火曜日、第3水曜日など";
        _xiuView.searchWidth.constant = 0;
        _xiuView.isBi.text = @"";
    }
    return _xiuView;
}
#pragma mark-営業終了時間
-(CustomView *)endTimeView{
    if (!_endTimeView) {
        _endTimeView = [CustomView initViewNIB];
        _endTimeView.titleLabel.text =@"営業終了時間";
        _endTimeView.customTF.placeholder =@"例：21:00";
        _endTimeView.searchWidth.constant = 22;
        _endTimeView.isBi.text = @"";
    }
    return _endTimeView;
}
#pragma mark-営業開始時間
-(CustomView *)startTimeView{
    if (!_startTimeView) {
        _startTimeView = [CustomView initViewNIB];
        _startTimeView.titleLabel.text =@"営業開始時間";
        _startTimeView.customTF.placeholder =@"例：10:00";
        _startTimeView.searchWidth.constant = 22;
        _startTimeView.isBi.text = @"";
    }
    return _startTimeView;
}
#pragma mark-電話番号（店舗など）
-(CustomView *)ShopPhoneView{
    if (!_ShopPhoneView) {
        _ShopPhoneView = [CustomView initViewNIB];
        NSString *str = @"店舗電話番号(ハイフンあり)";
        NSMutableAttributedString *attstr = [[NSMutableAttributedString alloc] initWithString:str];
        [attstr addAttributes:@{NSForegroundColorAttributeName:RGB(0xBB1329)} range:NSMakeRange(6, 8)];
        _ShopPhoneView.titleLabel.attributedText =attstr;
        
//        _ShopPhoneView.titleLabel.text =@"店舗電話番号";
        _ShopPhoneView.customTF.placeholder =@"03-1234-5678";
        _ShopPhoneView.searchWidth.constant = 0;
        _ShopPhoneView.isBi.hidden = NO;
    }
    return _ShopPhoneView;
}
#pragma mark-担当者名（代表）
-(CustomView *)DaiNameView{
    if (!_DaiNameView) {
        _DaiNameView = [CustomView initViewNIB];
        _DaiNameView.titleLabel.text =@"店舗担当者名";
        _DaiNameView.customTF.placeholder =@"例：鈴木花子";
        _DaiNameView.searchWidth.constant = 0;
        _DaiNameView.isBi.hidden = NO;
    }
    return _DaiNameView;
}
#pragma mark-営業形態
-(CustomView *)YingView{
    if (!_YingView) {
        _YingView = [CustomView initViewNIB];
        _YingView.titleLabel.text =@"営業形態";
        _YingView.customTF.placeholder =@"例：飲食店、小売店、サービス業など";
        _YingView.searchWidth.constant = 0;
        _YingView.isBi.hidden = NO;
    }
    return _YingView;
}
#pragma mark - 邮政编码
- (CustomView *)emailCodeView{
    if (!_emailCodeView) {
       
        _emailCodeView = [CustomView initViewNIB];
        NSString *str = @"郵便番号(ハイフンなし)";
        NSMutableAttributedString *attstr = [[NSMutableAttributedString alloc] initWithString:str];
        [attstr addAttributes:@{NSForegroundColorAttributeName:RGB(0xBB1329)} range:NSMakeRange(4, 8)];
        _emailCodeView.titleLabel.attributedText =attstr;
        
        _emailCodeView.customTF.placeholder =@"例：1234567";
        [_emailCodeView.search setImage:[UIImage imageNamed:@"homeSearch"] forState:UIControlStateNormal];
        _emailCodeView.searchWidth.constant = 32;
        _emailCodeView.isBi.hidden = NO;
        @weakify(self);
       
    }
    return _emailCodeView;
}
#pragma mark-住所
-(CustomView *)addTFView{
    if (!_addTFView) {
        _addTFView = [CustomView initViewNIB];
        _addTFView.titleLabel.text =@"所在地域";
        _addTFView.customTF.placeholder =@"例：東京都渋谷区";
        _addTFView.searchWidth.constant = 22;
        _addTFView.isBi.hidden = NO;
    }
    return _addTFView;
}
#pragma mark-详细住所
- (CustomView *)addDetailView{
    if (!_addDetailView) {
        _addDetailView = [CustomView initViewNIB];
        _addDetailView.titleLabel.text =@"詳細住所";
        _addDetailView.customTF.placeholder =@"例：渋谷2丁目1-1 サンプルビル 3F";
        _addDetailView.searchWidth.constant = 0;
        _addDetailView.isBi.hidden = NO;
    }
    return _addDetailView;
}
#pragma mark-名称（店舗名など）
-(CustomView *)ShopNameView{
    if (!_ShopNameView) {
        _ShopNameView = [CustomView initViewNIB];
        _ShopNameView.titleLabel.text =@"店舗名称";
        _ShopNameView.customTF.placeholder =@"例：〇〇日本料理";
        _ShopNameView.searchWidth.constant = 0;
        _ShopNameView.isBi.hidden = NO;
        
       
    }
    return _ShopNameView;
}
#pragma mark -メールアドレス
-(CustomView *)emailTFView{
    if (!_emailTFView) {
        _emailTFView = [CustomView initViewNIB];
        _emailTFView.titleLabel.text =@"メールアドレス";
        _emailTFView.customTF.placeholder =@"例：example@example.com";
        _emailTFView.searchWidth.constant = 0;
        _emailTFView.isBi.hidden = NO;
    }
    return _emailTFView;
}
#pragma mark - 電話番号（本人）
-(CustomView *)phoneTFView{
    if (!_phoneTFView) {
        _phoneTFView = [CustomView initViewNIB];
        NSString *str = @"本人電話番号(ハイフンあり)";
        NSMutableAttributedString *attstr = [[NSMutableAttributedString alloc] initWithString:str];
        [attstr addAttributes:@{NSForegroundColorAttributeName:RGB(0xBB1329)} range:NSMakeRange(6, 8)];
        _phoneTFView.titleLabel.attributedText =attstr;
        _phoneTFView.customTF.placeholder =@"090-1234-5678";
        _phoneTFView.searchWidth.constant = 0;
        _phoneTFView.isBi.hidden = NO;
    }
    return _phoneTFView;
}
#pragma mark - 会場名【選択】
-(CustomView *)HuiNameView{
    if (!_HuiNameView) {
        _HuiNameView = [CustomView initViewNIB];
        _HuiNameView.titleLabel.text =@"会場名";
        _HuiNameView.customTF.placeholder =@"例：旭川";
        _HuiNameView.searchWidth.constant = 0;
        _HuiNameView.isBi.hidden = NO;
    }
    return _HuiNameView;
}
#pragma mark - 名前
-(CustomView *)NameFView{
    if (!_NameFView) {
        _NameFView = [CustomView initViewNIB];
      
        _NameFView.titleLabel.text =@"名前";
        _NameFView.customTF.placeholder =@"例：山田太郎";
        _NameFView.searchWidth.constant = 0;
        _NameFView.isBi.hidden = NO;
    }
    return _NameFView;
}
#pragma mark - 担当者写真
- (CustomLineView *)UserPic{
    if (!_UserPic) {
        _UserPic = [CustomLineView initViewNIB];
        _UserPic.titleLabel.text =@"担当者写真";
        _UserPic.searchWidth.constant = 22;
        _UserPic.isBi.text = @"";
        _UserPic.picW.constant = 48;
        
    }
    return _UserPic;
}
#pragma mark - 写真1
- (CustomLineView *)Pic{
    if (!_Pic) {
        _Pic = [CustomLineView initViewNIB];
        _Pic.titleLabel.text =@"店舗紹介写真";
        _Pic.searchWidth.constant = 22;
        _Pic.isBi.text = @"";
        
    }
    return _Pic;
}
#pragma mark - フリーテキスト
- (UITextView *)noteTX{
    if (!_noteTX) {
        _noteTX = [[UITextView alloc] init];
        [_noteTX setPlaceholderWithText:@"特記事項や補足説明" Color:RGB(0x8A8B90)];
        _noteTX.font = [UIFont systemFontOfSize:12];
    }
    return _noteTX;
}
#pragma mark - 店铺Url
- (CustomView *)ShopUrl{
    if (!_ShopUrl) {
        _ShopUrl = [CustomView initViewNIB];
        _ShopUrl.titleLabel.text =@"店舗URL";
        _ShopUrl.customTF.placeholder =@"例：https://www.example.com";
        _ShopUrl.searchWidth.constant = 0;
        _ShopUrl.isBi.text = @"";
    }
    return _ShopUrl;
}
#pragma mark - 席数
-(CustomView *)XishuView{
    if (!_XishuView) {
        _XishuView = [CustomView initViewNIB];
        _XishuView.titleLabel.text =@"席数";
        _XishuView.customTF.placeholder =@"例：20席";
        _XishuView.searchWidth.constant = 0;
        _XishuView.isBi.text = @"";
    }
    return _XishuView;
}

-(huiSelView *)huiSelview
{
    if (!_huiSelview) {
        _huiSelview = [huiSelView initViewNIB];
    }
    return _huiSelview;
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
