//
//  MineWebKitViewController.m
//  Netneto
//
//  Created by 才诗琦 on 2024/9/24.
//

#import "MineWebKitViewController.h"
#import <WebKit/WKWebView.h>
@interface MineWebKitViewController ()
@property (weak, nonatomic) IBOutlet WKWebView *vi;
@property(nonatomic, strong)UIImageView *bgHeaderView;
@end

@implementation MineWebKitViewController
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
   
   
   

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self.vi addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    [self.vi loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    self.vi.scrollView.contentInset = UIEdgeInsetsZero;

}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"title"]) {
        if (object == self.vi) {
            self.title = self.vi.title;
        }
    }
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
