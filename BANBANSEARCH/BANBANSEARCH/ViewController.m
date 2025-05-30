//
//  ViewController.m
//  BANBANSEARCH
//
//  Created by apple on 2025/4/7.
//

#import "ViewController.h"

@interface ViewController ()<CLLocationManagerDelegate,GMSMapViewDelegate>
{

    CLLocation *currentLocation;//当前位置坐标
    CLLocationCoordinate2D selCoordinate;//点击的位置坐标
    float currenZoom;//当前地图等级
    GMSMarker *markerSel;//选中标记吗
    NSInteger picHeight;
    NSString *parmue;//搜索字段
}
@property (nonatomic,strong) GMSMapView *mapView;//地图
@property (nonatomic,strong)CLLocationManager *locationManager;
@property (nonatomic,strong) UIButton *againSearch;
@property (nonatomic,strong)SearchHistoryView *searView;///搜索view

@property (nonatomic,strong)shopInforView*shopView;///店铺信息view

@property (nonatomic,strong)NSArray *shopArr;///店铺数据
@property (nonatomic,strong)NSArray *venuesArr;///会场数据
@property (nonatomic,strong)NSMutableArray *marArr;///标记数组
@property (nonatomic,strong)venuesView*huiinfoView;///会场view
@property (nonatomic,strong)MarkCustormView *markView;///自定义markerview
@property (nonatomic,strong)UIButton *myLoction;//我的位置按钮
@end

