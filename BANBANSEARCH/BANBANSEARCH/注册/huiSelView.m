//
//  huiSelView.m
//  BANBANSEARCH
//
//  Created by apple on 2025/4/21.
//

#import "huiSelView.h"

@implementation huiSelView
NSArray * listStr;
NSString *textStr;
+ (instancetype)initViewNIB {
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];

    return views[0];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tag = 836913;
//    self.customTF.enabled = NO;
}
-(void)updataWithArray:(NSArray *)list withStr:(nonnull NSString *)text{
    textStr = text;
    listStr = list;
    [self.tableView reloadData];
    [self.tableView flashScrollIndicators];
    
}
-(void)hidView{
    listStr = @[];
    textStr = @"";
    [self.tableView reloadData];
  
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 24.0;
    
}
//表格行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return listStr.count;
}


//初始化cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =[tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    NSDictionary *showStr = listStr[indexPath.row];
    cell.textLabel.text = showStr[@"venuesName"];
    cell.textLabel.font = [UIFont systemFontOfSize:10];
    if ([cell.textLabel.text isEqual:textStr]) {
        cell.textLabel.textColor = RGB(0xC30D23);
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
   
   
    ExecBlock(self.SelBlock,listStr[indexPath.row]);
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
