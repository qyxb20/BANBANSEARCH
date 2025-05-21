//
//  huiSelView.h
//  BANBANSEARCH
//
//  Created by apple on 2025/4/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface huiSelView : UIView<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
+ (instancetype)initViewNIB;

-(void)updataWithArray:(NSArray *)list withStr:(NSString *)text;
-(void)hidView;
@property(nonatomic, copy) void (^SelBlock) (NSDictionary *selDic);

@end

NS_ASSUME_NONNULL_END
