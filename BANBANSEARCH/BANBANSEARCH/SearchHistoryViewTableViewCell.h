//
//  SearchHistoryViewTableViewCell.h
//  BANBANSEARCH
//
//  Created by apple on 2025/4/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchHistoryViewTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *pic;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelTop;
@property (weak, nonatomic) IBOutlet UILabel *addLabel;

@end

NS_ASSUME_NONNULL_END
