//
//  SearchHistoryView.m
//  BANBANSEARCH
//
//  Created by apple on 2025/4/17.
//

#import "SearchHistoryView.h"

@implementation SearchHistoryView
NSInteger isopen;
+ (instancetype)initViewNIB {
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];

    return views[0];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
    isopen = 0;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    NSDictionary *dic = [SaveManager getSearchHistoryData];
    if ([dic allKeys].count!= 0) {
        self.dataArray = dic[@"list"];
        [self.tableView reloadData];
    }
    @weakify(self);
    [self.searchBtn addTapAction:^(UIView * _Nonnull view) {
        @strongify(self);
        
        if (self.searchTF.text.length == 0) {
            ToastShow(@"検索キーワードを入力してから「検索」ボタンを押してください。",@"矢量 20",RGB(0xFD9329));
           
        }
        if (self.dataArray.count == 0) {
            ToastShow(@"会場または店舗の位置情報が取得できません。キーワードを変更して再度検索してください。",@"矢量 20",RGB(0xFD9329));
           
        }
        else{
            [self getData:self.dataArray[0]];
        }
        
    }];
    self.searchTF.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserverForName:@"updataHistory" object:nil queue:nil usingBlock:^(NSNotification *notification) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSDictionary *dic = [SaveManager getSearchHistoryData];
            if ([dic allKeys].count!= 0) {
                self.dataArray = dic[@"list"];
                [self.tableView reloadData];
            }
        });
    }];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(changeShowContentViewPosition:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    

}
///键盘出现
- (void)changeShowContentViewPosition:(NSNotification *)notification{
    if (self.searchTF.isEditing) {
        isopen = 1;
        [self.tableView reloadData];
        [self.btn setTitle:@"削除" forState:UIControlStateNormal];
        [self.hitoryBtn setTitle:@"最近" forState:UIControlStateNormal];
        ExecBlock(self.updateEditFrameBlock,self.dataArray);
    }
    
    
}
//键盘搜索按钮
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (self.searchTF.text.length == 0) {
        ToastShow(@"検索キーワードを入力してから「検索」ボタンを押してください。",@"矢量 20",RGB(0xFD9329));
        return NO;
    }
    if (self.dataArray.count == 0) {
        ToastShow(@"会場または店舗の位置情報が取得できません。キーワードを変更して再度検索してください。",@"矢量 20",RGB(0xFD9329));
        return NO;
    }
    else{
        [self getData:self.dataArray[0]];
    }
    
    ExecBlock(self.updateReturnFrameBlock,self.dataArray);
    self.searchTF.text = @"";
    [self.searchTF resignFirstResponder];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSUInteger newLength = textField.text.length + string.length - range.length;
  
//    模糊查询
   
        
        NSString *searchCount = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSLog(@"搜索文字：%@",searchCount);
    if (searchCount.length == 0) {
        self.tableTop.constant = 8;
        self.hitoryBtn.hidden = NO;
        self.btn.hidden = NO;
        NSDictionary *dic = [SaveManager getSearchHistoryData];
        if ([dic allKeys].count!= 0) {
            self.dataArray = dic[@"list"];
          
            [self.tableView reloadData];
        }
    }
    else{
        self.tableTop.constant = -18;
        self.hitoryBtn.hidden = YES;
        self.btn.hidden = YES;
        [NetwortTool getAreaByQueryParamWithParm:@{@"queryParam":searchCount} Success:^(id  _Nonnull responseObject) {
            self.dataArray = responseObject;
            //        ExecBlock(self.updateFrameBlock,self.dataArray);
            isopen = 1;
            [self.tableView reloadData];
        } failure:^(NSError * _Nonnull error) {
            
        }];
    }
    return YES;
    }
