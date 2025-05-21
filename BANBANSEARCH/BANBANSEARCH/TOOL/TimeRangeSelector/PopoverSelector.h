//
//  PopoverSelector.h
//  ByqIOSApps
//
//  Created by MrChen on 2022/7/14.
//  Copyright © 2022 MrChen_CWJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimeRangePicker.h"

typedef enum{
    YYYY,
    YYYYMM,
    YYYYMMDD,
    MMDD,
    HHMMSS,
    HHMM,
    MMDDHH,
    MMDDHHMM,
    MMDDHHMMSS,
    YYYYMMDDHH,
    YYYYMMDDHHMM,
    YYYYMMDDHHMMSS
} TimeRangeType;

@class PopoverSelector;
@protocol SelectorDelegate <NSObject> //选择事件接口

- (void)itemSelected:(PopoverSelector*)selector SelectedItem:(NSString*)item;

@end

@interface PopoverSelector : UIView<UIPickerViewDelegate>{
    id<SelectorDelegate> _selectDelegate;  //选择事件代理
    
    TimeRangePicker  *_rangePicker; //时间范围选择器
    
    UILabel               *_titleView;
    UIControl             *_overlayView;
    
    NSMutableArray        *_data;           //数据
    NSString              *_dataSeparator;  //数据分隔符
    NSMutableArray        *_pickerData;     //从数据中取出放入picker的数据
}

@property (nonatomic, assign) id      selectDelegate;

@property (nonatomic, retain) TimeRangePicker      *rangePicker;


@property (nonatomic, retain) NSMutableArray       *data;
@property (nonatomic, retain) NSString             *dataSeparator;;
@property (nonatomic, retain) NSMutableArray       *pickerData;

- (void)setTitle:(NSString *)title;
- (NSString*)getTitle;

- (void)show;
- (void)dismiss;

- (id)initSelectorWithFrameTypeData:(CGRect)frame SelectorData:(NSMutableArray*)selectorData;

- (id)initSelectorWithFrameRangeType:(CGRect)frame RangeType:(TimeRangeType)rangeType;

@end
