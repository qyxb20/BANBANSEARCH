//
//  MarkCustormView.m
//  BANBANSEARCH
//
//  Created by apple on 2025/5/6.
//

#import "MarkCustormView.h"

@implementation MarkCustormView
+ (instancetype)initViewNIB {
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];

    return views[0];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
