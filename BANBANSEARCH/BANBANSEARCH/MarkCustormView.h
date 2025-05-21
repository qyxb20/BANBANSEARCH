//
//  MarkCustormView.h
//  BANBANSEARCH
//
//  Created by apple on 2025/5/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MarkCustormView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *pic;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *picW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *picH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelH;
@property (weak, nonatomic) IBOutlet UILabel *huiName;
@property (weak, nonatomic) IBOutlet UILabel *shopName;

+ (instancetype)initViewNIB;
@end

NS_ASSUME_NONNULL_END
