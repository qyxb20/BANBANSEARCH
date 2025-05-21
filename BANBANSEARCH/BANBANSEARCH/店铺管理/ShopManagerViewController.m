//
//  ShopManagerViewController.m
//  BANBANSEARCH
//
//  Created by apple on 2025/4/14.
//

#import "ShopManagerViewController.h"

@interface ShopManagerViewController ()<UITableViewDelegate,UITableViewDataSource,SKRequestDelegate,SKProductsRequestDelegate>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)NothingView *nothView;
@property (nonatomic, strong)UIButton *shopAddOrLogin;
@property (nonatomic, strong)UIButton *returnBtn;
@property (strong, nonatomic) SKProductsRequest *productsRequest;
@property (strong, nonatomic) NSSet *validProductIdentifiers;
@property (strong, nonatomic) SKPaymentQueue *paymentQueue;
 
@end

@implementation ShopManagerViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"矩形 1"] forBarMetrics:UIBarMetricsDefault];
   
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}
-(void)initData{
    UIView *leftButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 25, 17)];
    UIButton *returnBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 17)];
       [leftButtonView addSubview:returnBtn];
       [returnBtn setImage:[UIImage imageNamed:@"returnfanhuizuo"] forState:UIControlStateNormal];
       [returnBtn addTarget:self action:@selector(returnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftCunstomButtonView = [[UIBarButtonItem alloc] initWithCustomView:leftButtonView];
      self.navigationItem.leftBarButtonItem = leftCunstomButtonView;

    UIView *rightButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 78, 27)];
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0,78, 27)];
       [rightButtonView addSubview:rightBtn];
       [rightBtn setImage:[UIImage imageNamed:@"分组 9"] forState:UIControlStateNormal];
       [rightBtn addTarget:self action:@selector(setClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightCunstomButtonView = [[UIBarButtonItem alloc] initWithCustomView:rightButtonView];
      self.navigationItem.rightBarButtonItem = rightCunstomButtonView;

}
-(void)setClick{
    CancelViewController *vc = [[CancelViewController alloc] init];
    [self.navigationController pushViewController:vc animated:NO];
}
-(void)returnClick{
    [self.navigationController popViewControllerAnimated:NO];
//    [self dismissViewControllerAnimated:NO completion:nil];
}
-(void)viewDidLoad{
    [super viewDidLoad];
    [self initData];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_offset(0);
        make.top.mas_offset(10);
        make.bottom.mas_offset(-164);
    }];
    [self.view addSubview:self.shopAddOrLogin];
    
    [self.shopAddOrLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_offset(34);
        make.trailing.mas_offset(-34);
        make.height.mas_offset(48);
        make.bottom.mas_offset(48);
    }];
    
    [self.view addSubview:self.returnBtn];
    [self.returnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_offset(34);
        make.trailing.mas_offset(-34);
        make.height.mas_offset(48);
        make.bottom.mas_offset(120);
        
    }];
    
    self.dataArray = [NSMutableArray array];
    [self getData];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(resetUserInfo) name:@"uploadShopInfo" object:nil];

  
    // Do any additional setup after loading the view.
}
 -(void)resetUserInfo{
     [self getData];
 }
///获取数据
-(void)getData{
    
    [NetwortTool getShopWithParm:@{} Success:^(id  _Nonnull responseObject) {
        NSArray *arr = responseObject;
        self.dataArray = [arr mutableCopy];
        [self.tableView reloadData];
        
        @weakify(self);
        if (self.dataArray.count == 0) {
            self.nothView.topCustom.constant = 134;
            self.nothView.bgView.backgroundColor = [UIColor colorWithRed:187 / 255.0 green:19 / 255.0 blue:41 / 255.0 alpha:0.07];
              self.tableView.backgroundView = self.nothView;
            self.shopAddOrLogin.hidden = NO;
            [self.shopAddOrLogin setTitle:@"新規店舗登録" forState:UIControlStateNormal];
            [self.shopAddOrLogin mas_updateConstraints:^(MASConstraintMaker *make) {
               
                make.bottom.mas_offset(-281);
            }];
            
            [self.returnBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_offset(-217);
            }];
            
            [self.shopAddOrLogin addTapAction:^(UIView * _Nonnull view) {
                @strongify(self);

                ResignViewController *vc = [[ResignViewController alloc] init];
                vc.dataDic = @{};
                [self.navigationController pushViewController:vc animated:NO];
//                [self checkSubscriptionStatus];
            }];
            [self.returnBtn addTapAction:^(UIView * _Nonnull view) {
                @strongify(self);
                [self logoutTip];
            }];
        }
        else{
            self.tableView.backgroundView = nil;
            self.shopAddOrLogin.hidden = YES;
            [self.shopAddOrLogin setTitle:@"追加店舗登録" forState:UIControlStateNormal];
            [self.shopAddOrLogin mas_updateConstraints:^(MASConstraintMaker *make) {
               
                make.bottom.mas_offset(-130);
            }];
//            
            [self.returnBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_offset(-62);
            }];

            [self.returnBtn addTapAction:^(UIView * _Nonnull view) {
                @strongify(self);
                [self logoutTip];
//                [self.navigationController popViewControllerAnimated:NO];
            }];
        }
        
    } failure:^(NSError * _Nonnull error) {
        ToastShow(error.userInfo[@"httpError"],@"矢量 20",RGB(0xFF830F));
    }];
    
    
    
    
    
    
    
    
   
   
}
///退出登录
-(void)logoutTip{
    CSQAlertView *alert = [[CSQAlertView alloc] initWithTitle:@"" Message:@"ログアウトしますか？" btnTitle:@"確定" cancelBtnTitle:@"キャンセル" btnClick:^{
        
        [self logout];
    } cancelBlock:^{

    }];
    [alert show];
}

