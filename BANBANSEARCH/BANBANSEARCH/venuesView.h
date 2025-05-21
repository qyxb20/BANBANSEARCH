//
//  venuesView.h
//  BANBANSEARCH
//
//  Created by apple on 2025/4/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface venuesView : UIView<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
+ (instancetype)initViewNIB;

-(void)updataWithArray:(NSArray *)list ;
@end

NS_ASSUME_NONNULL_END
