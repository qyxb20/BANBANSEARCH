//
//  shopInforView.m
//  BANBANSEARCH
//
//  Created by apple on 2025/5/9.
//

#import "shopInforView.h"
#import "XHWebImageAutoSize.h"
@interface shopInforView ()<UIContextMenuInteractionDelegate>
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
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
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *picTop;
@property (weak, nonatomic) IBOutlet UIButton *close;
@property (weak, nonatomic) IBOutlet UILabel *yingL;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *picHeight;

@end
static shopInforView *_manager = nil;
@implementation shopInforView

+ (shopInforView *)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[shopInforView alloc] init];
    });
    return _manager;
}

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
//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
//    //如果希望严谨一点，可以将上面if语句及里面代码替换成如下代码
//    if (![self pointInside:point withEvent:event]) {
//        return nil;
//    }
//    CGPoint redBtnPoint = [self convertPoint:point toView:_close];
//        UIView *view = [_close hitTest: redBtnPoint withEvent: event];
//        if (view) return view;
//        return [super hitTest:point withEvent:event];
//}
- (void)updateData:(NSDictionary *)dicData{
    self.nameLabel.text = dicData[@"venuesName"];
//    self.ying.text = dicData[@"shopTyps"];
    NSString *str = [NSString stringWithFormat:@" %@ ",dicData[@"shopTyps"]];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    
    // 设置背景色
    [attributedString addAttribute:NSBackgroundColorAttributeName
                             value:RGB(0xFFEDDE)
                              range:NSMakeRange(0, [NSString stringWithFormat:@"%@",dicData[@"shopTyps"]].length+ 2) ];
    [attributedString addAttribute:NSForegroundColorAttributeName
                             value:RGB(0x975029)
                              range:NSMakeRange(0, [NSString stringWithFormat:@"%@",dicData[@"shopTyps"]].length + 2)];
    
    [attributedString addAttribute:NSFontAttributeName
                             value:[UIFont boldSystemFontOfSize:15]
                              range:NSMakeRange(0, [NSString stringWithFormat:@"%@",dicData[@"shopTyps"]].length+ 2) ];
   
     
    self.yingL.attributedText = attributedString;
    self.shopName.text = dicData[@"shopName"];
    self.shopName.userInteractionEnabled = YES;
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    [self.shopName addGestureRecognizer:longPress];
    
    self.phoneL.text = dicData[@"shopMobile"];
    [self.phoneL addTapAction:^(UIView * _Nonnull view) {
        ExecBlock(self.callBlock,[NSString stringWithFormat:@"tel:%@",self.phoneL.text]);
       
    }];
    self.emailL.text = dicData[@"shopUrl"];
    self.emailL.userInteractionEnabled = YES;
//    UILongPressGestureRecognizer *longPressEmail = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressEmail:)];
//    [self.emailL addGestureRecognizer:longPressEmail];
    @weakify(self);
    [self.emailL addTapAction:^(UIView * _Nonnull view) {
        @strongify(self);
        if (![self.emailL.text containsString:@"https://"]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://%@",self.emailL.text]] options:@{} completionHandler:nil];
        }else{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.emailL.text] options:@{} completionHandler:nil];
        }
       
//        UIContextMenuInteraction *interaction = [[UIContextMenuInteraction alloc] initWithDelegate:self];
//        [self.emailL addInteraction:interaction];
    }];
    self.yinTimeLabel.text = [NSString stringWithFormat:@"%@～%@",[NSString isNullStr:dicData[@"businessStartTime"]],[NSString isNullStr:dicData[@"businessEndTime"]]];
    self.xiuL.text = [NSString isNullStr:dicData[@"restDay"]];
    self.xishu.text =[NSString isNullStr:dicData[@"seatCount"]];
    [self.leaderPic sd_setImageWithURL:[NSURL URLWithString:[NSString isNullStr:dicData[@"storePhoto"]]] placeholderImage:[UIImage imageNamed:@"Photo"]];
    self.leaderL.text = [NSString isNullStr:dicData[@"storeManager"]];
    self.leaderPhone.text = [NSString isNullStr:dicData[@"storeMobile"]];
    [self.leaderPhone addTapAction:^(UIView * _Nonnull view) {
        ExecBlock(self.callBlock,[NSString stringWithFormat:@"tel:%@",self.leaderPhone.text]);
       
    }];
  
   
    
