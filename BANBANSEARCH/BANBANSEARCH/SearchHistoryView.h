//
//  SearchHistoryView.h
//  BANBANSEARCH
//
//  Created by apple on 2025/4/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchHistoryView : UIView<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
@property (weak, nonatomic) IBOutlet UITextField *searchTF;
@property (weak, nonatomic) IBOutlet UIButton *iconBtn;
@property (weak, nonatomic) IBOutlet UIButton *hitoryBtn;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableTop;
@property (nonatomic, strong) NSArray *dataArray;
+ (instancetype)initViewNIB;
@property (nonatomic, copy) void (^updateFrameBlock) (NSArray *array);
@property (nonatomic, copy) void (^updateEditFrameBlock) (NSArray *array);
@property (nonatomic, copy) void (^updateReturnFrameBlock) (NSArray *array);
@property (nonatomic, copy) void (^selePointBlock) (NSDictionary *dic,NSInteger isShop);
-(void)updateloadData:(NSInteger)isOpen;
@end

NS_ASSUME_NONNULL_END
