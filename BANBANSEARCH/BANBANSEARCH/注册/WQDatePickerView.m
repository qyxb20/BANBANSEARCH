//
//  WQDatePickerView.m
//  BANBANSEARCH
//
//  Created by apple on 2025/5/8.
//
#import "WQDatePickerView.h"

static const int HEIGHTS = 200;
@interface WQDatePickerView()
{
    UIDatePicker *_datePicker;
    BOOL _canSelectFutrueDate;
}
 
@end

@implementation WQDatePickerView
-(instancetype)initDatePicker:(CGRect)rect defaultDate:(NSDate *)defaultDate selectFutureDate:(BOOL)select{
    if (self = [super initWithFrame:rect]) {
        _date = defaultDate;
        _canSelectFutrueDate = select;
        [self initView];
    }
    return self;
}
 
-(void)initView{
    NSMutableArray *buttons = [[NSMutableArray alloc]initWithCapacity:2];
    UIToolbar *toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0,WIDTH, 40)];
    [toolbar setBackgroundColor:RGB(0xfbfbfb)];
     
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(toolbarAction:)];
    cancelItem.tag = 1;
     
    UIBarButtonItem *flexibleSpaceItem =[[UIBarButtonItem alloc]
                         initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                         target:self
                         action:NULL];
 
     
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(toolbarAction:)];
    doneItem.tag = 2;
     
    [buttons addObject:cancelItem];
    [buttons addObject:flexibleSpaceItem];
    [buttons addObject:doneItem];
    [toolbar setItems:buttons animated:YES];
    [self addSubview:toolbar];
     
     
    _datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 40, WIDTH, HEIGHTS-40)];
    if (!_date) {
        _date = [NSDate date];
    }
    [_datePicker setDate:_date];
    [_datePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"ja"]];
    [_datePicker setDatePickerMode:UIDatePickerModeDate];
     
    if (!_canSelectFutrueDate) {
        [_datePicker setMaximumDate:[NSDate date]];
    }
     
    [self addSubview:_datePicker];
  
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0.0f, -3.0f);
    self.layer.shadowOpacity = 0.2f;
}
 
-(void)toolbarAction:(UIBarButtonItem *)item{
    NSInteger tag = item.tag;
    NSLog(@"action");
    if ([_delegate respondsToSelector:@selector(dateSelected:actionIndex:)]) {
        _date = [_datePicker date];
        [_delegate dateSelected:[_datePicker date] actionIndex:tag];
    }
}
 
- (void)show{
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    [UIView beginAnimations:nil context:context];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//    [UIView setAnimationDuration:0.4];//动画时间长度，单位秒，浮点数
//    [self exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
//    self.frame = CGRectMake(0, HEIGHT-HEIGHTS, WIDTH, HEIGHTS);
//    [UIView setAnimationDelegate:self];
//    [UIView commitAnimations];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}
 
- (void)dismiss {
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.4];//动画时间长度，单位秒，浮点数
    self.frame = CGRectMake(0, HEIGHT, WIDTH, HEIGHTS);
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationFinished)];
    [UIView commitAnimations];
}
 
-(void)animationFinished{
    if ([_delegate respondsToSelector:@selector(animationFinished)]) {
        [_delegate animationFinished];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