//        [self.pic sd_setImageWithURL:[NSURL URLWithString:[NSString isNullStr:dicData[@"shopImage"]]] placeholderImage:[UIImage imageNamed:@"矩形 12"]];
    if ([[NSString isNullStr:dicData[@"shopImage"]] length] == 0) {
        self.picHeight.constant = 0;
//        self.height = 690-160 - 24;
        self.picTop.constant = 0;
    }
    else{
        self.picTop.constant = 24;
        
        [self.pic sd_setImageWithURL:[NSURL URLWithString:[NSString isNullStr:dicData[@"shopImage"]]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            /** 缓存image size */
            [XHWebImageAutoSize storeImageSize:image forURL:imageURL completed:^(BOOL result) {
                /** reload  */
                CGFloat h =   [XHWebImageAutoSize imageHeightForURL:[NSURL URLWithString:dicData[@"shopImage"]] layoutWidth:WIDTH-36 estimateHeight:160];
                if (h > WIDTH-36){
                    h = WIDTH-36;
                }
        //        [XHWebImageAutoSize imageHeightForURL:[NSURL URLWithString:dicData[@"shopImage"]] layoutWidth:WIDTH-36 estimateHeight:160];
              
                self.picHeight.constant = h;
                if(result)  [self  xh_reloadDataForURL:imageURL];
                
                
            }];
        }];
        
//        self.height = 690-160 - 24 + h;
    }
    

    self.noteL.text =[NSString isNullStr:dicData[@"notes"]];
}
- (CGFloat)getLongHeight{
    return self.noteL.bottom + 40;
}
- (CGFloat)getShortHeight{
    return self.leaderPic.bottom + 20;
}
-(void)xh_reloadDataForURL:(NSURL *)url{
    BOOL reloadState = [XHWebImageAutoSize reloadStateFromCacheForURL:url];
    if(!reloadState){
       
        [XHWebImageAutoSize storeReloadState:YES forURL:url completed:nil];
    }
}
- (void)handleLongPress:(UILongPressGestureRecognizer *)gesture {
    UIContextMenuInteraction *interaction = [[UIContextMenuInteraction alloc] initWithDelegate:self];
    [self.shopName addInteraction:interaction];
}
- (void)handleLongPressEmail:(UILongPressGestureRecognizer *)gesture {
    UIContextMenuInteraction *interaction = [[UIContextMenuInteraction alloc] initWithDelegate:self];
    [self.emailL addInteraction:interaction];
}

- (UIContextMenuConfiguration *)contextMenuInteraction:(UIContextMenuInteraction *)interaction configurationForMenuAtLocation:(CGPoint)location API_AVAILABLE(ios(13.0)) {
    // 通过interaction拿到对应的view
    UIView *view = interaction.view;
    
    // 创建菜单选项
    UIImage *action1Image = nil;
    if (@available(iOS 13.0, *)) {
        action1Image = [UIImage systemImageNamed:@"doc.on.doc"];
    }
    
    if (view == self.shopName) {
        UIAction *action1 = [UIAction actionWithTitle:@"コピー" image:action1Image identifier:@"App.MenuActionID.Copy.Mac" handler:^(__kindof UIAction * _Nonnull action) {
            // 通过系统的粘贴板,记录下需要传递的数据
            [UIPasteboard generalPasteboard].string = self.shopName.text;
        }];
        UIMenu *menu = [UIMenu menuWithTitle:@"" children:@[action1]];
        
        UIContextMenuConfiguration *config = [UIContextMenuConfiguration configurationWithIdentifier:nil previewProvider:^UIViewController * _Nullable {
            
            return nil;
        } actionProvider:^UIMenu * _Nullable(NSArray<UIMenuElement *> * _Nonnull suggestedActions) {
            
            return menu; // 返回菜单
        }];
        return config;
    }
   else  if (view == self.emailL) {
       UIAction *action2 = [UIAction actionWithTitle:@"コピー" image:action1Image identifier:@"App.MenuActionID.Copy.Mac" handler:^(__kindof UIAction * _Nonnull action) {
            // 通过系统的粘贴板,记录下需要传递的数据
            [UIPasteboard generalPasteboard].string = self.emailL.text;
        }];
         UIMenu *menu = [UIMenu menuWithTitle:@"" children:@[action2]];
         
         UIContextMenuConfiguration *config = [UIContextMenuConfiguration configurationWithIdentifier:nil previewProvider:^UIViewController * _Nullable {
             
             return nil;
         } actionProvider:^UIMenu * _Nullable(NSArray<UIMenuElement *> * _Nonnull suggestedActions) {
             
             return menu; // 返回菜单
         }];
         return config;
    }
    
    else{
        return nil;
    }
   
    
}

/// 交互开始时调用, 用来返回预览视图弹出时其所在位置的视图, 例如:如果返回视图A,则预览视图会在视图A位置弹出
/// 不实现该方法或返回nil时, 预览视图会默认在交互所在视图(即添加交互对象的视图)位置弹出
- (UITargetedPreview *)contextMenuInteraction:(UIContextMenuInteraction *)interaction previewForHighlightingMenuWithConfiguration:(UIContextMenuConfiguration *)configuration API_AVAILABLE(ios(13.0)) {
    return nil;
}

/// 交互消失时调用, 用来返回预览视图消失时其所在位置的视图, 例如:如果返回视图B,则预览视图会在视图B位置消失
/// 不实现该方法或返回nil时, 预览视图会默认在交互所在视图(即添加交互对象的视图)位置消失
- (UITargetedPreview *)contextMenuInteraction:(UIContextMenuInteraction *)interaction previewForDismissingMenuWithConfiguration:(UIContextMenuConfiguration *)configuration API_AVAILABLE(ios(13.0)) {
    return nil;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
