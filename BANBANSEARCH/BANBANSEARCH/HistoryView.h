//
//  HistoryView.h
//  BANBANSEARCH
//
//  Created by apple on 2025/4/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HistoryView : UIView<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
+ (instancetype)initViewNIB;
-(void)loadData;
@end

NS_ASSUME_NONNULL_END
