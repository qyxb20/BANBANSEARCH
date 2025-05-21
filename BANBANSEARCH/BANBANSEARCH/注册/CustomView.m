//
//  CustomView.m
//  BANBANSEARCH
//
//  Created by apple on 2025/4/7.
//

#import "CustomView.h"

@implementation CustomView
+ (instancetype)initViewNIB {
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];

    return views[0];
}
- (void)awakeFromNib {
    [super awakeFromNib];
//    self.customTF.enabled = NO;
}
- (void)updateData{
    if (account.isLogin) {
        self.isBi.textColor = RGB(0x8A8B90);
        self.titleLabel.textColor = RGB(0x8A8B90);
        self.customTF.textColor = RGB(0x8A8B90);
        self.userInteractionEnabled = NO;
        
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
