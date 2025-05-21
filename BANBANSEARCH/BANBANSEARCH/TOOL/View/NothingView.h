//
//  NothingView.h
//  Netneto
//
//  Created by SHOKEN ITO on 2024/9/19.
//


#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface NothingView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *ima;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topCustom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imaHeigh;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelTop;
@property (weak, nonatomic) IBOutlet UIView *bgView;

+ (instancetype)initViewNIB;
@end

NS_ASSUME_NONNULL_END
