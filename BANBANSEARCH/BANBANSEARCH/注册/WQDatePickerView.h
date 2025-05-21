//
//  WQDatePickerView.h
//  BANBANSEARCH
//
//  Created by apple on 2025/5/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol WQDatePickerDelegate <NSObject>
 
-(void)dateSelected:(NSDate *)date actionIndex:(NSInteger )index;
 
-(void)animationFinished;
 
@end
@interface WQDatePickerView : UIView
@property(nonatomic,assign)NSDate *date;
@property(nonatomic,weak) id<WQDatePickerDelegate> delegate;
 
-(instancetype)initDatePicker:(CGRect) rect defaultDate:(NSDate *) defaultDate selectFutureDate:(BOOL)select;
 
-(void)animationFinished;
 
-(void)show;
 
-(void)dismiss;
@end

NS_ASSUME_NONNULL_END