@implementation ViewController
static NSString *const kMapStyle = @"JSON_STYLE_GOES_HERE";
- (UIStatusBarStyle)preferredStatusBarStyle {
  return UIStatusBarStyleLightContent;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
    [account setIqkeyboardmanager:NO];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.shopView removeFromSuperview];
   
    [account setIqkeyboardmanager:YES];
    [self handleSwipeFromDown];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *leftButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    UIButton *returnBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [leftButtonView addSubview:returnBtn];
    [returnBtn setImage:[UIImage imageNamed:@"shezhi"] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(setClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftCunstomButtonView = [[UIBarButtonItem alloc] initWithCustomView:leftButtonView];
    self.navigationItem.leftBarButtonItem = leftCunstomButtonView;
    //
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(resetUserInfo) name:@"uploadUserInfo" object:nil];
    
    [self initMap];
    
    // Do any additional setup after loading the view.
}
-(void)initMap{
    parmue = @"";
    currenZoom = 16;
    NSError *error;
    NSBundle *mainBundle = [NSBundle mainBundle];
     NSURL *styleUrl = [mainBundle URLForResource:@"mapStyle" withExtension:@"json"];
    GMSMapStyle *style = [GMSMapStyle styleWithContentsOfFileURL:styleUrl error:&error];
    CLLocationCoordinate2D cood = CLLocationCoordinate2DMake(35.68, 139.76);
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithTarget:cood zoom:currenZoom];
    GMSMapID *mapID = [GMSMapID mapIDWithIdentifier:@"quantum-plasma-457201-q0"];
    self.mapView = [GMSMapView mapWithFrame:self.view.bounds  camera:camera];
   
    self.mapView.mapStyle = style;
    self.mapView.delegate = self;

    self.mapView.myLocationEnabled = YES; // 启用定位功能
    self.mapView.settings.myLocationButton = YES; // 显示定位按钮
    [self.view addSubview:self.mapView];
   
    //定位：
    
    self.locationManager = [[CLLocationManager alloc] init];
    
    self.locationManager.delegate  = self;
    
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;// 设置精度
    self.locationManager.distanceFilter = 500;
    
    [self.locationManager requestWhenInUseAuthorization];
    
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    
    [self.locationManager startUpdatingLocation];
    
    self.searView.layer.cornerRadius = 10;
    self.searView.clipsToBounds = YES;
    [self.view addSubview:self.searView];
    
    self.searView.hitoryBtn.hidden = YES;
    self.searView.btn.hidden = YES;
    [self.searView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.trailing.mas_offset(0);
        make.height.mas_offset(104);
    }];
    
    @weakify(self);
    [self.searView setSelePointBlock:^(NSDictionary * _Nonnull dic, NSInteger isShop) {
       
        @strongify(self);
        if (isShop == 1) {
            self->parmue = [NSString isNullStr:dic[@"venuesName"]];
            CLLocationCoordinate2D vancouver = CLLocationCoordinate2DMake([dic[@"venuesLat"] floatValue], [dic[@"venuesLng"] floatValue]);
            GMSCameraUpdate *vancouverCam = [GMSCameraUpdate setTarget:vancouver zoom:16];
            [self.mapView animateWithCameraUpdate:vancouverCam];
            
            [self addMark:vancouver];
        }
        else{
            self->parmue = [NSString isNullStr:dic[@"shopName"]];
            CLLocationCoordinate2D vancouver = CLLocationCoordinate2DMake([dic[@"shopLat"] floatValue], [dic[@"shopLng"] floatValue]);
            GMSCameraUpdate *vancouverCam = [GMSCameraUpdate setTarget:vancouver zoom:16];
            [self.mapView animateWithCameraUpdate:vancouverCam];
            
            [self addMark:vancouver];
        }
    }];
    [self.searView setUpdateFrameBlock:^(NSArray * _Nonnull array) {
        @strongify(self)
        if (array.count < 4) {
            self.searView.btn.hidden = YES;
            self.searView.hitoryBtn.hidden = NO;
            [self.searView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_offset(array.count * 62 + 108 + 20);
            }];
        }
        else if (array.count == 0){
            
            

            self.searView.btn.hidden = YES;
            self.searView.hitoryBtn.hidden = YES;
            self.searView.tableTop.constant = 8;
            [self.searView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_offset(104);
            }];
        }
        else{
            self.searView.btn.hidden = NO;
            [self.searView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_offset(3 * 62 + 108 + 20);
            }];
        }
    }];
    [self.searView setUpdateEditFrameBlock:^(NSArray * _Nonnull array) {
        @strongify(self)
        if (array.count > 0) {
            self.searView.btn.hidden = NO;
        }
        self.searView.hitoryBtn.hidden = NO;
        [self.huiinfoView removeFromSuperview];

        [self.searView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(680);
        }];
    }];
    [self.view addSubview:_shopView];
   
    [_shopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_offset(0);
        make.height.mas_offset(0);
            make.bottom.mas_offset(0);
    
        
    }];

    [self.searView setUpdateReturnFrameBlock:^(NSArray * _Nonnull array) {
        @strongify(self)
        self.searView.btn.hidden = YES;
        self.searView.hitoryBtn.hidden = YES;
        self.searView.tableTop.constant = 8;
        [self.searView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(104);
        }];
    }];
    [self.searView.btn addTapAction:^(UIView * _Nonnull view) {
        @strongify(self);
        if ([self.searView.btn.titleLabel.text isEqual:@"削除"]) {
            CSQAlertView *alert = [[CSQAlertView alloc] initWithTitle:@"" Message:@"全て削除しますか？" btnTitle:@"確定" cancelBtnTitle:@"キャンセル" btnClick:^{
                
                NSDictionary *dic = @{@"list":@[]};
                [SaveManager saveSearchHistoryData:dic];
                [self.searView.searchTF resignFirstResponder];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"updataHistory" object:nil userInfo:nil];

            } cancelBlock:^{
                
            }];
            [alert show];
        }else{
            self.searView.hitoryBtn.hidden = NO;
            self.searView.btn.hidden = NO;
            [self.searView.btn setTitle:@"削除" forState:UIControlStateNormal];
            [self.searView updateloadData:1];
            [self.searView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_offset(680);
            }];
        }
    }];
    
    [self.view addSubview:self.againSearch];
    self.againSearch.hidden = YES;
    [self.againSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_offset(100);
        make.height.mas_offset(40);
        make.width.mas_offset(144);
    }];
    [self.againSearch addTapAction:^(UIView * _Nonnull view) {
        @strongify(self);
        self->markerSel.map = nil;
        self.againSearch.hidden = YES;
        self.searView.searchTF.text = @"";
        self->parmue = @"";
        [self addMark:self->selCoordinate];
        
    }];
    
    self.myLoction = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.myLoction setBackgroundImage:[UIImage imageNamed:@"分组 3 (1)"] forState:UIControlStateNormal];
    [self.view addSubview:self.myLoction];
    [self.myLoction mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_offset(-17.5);
        make.width.height.mas_offset(50);
        make.bottom.mas_equalTo(self.searView.mas_top).mas_offset(-21.5);
    }];
    [self.myLoction addTapAction:^(UIView * _Nonnull view) {
        @strongify(self);
        if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
                  NSLog(@"不可用");
                  
                  CSQAlertView *alert = [[CSQAlertView alloc] initWithTitle:@"" Message:@"位置情報がオフになっています。設定から位置情報の使用を許可してください。" btnTitle:@"確定" cancelBtnTitle:@"キャンセル" btnClick:^{
                      
                      NSURL *appSettings = [NSURL URLWithString:[NSString stringWithFormat:@"%@",UIApplicationOpenSettingsURLString]];
                      [UIApplication.sharedApplication openURL:appSettings options:@{} completionHandler:nil];
                  } cancelBlock:^{

                  }];
                  [alert show];
              }

         else {
                   //定位功能可用，开始定位
            
             CLLocationCoordinate2D vancouver = CLLocationCoordinate2DMake(self->currentLocation.coordinate.latitude, self->currentLocation.coordinate.longitude);
            self->selCoordinate =self->currentLocation.coordinate;
             GMSCameraUpdate *vancouverCam = [GMSCameraUpdate setTarget:vancouver zoom:16];
             [self.mapView animateWithCameraUpdate:vancouverCam];
             
             [self addMark:vancouver];
                   
               }
       

    }];
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFromUp)];
    swipeUp.direction = UISwipeGestureRecognizerDirectionUp; // 设置手势方向为向上
    [self.searView addGestureRecognizer:swipeUp]; // 将手势识别器添加到按钮上
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFromDown)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown; // 设置手势方向为向下
    [self.searView addGestureRecognizer:swipeDown]; // 将手势识别器添加到按钮上
    
    UISwipeGestureRecognizer *swipeUpShop = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFromUpShop)];
    swipeUpShop.direction = UISwipeGestureRecognizerDirectionUp; // 设置手势方向为向上
    [self.shopView addGestureRecognizer:swipeUpShop]; // 将手势识别器添加到按钮上
    UISwipeGestureRecognizer *swipeDownShop = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFromDownShop)];
    swipeDownShop.direction = UISwipeGestureRecognizerDirectionDown; // 设置手势方向为向下
    [self.shopView addGestureRecognizer:swipeDownShop]; // 将手势识别器添加到按钮上
    
    
    
    
}
///店铺的手势
-(void)handleSwipeFromUpShop{
    [self.shopView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(0);
        make.height.mas_offset([self.shopView getLongHeight]);
    }];
}
-(void)handleSwipeFromDownShop{
    [self.shopView mas_updateConstraints:^(MASConstraintMaker *make) {
//        [self.shopView getShortHeight];
        make.height.mas_offset([self.shopView getShortHeight]);
        make.bottom.mas_offset(0);
    }];
}
//搜索的手势
-(void)handleSwipeFromUp{

    NSDictionary *dic = [SaveManager getSearchHistoryData];
    [self.searView updateloadData:0];
    [self.searView.btn setTitle:@"さらに表示" forState:UIControlStateNormal];
    if ([self.searView.searchTF isFirstResponder]) {
        [self.searView.searchTF resignFirstResponder];
    }
    if ([dic allKeys].count >0) {
        
        NSArray *arr = dic[@"list"];
        if (arr.count > 3) {
                self.searView.hitoryBtn.hidden = NO;
                self.searView.btn.hidden = NO;
            [self.searView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_offset(3 * 62 + 108 + 20);
            }];
        }
        else  if (arr.count ==  0) {
//            ToastShow(@"検索履歴がありません。",@"矢量 20",RGB(0xFD9329));
            self.searView.btn.hidden = YES;
            self.searView.hitoryBtn.hidden = YES;
            [self.searView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_offset(104);
            }];
    }
        else{
            self.searView.hitoryBtn.hidden = NO;
            self.searView.btn.hidden = YES;
            [self.searView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_offset(arr.count * 62 + 108 + 20);
            }];
        }
    }
    else{
//        ToastShow(@"検索履歴がありません。",@"矢量 20",RGB(0xFD9329));
    }
}
-(void)handleSwipeFromDown{
    self.searView.hitoryBtn.hidden = YES;
    self.searView.btn.hidden = YES;
    self.searView.tableTop.constant = 8;
    [self.searView.searchTF resignFirstResponder];
            [self.searView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_offset(104);
            }];
       
}
#pragma mark -  CLLocationManagerDelegate

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{

    /**

     *    拿到授权发起定位请求

     */

   
     if (status == kCLAuthorizationStatusDenied) {
         currenZoom = 16;
        
         CLLocationCoordinate2D cood = CLLocationCoordinate2DMake(35.68103420170552, 139.76890052634437);
         self.mapView.camera = [[GMSCameraPosition alloc] initWithTarget:cood zoom:5.5 bearing:0 viewingAngle:0];

         [self addMark:cood];
         [self.myLoction setBackgroundImage:[UIImage imageNamed:@"分组 2 (6)"] forState:UIControlStateNormal];
        
//         GMSCameraPosition *camera = [GMSCameraPosition cameraWithTarget:cood zoom:currenZoom];
     }else{
         [self.myLoction setBackgroundImage:[UIImage imageNamed:@"分组 3 (1)"] forState:UIControlStateNormal];
        
         [self.locationManager startUpdatingLocation];

     }
}

 

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{

    /**

     * 位置更新时调用

     */
    
    CLLocation *location = [locations lastObject];
     
       
       // 移除旧的自定义视图（如果有的话）
       for (UIView *subview in self.mapView.subviews) {
           if ([subview isKindOfClass:[UIImageView class]]) {
               [subview removeFromSuperview];
           }
       }
       
       // 添加新的自定义视图到地图上
   
    currentLocation = locations.firstObject;
    
        currenZoom = 16;
        selCoordinate =currentLocation.coordinate;
        self.mapView.camera = [[GMSCameraPosition alloc] initWithTarget:currentLocation.coordinate zoom:currenZoom bearing:0 viewingAngle:0];

        [self addMark:currentLocation.coordinate];

    [self.locationManager stopUpdatingLocation];

}
///搜索添加标记
-(void)addMark:(CLLocationCoordinate2D)coordinate{
    
    [self.mapView clear];
    [self.huiinfoView removeFromSuperview];
    self.marArr = [NSMutableArray array];
   
    [NetwortTool getNearShopWithParm:@{@"longitude":@(coordinate.longitude),@"latitude":@(coordinate.latitude)} Success:^(id  _Nonnull responseObject) {
        NSLog(@"店铺会场数据：%@",responseObject);
        self.shopArr = responseObject[@"shop"];
        self.venuesArr = responseObject[@"venues"];
        for (int i = 0 ; i<self.shopArr.count; i++) {
            NSDictionary *dic = self.shopArr[i];
            GMSMarker *marker = [[GMSMarker alloc] init];
            marker.position = CLLocationCoordinate2DMake([dic[@"lat"] doubleValue], [dic[@"lng"] doubleValue]);

            CGFloat markerSize;
            CGFloat markerSizeH;
            if ([dic[@"shopName"] isEqual:self->parmue]) {
                markerSize= 29*1.5 ;
                
                markerSizeH= 39 *1.5;
            }else{
                markerSize= 29 ;
                
                markerSizeH= 39 ;
            }
            marker.icon = [UIImage new];
            UIImageView *ima = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, markerSize, markerSizeH)];
            [ima sd_setImageWithURL:[NSURL URLWithString:[NSString isNullStr:dic[@"color"]]]];
//            ima.contentMode = UIViewContentModeScaleToFill;
            marker.iconView = ima;
            

            marker.title =[NSString stringWithFormat:@"%@\n%@\n%@",dic[@"venuesName"],[NSString isNullStr:dic[@"shopTyps"]],dic[@"shopName"]];
            marker.userData =dic;
            marker.snippet = @"shop";
                 marker.map = self.mapView;
            [self.marArr addObject:marker];
        }
        for (int i = 0; i <self.venuesArr.count; i++) {
            
            NSArray *arr = self.venuesArr[i];
            NSDictionary *dic = arr.firstObject;
            if ([NSString isNullStr:dic[@"lat"]].length != 0) {
                GMSMarker *marker = [[GMSMarker alloc] init];
                marker.position = CLLocationCoordinate2DMake([dic[@"lat"] doubleValue], [dic[@"lng"] doubleValue]);
                CGFloat markerSize;
                CGFloat markerSizeH;
                                markerSize= 39 ;
                
                                markerSizeH= 51 ;
                for (int i = 0; i < arr.count; i++) {
                    if ([arr[i][@"venuesName"] isEqual:self->parmue]) {
                        markerSize= 39*1.5 ;
                        
                        markerSizeH= 51 *1.5;
                        break;
                    }
                }

                UIImageView *ima = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, markerSize, markerSizeH)];
                
                if (arr.count > 1) {
                    ima.image = [UIImage imageNamed:@"huiZhen"];
                }else{
                    [ima sd_setImageWithURL:[NSURL URLWithString:[NSString isNullStr:dic[@"color"]]]];
                }
//                ima.contentMode = UIViewContentModeScaleToFill;
                marker.iconView = ima;
      
                    marker.title =dic[@"venuesName"];

                marker.userData =arr;
                marker.snippet = @"venues";
                marker.map = self.mapView;
                [self.marArr addObject:marker];
               
            }
        
           
            
        }
    } failure:^(NSError * _Nonnull error) {
        ToastShow(error.userInfo[@"httpError"],@"矢量 20",RGB(0xFF830F));
    }];

    
}
///点击标记
-   (BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker {
//  if (marker.title && marker.snippet) {
    [self.shopView removeFromSuperview];
    if (marker == markerSel) {
        return YES;
    }
      NSLog(@"marker with title:%@ snippet: %@", marker.title,  marker.snippet);
    if ([marker.snippet isEqual:@"shop"]) {
        
    
   
    [HudView showHudForView:self.view];
        NSDictionary *dic = marker.userData;
    [NetwortTool getShopInfoWithParm:@{@"shopId":dic[@"id"]} Success:^(id  _Nonnull responseObject) {
        [HudView hideHudForView:self.view];
        NSLog(@"输出店铺详情数据:%@",responseObject);
        
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            ToastShow(@"選択された店舗はすでに削除されています。",@"矢量 20",RGB(0xFF830F));
            return;
        }

        [self.shopView updateData:responseObject];
        [self.view addSubview:self.shopView];
        
        [self.shopView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.mas_offset(0);
            make.bottom.mas_offset(0);
//            make.height.mas_offset([self.shopView getShortHeight]);
        }];
        [self handleSwipeFromDownShop];

    } failure:^(NSError * _Nonnull error) {
        [HudView hideHudForView:self.view];
        ToastShow(error.userInfo[@"httpError"],@"矢量 20",RGB(0xFF830F));
    }];
    }
    else{
        CGPoint point = [mapView.projection pointForCoordinate:marker.position];
        NSArray *arr = marker.userData;
        [NetwortTool getVenvesInfoWithParm:@{@"venuesId":[NSString isNullStr:arr.firstObject[@"id"]]} Success:^(id  _Nonnull responseObject) {
            [self.huiinfoView removeFromSuperview];
            NSArray *arr = responseObject;
            self.huiinfoView = [venuesView initViewNIB];
            self.huiinfoView.backgroundColor = [UIColor whiteColor];
            self.huiinfoView.layer.cornerRadius = 6;
            self.huiinfoView.clipsToBounds = YES;
            self.huiinfoView.backgroundColor = [UIColor clearColor];
            [self.huiinfoView updataWithArray:arr];
            [self.view addSubview:self.huiinfoView];
            if (arr.count == 1) {
                self.huiinfoView.frame = CGRectMake(point.x - 83, point.y - 5, 186, 54);
            }
            else{
                self.huiinfoView.frame = CGRectMake(point.x - 83, point.y - 5, 186, 98);
            }
            
            
            
        } failure:^(NSError * _Nonnull error) {
            ToastShow(error.userInfo[@"httpError"],@"矢量 20",RGB(0xFF830F));
        }];
       
           
    }
