//
//  CancelReasonViewController.m
//  BANBANSEARCH
//
//  Created by apple on 2025/4/23.
//

#import "CancelReasonViewController.h"

@interface CancelReasonViewController ()<UITextViewDelegate>
//@property (weak, nonatomic) IBOutlet UITextView *otherTX;
//@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (strong, nonatomic)UIButton *tmpBtn;
@property (strong, nonatomic)NSString *resanStr;
@property (strong, nonatomic) UILabel *numLabel;
@property(nonatomic, strong)UIScrollView *scrollView;
@property(nonatomic, strong)NSArray *dataArray;
@property (strong, nonatomic)  UITextView *otherTX;
@end

@implementation CancelReasonViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"矩形 1"] forBarMetrics:UIBarMetricsDefault];
    [account setIqkeyboardmanager:YES];
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
   
    self.title = @"ア力ウント削除理由";
   

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    self.view.backgroundColor = [UIColor colorWithRed:239 / 255.0 green:239 / 255.0 blue:239 / 255.0 alpha:1];
//    self.otherTX.delegate = self;
//    [self.otherTX setPlaceholderWithText:@"その他のご意見を入カしてください。" Color:RGB(0xA6A6A6)];
//
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.scrollEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_offset(0);
        make.top.mas_offset(17);
        make.bottom.mas_offset(-157);
    }];
    
    
    [self getData];
    
    
    // Do any additional setup after loading the view from its nib.
}
-(void)getData{
    [NetwortTool getCancelMsgWithParm:@{} Success:^(id  _Nonnull responseObject) {
        self.dataArray = responseObject;
        [self createBgUI];
        } failure:^(NSError * _Nonnull error) {
            ToastShow(error.userInfo[@"httpError"],@"矢量 20",RGB(0xFF830F));
        }];
}

-(void)createBgUI{
    UIView *bgView = [[UIView alloc] init];
    bgView.frame = CGRectMake(15, 0, WIDTH - 30, self.dataArray.count * 48 + 184 + 30);
    
    bgView.backgroundColor = RGB(0xEFEFEF);
    bgView.layer.cornerRadius = 6;
    bgView.clipsToBounds = YES;
    [self.scrollView addSubview:bgView];
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, bgView.width, self.dataArray.count * 48)];
    whiteView.backgroundColor = [UIColor whiteColor];
    whiteView.layer.cornerRadius = 6;
    whiteView.clipsToBounds = YES;
    [bgView addSubview:whiteView];
    
    for (int i = 0; i < self.dataArray.count; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(17, 17 + 48 * i, 220, 14)];
        label.text = self.dataArray[i][@"dictLabel"];
        label.font = [UIFont systemFontOfSize:12];
        [whiteView addSubview:label];
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(16, 47 + 47 * i, whiteView.width - 32, 1)];
        line.backgroundColor = RGB(0xEFEFEF);
        [whiteView addSubview:line];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"路径 8"] forState:UIControlStateSelected];
        [btn setImage:[UIImage imageNamed:@"路径 1 (12)"] forState:UIControlStateNormal];
        btn.frame = CGRectMake(whiteView.width - 37, 15 + 48 * i, 18, 18);
        btn.tag = i;
        [btn addTarget:self action:@selector(choseClick:) forControlEvents:UIControlEventTouchUpInside];
        [whiteView addSubview:btn];
    }
    
    
    
    
    
    
    
    
    
    
    
    
    UIView *otherView = [[UIView alloc] initWithFrame:CGRectMake(0, whiteView.bottom + 30, whiteView.width, 184)];
    otherView.backgroundColor = [UIColor whiteColor];
    otherView.layer.cornerRadius = 6;
    otherView.clipsToBounds = YES;
    [bgView addSubview:otherView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(17, 17, 80, 14)];
    label.text = @"その他ご意見";
    label.font = [UIFont systemFontOfSize:12];
    [otherView addSubview:label];
    self.numLabel = [[UILabel alloc] initWithFrame:CGRectMake(otherView.width - 19 - 100, 17, 100, 14)];
    self.numLabel.text = @"0/200";
    self.numLabel.font = [UIFont systemFontOfSize:12];
    self.numLabel.textAlignment = NSTextAlignmentRight;
    [otherView addSubview:self.numLabel];
    
    self.scrollView.contentSize = CGSizeMake(WIDTH,  otherView.bottom + 20);
    
    self.otherTX = [[UITextView alloc] initWithFrame:CGRectMake(19, 48, otherView.width - 38, 120)];
    self.otherTX.backgroundColor = RGB(0xEFEFEF);
    [self.otherTX setPlaceholderWithText:@"その他のご意見を入カしてください。" Color:RGB(0xA6A6A6)];
    self.otherTX.font = [UIFont systemFontOfSize:10];
    self.otherTX.delegate = self;
    [otherView addSubview:self.otherTX];
    

    
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
       
            NSUInteger newLength = textView.text.length + text.length - range.length;
           
    self.numLabel.text = [NSString stringWithFormat:@"%lu/200",(unsigned long)newLength];
            
            return newLength <= 200;
         
   
}
- (void)choseClick:(UIButton *)sender {
    if (_tmpBtn == nil){
            sender.selected = YES;
            _tmpBtn = sender;
        }
        else if (_tmpBtn !=nil && _tmpBtn == sender){
            _tmpBtn.selected = NO;
            sender.selected = YES;
            _tmpBtn = sender;
        }
        else{
            _tmpBtn.selected = NO;
            sender.selected = YES;
            _tmpBtn = sender;
        }
    
//    if (!sender.selected) {
//        sender.selected = YES;
//    }else{
//        sender.selected = NO;
//    }
}

- (IBAction)nextBtnClick:(UIButton *)sender {
    
    if (_tmpBtn == nil) {
       
        ToastShow(@"アカウント削除理由を選択してください。",@"矢量 20",RGB(0xFD9329));
        return;
    }
//    if (self.otherTX.text.length == 0) {
//       
//        ToastShow(@"请填写意见",@"矢量 20",RGB(0xFD9329));
//        return;
//    }
    NSLog(@"选中理由：%@",self.dataArray[self.tmpBtn.tag]);
    
//    [NetwortTool getCancelMsgWithParm:@{} Success:^(id  _Nonnull responseObject) {
        CancelDetailViewController *vc = [[CancelDetailViewController alloc] init];
    vc.dic = self.dataArray[self.tmpBtn.tag];
    vc.noteStr = self.otherTX.text;
        [self.navigationController pushController:vc];
//        } failure:^(NSError * _Nonnull error) {
//            ToastShow(error.userInfo[@"httpError"],@"矢量 20",RGB(0xFF830F));
//        }];
    
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
