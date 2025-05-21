//
//  CustomView.h
//  BANBANSEARCH
//
//  Created by apple on 2025/4/7.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomView : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *customTF;
@property (weak, nonatomic) IBOutlet UIButton *search;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *searchWidth;
@property (weak, nonatomic) IBOutlet UILabel *isBi;
- (void)updateData;
+ (instancetype)initViewNIB;
@end

NS_ASSUME_NONNULL_END
