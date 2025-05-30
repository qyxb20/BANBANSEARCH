//
//  CustomLineView.h
//  BANBANSEARCH
//
//  Created by apple on 2025/4/7.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface CustomLineView : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *picBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *picW;

@property (weak, nonatomic) IBOutlet UIButton *search;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *searchWidth;
@property (weak, nonatomic) IBOutlet UILabel *isBi;

+ (instancetype)initViewNIB;
@end

NS_ASSUME_NONNULL_END
