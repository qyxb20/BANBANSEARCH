//
//  venuesView.m
//  BANBANSEARCH
//
//  Created by apple on 2025/4/27.
//

#import "venuesView.h"

@implementation venuesView
NSArray * dataArr;

+ (instancetype)initViewNIB {
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];

    return views[0];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tag = 836913;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.customTF.enabled = NO;
}
-(void)updataWithArray:(NSArray *)list {
  
    dataArr = list;
    [self.tableView reloadData];
    [self.tableView flashScrollIndicators];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *showStr = dataArr[indexPath.row];
//    cell.textLabel.text = showStr[@"venuesName"];
//    cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
    CGFloat h = [Tool getLabelHeightWithText:showStr[@"venuesName"] width:self.width - 10 font:17];
    if (h<24) {
        h = 24;
    }
    return h;
    
}
//表格行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArr.count;
}


//初始化cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =[tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    NSDictionary *showStr = dataArr[indexPath.row];
    cell.textLabel.text = showStr[@"venuesName"];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
    cell.textLabel.textColor = RGB(0x975029);

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
   
   
   
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
