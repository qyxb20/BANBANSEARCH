//
//  SettingViewController.m
//  BANBANSEARCH
//
//  Created by apple on 2025/4/7.
//

#import "SettingViewController.h"
#import "LoginViewController.h"
#import "SettingTableViewCell.h"
#import "CancelViewController.h"
@interface SettingViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic, strong)NSArray *dataArray;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:239 / 255.0 green:239 / 255.0 blue:239 / 255.0 alpha:1];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //    self.dataArray = @[@"新規登録",@"削除",@"戻る"];
    self.dataArray = @[
        @{@"img":@"user",@"title":@"新規登録"},
        @{@"img":@"editNo",@"title":@"編集"},
        @{@"img":@"delNo",@"title":@"削除"},
        @{@"img":@"return",@"title":@"戻る"}];
    [self.tableView reloadData];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(resetUserInfo) name:@"uploadUserInfo" object:nil];
    // Do any additional setup after loading the view from its nib.
}
-(void)resetUserInfo{
    if (account.isLogin) {
        self.dataArray = @[
            @{@"img":@"userNo",@"title":@"新規登録"},
            @{@"img":@"edit",@"title":@"編集"},
            @{@"img":@"del",@"title":@"削除"},
            @{@"img":@"return",@"title":@"戻る"}];
    }
    else{
        self.dataArray = @[
            @{@"img":@"user",@"title":@"新規登録"},
            @{@"img":@"editNo",@"title":@"編集"},
            @{@"img":@"delNo",@"title":@"削除"},
            @{@"img":@"return",@"title":@"戻る"}];
    }
    [self.tableView reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *vi = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 16)];
    vi.backgroundColor = [UIColor clearColor];
    return vi;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 16;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    SettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingTableViewCell"];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"SettingTableViewCell" owner:self options:nil].lastObject;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    cell.layer.cornerRadius = 4;
    cell.clipsToBounds = YES;
    NSDictionary *dic =self.dataArray[indexPath.section];
    cell.pic.image = [UIImage imageNamed:dic[@"img"]];
    cell.titleLabel.text = dic[@"title"];
    if (account.isLogin) {
        if ([dic[@"title"] isEqual:@"新規登録"]) {
            cell.titleLabel.textColor = [UIColor colorWithRed:166 / 255.0 green:166 / 255.0 blue:166 / 255.0 alpha:1];
        }
    }
    else{
        if ([dic[@"title"] isEqual:@"編集"]) {
            cell.titleLabel.textColor = [UIColor colorWithRed:166 / 255.0 green:166 / 255.0 blue:166 / 255.0 alpha:1];
        }
        if ([dic[@"title"] isEqual:@"削除"]) {
            cell.titleLabel.textColor = [UIColor colorWithRed:166 / 255.0 green:166 / 255.0 blue:166 / 255.0 alpha:1];
        }
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == self.dataArray.count - 1) {
        [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:^(BOOL finished) {
          
            
        }];
    }
    else if ([self.dataArray[indexPath.section][@"title"] isEqual:@"新規登録"]) {
        if (!account.isLogin) {
            LoginViewController *vc = [[LoginViewController alloc] init];
            UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vc];
            navi.modalPresentationStyle = 0;
            [self presentViewController:navi animated:NO completion:^{
                [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:NO completion:^(BOOL finished) {
                    
                    
                }];
            }];
        }
//        [self.navigationController pushViewController:vc animated:NO];
    }
    else  if ([self.dataArray[indexPath.section][@"title"] isEqual:@"削除"]) {
        if (account.isLogin) {
            CancelViewController *vc = [[CancelViewController alloc] init];
            UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vc];
            navi.modalPresentationStyle = 0;
            [self presentViewController:navi animated:NO completion:^{
                [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:NO completion:^(BOOL finished) {
                    
                    
                }];
            }];
        }
//        [self.navigationController pushViewController:vc animated:NO];
    }
    
   else if ([self.dataArray[indexPath.section][@"title"] isEqual:@"編集"]) {
       if (account.isLogin) {
           ResignViewController*vc = [[ResignViewController alloc] init];
           UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vc];
           navi.modalPresentationStyle = 0;
           [self presentViewController:navi animated:NO completion:^{
               [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:NO completion:^(BOOL finished) {
                   
                   
               }];
           }];
       }
//        [self.navigationController pushViewController:vc animated:NO];
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