//  }
  return YES;
}
#pragma  mark - GMSMapview Delegate
//点击地图
- (void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate{
    
    self.againSearch.hidden = NO;
    [self handleSwipeFromDown];
    [self.huiinfoView removeFromSuperview];
    markerSel.map = nil;
   

    selCoordinate = coordinate;
    markerSel = [GMSMarker markerWithPosition:coordinate];
    markerSel.icon = [UIImage imageNamed:@"分组 1 (2)"];
    markerSel.map = mapView;
   
}
- (void)mapView:(GMSMapView *)mapView didTapMyLocation:(CLLocationCoordinate2D)location{
    
    
}

//镜头移动完成后调用
- (void)mapView:(GMSMapView *)mapView idleAtCameraPosition:(GMSCameraPosition *)position{
    if (selCoordinate.latitude == currentLocation.coordinate.latitude && selCoordinate.longitude == currentLocation.coordinate.longitude) {
        [self.myLoction setBackgroundImage:[UIImage imageNamed:@"分组 3 (1)"] forState:UIControlStateNormal];
        selCoordinate = position.target;
    }
    else{
        [self.myLoction setBackgroundImage:[UIImage imageNamed:@"分组 2 (6)"] forState:UIControlStateNormal];
       
    }
  

    for (int i = 0; i <self.marArr.count; i++) {
        GMSMarker *marker = self.marArr[i];
        
        if ([marker.snippet isEqual:@"shop"]) {
            NSDictionary *dic = marker.userData;
                if (position.zoom >= 16.5) {
                    ///地图级别>16.5显示 店铺的会场名、营业形态、店铺名 名字长度不能超过10
                    if (marker.iconView.size.width == 29*1.5 || marker.iconView.size.width == 29) {
                        MarkCustormView *markView = [MarkCustormView initViewNIB];
     
                        CGFloat a = [Tool getLabelWidthWithText:dic[@"venuesName"] height:20 custonfont:[UIFont boldSystemFontOfSize:15]]+10;
                        CGFloat b = [Tool getLabelWidthWithText:dic[@"shopTyps"] height:20 custonfont:[UIFont boldSystemFontOfSize:15]]+10;
                        CGFloat c = [Tool getLabelWidthWithText:dic[@"shopName"] height:20 custonfont:[UIFont boldSystemFontOfSize:15]] +10;
                        
                        CGFloat w = (a > b) ? ((a > c) ? a : c) : ((b > c) ? b : c);
                       

                        if (w > 187) {
                            w = 187;
                        }

                        markView.height = 68;
                        if ([dic[@"venuesName"] length] > 10) {
                            markView.huiName.text = [NSString stringWithFormat:@"%@...",[dic[@"venuesName"] substringToIndex:10]];
                            
                        }else{
                            markView.huiName.text =dic[@"venuesName"];
                        }
                        if ([dic[@"shopTyps"] length] > 10) {
                            markView.title.text = [NSString stringWithFormat:@"%@...",[dic[@"shopTyps"] substringToIndex:10]];
                            
                        }else{
                            markView.title.text =dic[@"shopTyps"];
                        }
                        if ([dic[@"shopName"] length] > 10) {
                            markView.shopName.text = [NSString stringWithFormat:@"%@...",[dic[@"shopName"] substringToIndex:10]];
                            
                        }else{
                            markView.shopName.text =dic[@"shopName"];
                        }
                        markView.width = w +marker.iconView.size.width + 4;
                        markView.backgroundColor = [UIColor clearColor];
                        markView.picW.constant =marker.iconView.size.width;
                        markView.picH.constant =marker.iconView.size.height;
                        markView.title.numberOfLines = 3;
                        markView.pic.contentMode = UIViewContentModeScaleToFill;
                        [markView.pic sd_setImageWithURL:[NSURL URLWithString:dic[@"color"]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                            markView.pic.image = image;
                        }];
                          

                            float anchorX = (float) (0 + marker.iconView.size.width / 2) / (w +marker.iconView.size.width+4);

                            marker.groundAnchor = CGPointMake(anchorX, 1);
                        marker.iconView.size = CGSizeMake(w +29*1.5+4, 68);
                            marker.iconView = markView;
                       
                    }
                   

                }
                else{
///<16.5恢复原来形态
                    marker.groundAnchor = CGPointMake(0.5, 1);
                    CGFloat markerSize;
                    CGFloat markerSizeH;
                    if ([dic[@"shopName"] isEqual:parmue]) {
                        markerSize= 29*1.5 ;
                        
                        markerSizeH= 39 *1.5;
                    }else{
                        markerSize= 29 ;
                        
                        markerSizeH= 39 ;
                    }
                    if (marker.iconView.size.width > markerSize) {
                        UIImageView *ima = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, markerSize, markerSizeH)];
                        [ima sd_setImageWithURL:[NSURL URLWithString:[NSString isNullStr:dic[@"color"]]]];
                        ima.contentMode = UIViewContentModeScaleToFill;
                        marker.iconView = ima;
                    }
                    


                }

        }
        else{

            NSArray *arr = marker.userData;
            NSDictionary *dic = arr.firstObject;
                if (position.zoom >= 16.5) {
                    ///地图级别>16.5显示 会场名 最多显示两个 名字长度不能超过10
                    CGFloat w = [Tool getLabelWidthWithText:marker.title height:45 font:16];
                    CGFloat h = [Tool getLabelHeightWithText:marker.title width:136 font:16];
                    if (h > 11) {
                        w = 136;
                    }
                    if (arr.count >= 2) {
                        
                        CGFloat a = [Tool getLabelWidthWithText:arr[0][@"venuesName"] height:20 custonfont:[UIFont boldSystemFontOfSize:15]] + 10;
                        CGFloat b = [Tool getLabelWidthWithText:arr[1][@"venuesName"] height:20 custonfont:[UIFont boldSystemFontOfSize:15]] + 10;
                        CGFloat c = [Tool getLabelWidthWithText:@"..." height:20 custonfont:[UIFont boldSystemFontOfSize:15]] + 10;
                        
                         w = (a > b) ? ((a > c) ? a : c) : ((b > c) ? b : c);

//                        CGFloat w = [Tool getLabelWidthWithText:marker.title height:65 font:16];
                        if (w > 187) {
                            w = 187;
                        }
                        NSLog(@"*********%@ ，%f,%f,%f,%f",marker.title,a,b,c,w);
                       
                    }
                    NSLog(@"*********%@ ，%f",marker.title,w);
                    if (marker.iconView.size.width == 39*1.5 || marker.iconView.size.width == 39) {
                        
                        
                        MarkCustormView *markView = [MarkCustormView initViewNIB];
                        NSArray *arr =marker.userData;
                        
                        CGFloat markerSize;
                        CGFloat markerSizeH;
                                        markerSize= 39 ;
                        
                                        markerSizeH= 51 ;
                        for (int i = 0; i < arr.count; i++) {
                            if ([arr[i][@"venuesName"] isEqual:parmue]) {
                                markerSize= 39*1.5 ;
                                
                                markerSizeH= 51 *1.5;
                                break;
                            }
                        }

                        markView.width = w +markerSize +4;
                        markView.backgroundColor = [UIColor clearColor];
                        if (arr.count == 1) {
//                            markView.title.text =arr[0][@"venuesName"];
                            markView.huiName.text =@"";
                            if ([arr[0][@"venuesName"] length] > 10) {
                                markView.title.text = [NSString stringWithFormat:@"%@...",[arr[0][@"venuesName"] substringToIndex:10]];
                                
                            }else{
                                markView.title.text =arr[0][@"venuesName"];
                            }
                            markView.shopName.text =@"";
                        }
                       else if (arr.count == 2) {
//                            markView.title.text =arr[0][@"venuesName"];
                           if ([arr[0][@"venuesName"] length] > 10) {
                               markView.huiName.text = [NSString stringWithFormat:@"%@...",[arr[0][@"venuesName"] substringToIndex:10]];
                               
                           }else{
                               markView.huiName.text =arr[0][@"venuesName"];
                           }
                           if ([arr[1][@"venuesName"] length] > 10) {
                               markView.title.text = [NSString stringWithFormat:@"%@...",[arr[1][@"venuesName"] substringToIndex:10]];
                               
                           }else{
                               markView.title.text =arr[1][@"venuesName"];
                           }
                            markView.shopName.text =@"";
                        }
                        else{
                            if ([arr[0][@"venuesName"] length] > 10) {
                                markView.huiName.text = [NSString stringWithFormat:@"%@...",[arr[0][@"venuesName"] substringToIndex:10]];
                                
                            }else{
                                markView.huiName.text =arr[0][@"venuesName"];
                            }
                            if ([arr[1][@"venuesName"] length] > 10) {
                                markView.title.text = [NSString stringWithFormat:@"%@...",[arr[1][@"venuesName"] substringToIndex:10]];
                                
                            }else{
                                markView.title.text =arr[1][@"venuesName"];
                            }
                            markView.shopName.text =@"...";
                        }
//                        markView.pic.image = marker.icon;
//                        markView.pic.contentMode = UIViewContentModeScaleToFill;
                        if (arr.count > 1) {
                            //一个地点多个会场 会场图片为红色
                            markView.pic.image = [UIImage imageNamed:@"huiZhen"];
                        }else{
                            [markView.pic sd_setImageWithURL:[NSURL URLWithString:dic[@"color"]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                                markView.pic.image = image;
                            }];
                        }
                        markView.picW.constant =markerSize;
                        markView.picH.constant =markerSizeH;
                        markView.title.numberOfLines = 3;
                        markView.height = 68;
                        float anchorX = (float) (0 + marker.iconView.size.width / 2) / (w +markerSize +4);
                        
                        marker.groundAnchor = CGPointMake(anchorX, 1);
                        
                        marker.iconView = markView;
                    }
                }
                else{
//恢复无名字状态
                    marker.groundAnchor = CGPointMake(0.5, 1);
                    NSArray *arr =marker.userData;
                    
                    CGFloat markerSize;
                    CGFloat markerSizeH;
                                    markerSize= 39 ;
                    
                                    markerSizeH= 51 ;
                    for (int i = 0; i < arr.count; i++) {
                        if ([arr[i][@"venuesName"] isEqual:parmue]) {
                            markerSize= 39*1.5 ;
                            
                            markerSizeH= 51 *1.5;
                            break;
                        }
                    }
                    if (marker.iconView.size.width > markerSize) {
                        UIImageView *ima = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, markerSize, markerSizeH)];
                        if (arr.count > 1) {
                            ima.image = [UIImage imageNamed:@"huiZhen"];
                        }else{
                            [ima sd_setImageWithURL:[NSURL URLWithString:[NSString isNullStr:dic[@"color"]]]];
                        }
//                        ima.contentMode = UIViewContentModeScaleToFill;
                        marker.iconView = ima;
                    }

                }


        }
 //            marker.icon = resizedImage; // 应用新的图标大小
            
    }
        
}

