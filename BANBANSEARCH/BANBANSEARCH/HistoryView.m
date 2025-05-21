//
//  HistoryView.m
//  BANBANSEARCH
//
//  Created by apple on 2025/4/17.
//

#import "HistoryView.h"

@implementation HistoryView
+ (instancetype)initViewNIB {
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];

    return views[0];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    @weakify(self);
    [self.closeBtn addTapAction:^(UIView * _Nonnull view) {
        @strongify(self);
        [self removeFromSuperview];
    }];
    [self loadData];
//    self.customTF.enabled = NO;
}
-(void)loadData{
    NSDictionary *dic = [SaveManager getSearchHistoryData];
    if ([dic allKeys].count!= 0) {
        self.dataArray = dic[@"list"];
        [self.tableView reloadData];
    }
}
- (IBAction)delAllBtn:(UIButton *)sender {
    CSQAlertView *alert = [[CSQAlertView alloc] initWithTitle:@"" Message:@"全て削除しますか？" btnTitle:@"確定" cancelBtnTitle:@"キャンセル" btnClick:^{
        
        self.dataArray = @[];
        [self.tableView reloadData];
        NSDictionary *dic = @{};
        [SaveManager saveSearchHistoryData:dic];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"updataHistory" object:nil userInfo:nil];

    } cancelBlock:^{
        
    }];
    [alert show];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchHistoryViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchHistoryViewTableViewCell"];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"SearchHistoryViewTableViewCell" owner:self options:nil].lastObject;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.title.text = self.dataArray[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 62;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete; // 指定侧滑出现的按钮类型为删除
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // 执行删除操作
        // 例如：[yourDataArray removeObjectAtIndex:indexPath.row];
        // 然后刷新tableView
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        NSMutableArray *arr = [NSMutableArray arrayWithArray:self.dataArray];
        
        [arr removeObject:self.dataArray[indexPath.row]];
        self.dataArray = arr;
        [self.tableView reloadData];
        NSDictionary *dic = @{@"list":arr};
        [SaveManager saveSearchHistoryData:dic];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"updataHistory" object:nil userInfo:nil];
    }
}
 
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
   
        return YES; // 允许所有行侧滑删除
    
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"削除";
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self removeFromSuperview];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