-(void)logout{
    [NetwortTool getlogOutWithParm:@{} Success:^(id  _Nonnull responseObject) {
        [account logout];
        [self.navigationController popToRootViewControllerAnimated:NO];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ShopManagerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShopManagerTableViewCell"];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"ShopManagerTableViewCell" owner:self options:nil].lastObject;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *dic = self.dataArray[indexPath.row];
   
    [cell.pic sd_setImageWithURL:[NSURL URLWithString:[NSString isNullStr:dic[@"shopImage"]]] placeholderImage:[UIImage imageNamed:@"矩形 12"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (image) {
            UIImage *grayScaleImage = [[Tool alloc] convertImageToGreyScale:image];
            if ([dic[@"shopStatus"] intValue] == 0) {
                cell.pic.image = grayScaleImage;
            }
            else{
                cell.pic.image = image;
            }
        }
    }];
    cell.pic.contentMode = UIViewContentModeScaleAspectFill;
    if ([dic[@"shopStatus"] intValue] == 0) {
        cell.isBuy.hidden = YES;
        cell.payBtn.hidden = NO;
       
    }else{
        cell.isBuy.hidden = YES;
        cell.payBtn.hidden = YES;
    }
   
    cell.titleLabel.text = dic[@"shopName"];
    cell.addLabel.text = [NSString stringWithFormat:@"%@-%@-%@ %@",  dic[@"shopProvince"],dic[@"shopCity"],dic[@"shopArea"],dic[@"shopAddress"]];
    [cell.delBtn setImage:[UIImage imageNamed:@"delNo"] forState:UIControlStateNormal];
    [cell.delBtn setTitle:@"削除" forState:UIControlStateNormal];
    [cell.delBtn layoutButtonWithButtonStyle:ButtonStyleImageLeftTitleRight imageTitleSpace:5];
    
    [cell.editBtn setImage:[UIImage imageNamed:@"editNo"] forState:UIControlStateNormal];
    [cell.editBtn setTitle:@"編集" forState:UIControlStateNormal];
    [cell.editBtn layoutButtonWithButtonStyle:ButtonStyleImageLeftTitleRight imageTitleSpace:5];
   
    @weakify(self);
    [cell.delBtn addTapAction:^(UIView * _Nonnull view) {
        @strongify(self);

        shopDelViewController *vc = [[shopDelViewController alloc] init];
        vc.dic = dic;
        [self.navigationController pushController:vc];
        }];
    [cell.editBtn addTapAction:^(UIView * _Nonnull view) {
        @strongify(self);
        ResignViewController *vc = [[ResignViewController alloc] init];
        vc.dataDic = dic;
        [self.navigationController pushViewController:vc animated:NO];
    }];
    [cell.payBtn addTapAction:^(UIView * _Nonnull view) {
        @strongify(self);
        OpenVipViewController *vc = [[OpenVipViewController alloc] init];
        vc.shopId = dic[@"shopId"];
        [self.navigationController pushController:vc];
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

 }
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        return 126;
 }
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
       
        _tableView.showsVerticalScrollIndicator = NO;

    }
    return _tableView;
}
-(NothingView *)nothView{
    if (!_nothView) {
        _nothView =[NothingView initViewNIB];
        _nothView.backgroundColor = [UIColor clearColor];
//        _nothingView.ima.image = [UIImage imageNamed:@"shopcartEmty"];
    
    }
    return _nothView;
}
- (UIButton *)shopAddOrLogin{
    if (!_shopAddOrLogin) {
        _shopAddOrLogin = [UIButton buttonWithType:UIButtonTypeCustom];
        _shopAddOrLogin.backgroundColor = [UIColor blackColor];
        
        _shopAddOrLogin.layer.cornerRadius = 4;
        _shopAddOrLogin.clipsToBounds = YES;
    }
    return _shopAddOrLogin;
}
- (UIButton *)returnBtn{
    if (!_returnBtn) {
        _returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_returnBtn setTitle:@"ログアウト" forState:UIControlStateNormal];
        [_returnBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        _returnBtn.layer.cornerRadius = 4;
        _returnBtn.clipsToBounds = YES;
        _returnBtn.layer.borderColor = [UIColor colorWithRed:204 / 255.0 green:204 / 255.0 blue:204 / 255.0 alpha:1].CGColor;
        _returnBtn.layer.borderWidth = 0.5;
    }
    return _returnBtn;
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
