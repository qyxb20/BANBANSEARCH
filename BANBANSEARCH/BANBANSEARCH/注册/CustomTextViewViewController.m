//
//  CustomTextViewViewController.m
//  BANBANSEARCH
//
//  Created by apple on 2025/4/9.
//

#import "CustomTextViewViewController.h"

@interface CustomTextViewViewController ()

@end

@implementation CustomTextViewViewController
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
    
    UIView *rightButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    [rightBtn setTitle:@"確認" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor colorWithRed:212 / 255.0 green:48 / 255.0 blue:48 / 255.0 alpha:1] forState:UIControlStateNormal];
       [rightButtonView addSubview:rightBtn];
       
       [returnBtn addTarget:self action:@selector(returnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightCunstomButtonView = [[UIBarButtonItem alloc] initWithCustomView:rightButtonView];
    self.navigationItem.rightBarButtonItem = rightCunstomButtonView;
    

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    self.view.backgroundColor = [UIColor colorWithRed:239 / 255.0 green:239 / 255.0 blue:239 / 255.0 alpha:1];
    [self.textView setPlaceholderWithText:@"请输入xxx" Color:[UIColor colorWithRed:138 / 255.0 green:139 / 255.0 blue:144 / 255.0 alpha:1]];
    
    // Do any additional setup after loading the view from its nib.
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
