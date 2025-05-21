//
//  ShopDetailView.m
//  BANBANSEARCH
//
//  Created by apple on 2025/4/17.
//

#import "ShopDetailView.h"
@interface ShopDetailView ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ying;
@property (weak, nonatomic) IBOutlet UILabel *shopName;
@property (weak, nonatomic) IBOutlet UILabel *phoneL;
@property (weak, nonatomic) IBOutlet UILabel *emailL;
@property (weak, nonatomic) IBOutlet UILabel *yinTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *xiuL;
@property (weak, nonatomic) IBOutlet UILabel *leaderL;
@property (weak, nonatomic) IBOutlet UIImageView *leaderPic;
@property (weak, nonatomic) IBOutlet UILabel *leaderPhone;
@property (weak, nonatomic) IBOutlet UIImageView *pic;
@property (weak, nonatomic) IBOutlet UILabel *noteL;
@property (weak, nonatomic) IBOutlet UILabel *xishu;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *allHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *picTop;
@property (weak, nonatomic) IBOutlet UIButton *close;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *picHeight;

@end

@implementation ShopDetailView
+ (instancetype)initViewNIB {
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];

    return views[0];
}
- (void)awakeFromNib {
    [super awakeFromNib];
//    self.customTF.enabled = NO;
}
- (IBAction)closeClcik:(UIButton *)sender {
    [self removeFromSuperview];
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    //如果希望严谨一点，可以将上面if语句及里面代码替换成如下代码
    if (![self pointInside:point withEvent:event]) {
        return nil;
    }
    CGPoint redBtnPoint = [self convertPoint:point toView:_close];
        UIView *view = [_close hitTest: redBtnPoint withEvent: event];
        if (view) return view;
        return [super hitTest:point withEvent:event];
}
- (void)updateData:(NSDictionary *)dicData{
    self.nameLabel.text = dicData[@"names"];
//    self.ying.text = dicData[@"shopTyps"];
    NSString *str = [NSString stringWithFormat:@" %@ \n%@",dicData[@"shopTyps"],dicData[@"shopName"]];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    
    // 设置背景色
    [attributedString addAttribute:NSBackgroundColorAttributeName
                             value:RGB(0xFFEDDE)
                              range:NSMakeRange(0, [NSString stringWithFormat:@"%@",dicData[@"shopTyps"]].length+ 2) ];
    [attributedString addAttribute:NSForegroundColorAttributeName
                             value:RGB(0x975029)
                              range:NSMakeRange(0, [NSString stringWithFormat:@"%@",dicData[@"shopTyps"]].length + 2)];
    
    [attributedString addAttribute:NSFontAttributeName
                             value:[UIFont systemFontOfSize:12]
                              range:NSMakeRange(0, [NSString stringWithFormat:@"%@",dicData[@"shopTyps"]].length+ 2) ];
   
     
    self.shopName.attributedText = attributedString;
    
    self.phoneL.text = dicData[@"shopMobile"];
    self.emailL.text = dicData[@"shopUrl"];
    self.yinTimeLabel.text = [NSString stringWithFormat:@"%@～%@",[NSString isNullStr:dicData[@"businessStartTime"]],[NSString isNullStr:dicData[@"businessEndTime"]]];
    self.xiuL.text = [NSString isNullStr:dicData[@"restDay"]];
    self.xishu.text =[NSString isNullStr:dicData[@"seatCount"]];
    [self.leaderPic sd_setImageWithURL:[NSURL URLWithString:[NSString isNullStr:dicData[@"storePhoto"]]] placeholderImage:[UIImage imageNamed:@"Photo"]];
    self.leaderL.text = [NSString isNullStr:dicData[@"storeManager"]];
    self.leaderPhone.text = [NSString isNullStr:dicData[@"storeMobile"]];
    if ([[NSString isNullStr:dicData[@"shopImage"]] length] == 0) {
        self.picHeight.constant = 0;
        self.allHeight.constant = 690-160 - 24;
        self.picTop.constant = 0;
    }
    else{
        self.picTop.constant = 24;
        self.picHeight.constant = 160;
        self.allHeight.constant = 690;
    }
    [self.pic sd_setImageWithURL:[NSURL URLWithString:[NSString isNullStr:dicData[@"shopImage"]]] placeholderImage:[UIImage imageNamed:@"矩形 12"]];
    self.noteL.text =[NSString isNullStr:dicData[@"notes"]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
