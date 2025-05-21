//
//  CustomLineView.m
//  BANBANSEARCH
//
//  Created by apple on 2025/4/7.
//

#import "CustomLineView.h"

@implementation CustomLineView
+ (instancetype)initViewNIB {
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];
    return views[0];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
