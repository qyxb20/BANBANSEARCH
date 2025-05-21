//
//  ZLDatePickerView.m
//  ZLAppointment
//
//  Created by ZL on 2017/6/19.
//  Copyright © 2017年 zhangli. All rights reserved.
//

#import "ZLDatePickerView.h"

@interface ZLDatePickerView () 

// 取消按钮
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
// 确认按钮
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
// 时间选择器视图
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (nonatomic, weak) UIView *bgView;
@property (nonatomic, weak) UIView *fromView;

@end

@implementation ZLDatePickerView


- (void)awakeFromNib {
    
    self.datePicker.datePickerMode = UIDatePickerModeTime; // 设置日期选择器的模式为时间选择模式
}
- (IBAction)datePickerValueChanged:(UIDatePicker *)sender {
    NSDate *selectedDate = sender.date; // 获取当前选择的时间
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"]; // 设置日期格式为24小时制的小时和分钟
    NSString *timeString = [formatter stringFromDate:selectedDate]; // 将选中的时间转换为字符串形式
    // 处理选中的时间，例如更新UI或发送到服务器等操作
}
+ (instancetype)datePickerView {
    
    ZLDatePickerView *picker = [[NSBundle mainBundle] loadNibNamed:@"ZLDatePickerView" owner:nil options:nil].lastObject;
    picker.frame = CGRectMake(0, HEIGHT - 250, WIDTH, 250);
    
    
    return picker;
}

- (void)showFrom:(UIView *)view {
    UIView *bgView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    bgView.backgroundColor = [UIColor lightGrayColor];
    bgView.alpha = 0.5;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [bgView addGestureRecognizer:tap];
    
    self.fromView = view;
    self.bgView = bgView;
    [[UIApplication sharedApplication].keyWindow addSubview:self.bgView];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (void)tap:(UITapGestureRecognizer *)tap {
    [self dismiss];
}

- (IBAction)cancel:(id)sender {
    [self dismiss];
}

- (IBAction)makeSure:(id)sender {
    
    [self dismiss];
    
//    NSDate *date = self.datePicker.date;
//    
//    if ([self.deleagte respondsToSelector:@selector(datePickerView:backTimeString:To:)]) {
//        [self.deleagte datePickerView:self backTimeString:[self fomatterDate:date] To:self.fromView];
//    }
}



//- (void)setDate:(NSDate *)date {
//    self.datePicker.date = date;
//    
//}

- (void)dismiss {
    [self.bgView removeFromSuperview];
    [self removeFromSuperview];
}

//- (NSString *)fomatterDate:(NSDate *)date {
//    NSDateFormatter *fomatter = [[NSDateFormatter alloc] init];
//    fomatter.dateFormat = @"HH:mm";
//    return [fomatter stringFromDate:date];
//}


@end
