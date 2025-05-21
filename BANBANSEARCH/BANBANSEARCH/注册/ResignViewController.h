//
//  ResignViewController.h
//  BANBANSEARCH
//
//  Created by apple on 2025/4/7.
//

#import <UIKit/UIKit.h>
#import "ZLDatePickerView.h"
#import "WQDatePickerView.h"
#import "GKImageCropper.h"
#import "GKImagePicker.h"
NS_ASSUME_NONNULL_BEGIN

@interface ResignViewController : UIViewController
@property(nonatomic, strong)NSDictionary *dataDic;
@property (nonatomic, retain) GKImagePicker *picker;
@end

NS_ASSUME_NONNULL_END