- (void)updateloadData:(NSInteger)isOpen{
    isopen = isOpen;
    [self.tableView reloadData];
}
-(void)addData:(NSDictionary *)dataDic{
    ///数据存本地
    NSDictionary *dic = [SaveManager getSearchHistoryData];
    
    if ([dic allKeys].count == 0) {
        NSMutableArray *arr = [NSMutableArray array];
        [arr addObject:dataDic];
        dic = @{@"list":arr};
        [SaveManager saveSearchHistoryData:dic];
        self.dataArray = arr;
//        ExecBlock(self.updateFrameBlock,self.dataArray);
        [self.tableView reloadData];
    }
    else{
        NSMutableArray *arr = [NSMutableArray arrayWithArray:dic[@"list"]];
        if (arr.count == 20) {
            [arr removeObject:arr.lastObject];
        }
        if ([arr containsObject:dataDic]) {
            [arr removeObject:dataDic];
        }
        [arr insertObject:dataDic atIndex:0];
        dic = @{@"list":arr};
        [SaveManager saveSearchHistoryData:dic];
        self.dataArray = arr;
//        ExecBlock(self.updateFrameBlock,self.dataArray);
        [self.tableView reloadData];
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"updataHistory" object:nil userInfo:nil];
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (isopen == 0) {
        if (self.dataArray.count > 3) {
            return 3;
        }else{
            return self.dataArray.count;
        }
    }
    else{
        return self.dataArray.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchHistoryViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchHistoryViewTableViewCell"];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"SearchHistoryViewTableViewCell" owner:self options:nil].lastObject;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *dic = self.dataArray[indexPath.row];
    NSString *areaType = [NSString stringWithFormat:@"%@",dic[@"areaType"]];
    if ([areaType isEqualToString:@"1"]) {
        cell.pic.image = [UIImage imageNamed:@"路径 2 (2)"];
    }
    else{
        cell.pic.image = [UIImage imageNamed:@"路径 2 (3)"];
    }
    if(self.tableTop.constant == -18){
        cell.labelTop.constant = 15;
        cell.addLabel.hidden = NO;
        cell.addLabel.text = [NSString isNullStr:dic[@"areaAddress"]];
    }
    else{
        cell.labelTop.constant = 23.5;
        cell.addLabel.hidden = YES;
    }
    cell.title.text =  [NSString isNullStr:dic[@"areaName"]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 62;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.tableTop.constant = 8;
    self.hitoryBtn.hidden = NO;
    self.btn.hidden = NO;
//    self.searchTF.text =self.dataArray[indexPath.row][@"venuesName"];
    [self.searchTF resignFirstResponder];
    [self getData:self.dataArray[indexPath.row]];
    ExecBlock(self.updateReturnFrameBlock,self.dataArray);
}
//获取信息
- (void)getData:(NSDictionary *)dic{
    NSString *areaType = [NSString stringWithFormat:@"%@",dic[@"areaType"]];
    if ([areaType isEqualToString:@"1"]) {
        
   
    [NetwortTool getVenvesInfoWithParm:@{@"venuesId":dic[@"areaId"]} Success:^(id  _Nonnull responseObject) {
        if (![responseObject isKindOfClass:[NSArray class]]) {
            ToastShow(@"指定された会場はすでに削除されています。",@"矢量 20",RGB(0xFF830F));
            return;
        }
        NSArray *arr = responseObject;
        self.searchTF.text =@"";
        [self addData:dic];
        ExecBlock(self.selePointBlock,arr.firstObject,1);
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
    }
    else{
        [NetwortTool getShopInfoWithParm:@{@"shopId":dic[@"areaId"]} Success:^(id  _Nonnull responseObject) {
            if (![responseObject isKindOfClass:[NSDictionary class]]) {
                ToastShow(@"選択された店舗はすでに削除されています。",@"矢量 20",RGB(0xFF830F));
                return;
            }
            NSDictionary *arr = responseObject;
            self.searchTF.text =@"";
            [self addData:dic];
            ExecBlock(self.selePointBlock,arr,2);
            
        } failure:^(NSError * _Nonnull error) {
            
        }];
    }
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
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