- (void)mapView:(GMSMapView *)mapView didChangeCameraPosition:(GMSCameraPosition *)position {
        
    [self.huiinfoView removeFromSuperview];
    
    
   
}
      






-(void)resetUserInfo{
    
}
///左侧设置按钮点击
-(void)setClick{
    if (account.isLogin) {
        ///登录
        ShopManagerViewController *vc = [[ShopManagerViewController alloc] init];
        [self.navigationController pushViewController:vc animated:NO];


    }else{
        ///未登录
        LoginViewController *vc = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:vc animated:NO];

      
    }
   
    
}
- (SearchHistoryView *)searView{
    if (!_searView) {
        _searView = [SearchHistoryView initViewNIB];
    }
    return _searView;
}

-(shopInforView *)shopView{
    if (!_shopView) {
        _shopView = [shopInforView initViewNIB];
        @weakify(self);
        [_shopView setCallBlock:^(NSString * _Nonnull callStr) {
            @strongify(self);

            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callStr] options:@{} completionHandler:nil];//phoneNumber是电话号码，例如1234567890
        }];
    }
   
    return _shopView;
    
}
- (MarkCustormView *)markView{
    if (!_markView) {
        _markView = [MarkCustormView initViewNIB];
    }
    return _markView;
}
///再次检索按钮
- (UIButton *)againSearch{
    if (!_againSearch) {
        _againSearch = [UIButton buttonWithType:UIButtonTypeCustom];
        [_againSearch setTitle:@"このエリアで再検索" forState:UIControlStateNormal];
        [_againSearch setImage:[UIImage imageNamed:@"路径 1 (13)"] forState:UIControlStateNormal];
        [_againSearch layoutButtonWithButtonStyle:ButtonStyleImageLeftTitleRight imageTitleSpace:7];
        [_againSearch setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        _againSearch.clipsToBounds = YES;
        _againSearch.layer.cornerRadius = 20;
        _againSearch.backgroundColor = [UIColor whiteColor];
       
        _againSearch.titleLabel.font = [UIFont boldSystemFontOfSize:11];
    }
    return _againSearch;
}
@end
