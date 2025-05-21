//
//  CancelDetailViewController.m
//  BANBANSEARCH
//
//  Created by apple on 2025/4/22.
//

#import "CancelDetailViewController.h"

@interface CancelDetailViewController ()
@property (weak, nonatomic) IBOutlet UIButton *choseBtn;
@property (weak, nonatomic) IBOutlet UILabel *agreeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentL;

@end

@implementation CancelDetailViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"矩形 1"] forBarMetrics:UIBarMetricsDefault];
    
}
-(void)returnClick{
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
   
    self.title = @"ア力ウント削除";
   

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    self.view.backgroundColor = [UIColor colorWithRed:239 / 255.0 green:239 / 255.0 blue:239 / 255.0 alpha:1];
    @weakify(self);
    [self.agreeLabel addTapAction:^(UIView * _Nonnull view) {
        @strongify(self);
        if (!self.choseBtn.selected) {
            self.choseBtn.selected = YES;
        }
        else{
            self.choseBtn.selected = NO;
        }
    }];
    self.contentL.text = @"１．ご利用中の店舗にサブスクリプションが紐づいている場合は、アカウントを削除する前に必ずキャンセルまたは解約のお手続きをお願いいたします。\n・iOS：[設定] > [サブスクリプション管理]\n・Android：[Google Play ストア] > [アカウント] > [サブスクリプション管理]\n２．キャンセルまたは解約のお手続きが完了していない場合、店舗を削除することはできません。\n３．有効な店舗が存在する場合、アカウント削除することはできません。\n４．なお、同じ店舗または別の店舗を再度登録する場合は、現在のサブスクリプション期間が終了した後に登録可能となります。";
    // Do any additional setup after loading the view from its nib.
    
}
- (IBAction)choseClick:(UIButton *)sender {
    if (!sender.selected) {
        sender.selected = YES;
    }else{
        sender.selected = NO;
    }
}
- (IBAction)deleBtnClick:(UIButton *)sender {
    if (!self.choseBtn.selected) {
        ToastShow(@"アカウント削除に同意するチェックボックスを確認してください。",@"矢量 20",RGB(0xFD9329));
        return;
    }
    CSQAlertView *alert = [[CSQAlertView alloc] initWithTitle:@"" Message:@"アカウントを削除しますか?" btnTitle:@"確定" cancelBtnTitle:@"キャンセル" btnClick:^{
        
        [self deleUser];
    } cancelBlock:^{

    }];
    [alert show];
}
-(void)deleUser{
    NSInteger canceloption = [self.dic[@"dictCode"] integerValue];
    [NetwortTool getCancelUserWithParm:@{@"cancelOption":@(canceloption),@"cancelNotes":self.noteStr} Success:^(id  _Nonnull responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            ToastShow(@"アカウントを削除しました。",@"chenggong",RGB(0x5EC907));
            [account logout];
            [self.navigationController popToRootViewControllerAnimated:NO];
        });
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
