//
//  AddCollectionViewCell.m
//  Netneto
//
//  Created by 才诗琦 on 2024/9/30.
//

#import "AddCollectionViewCell.h"
#define RGB(c) [UIColor colorWithRed:((float)((c & 0xFF0000) >> 16))/255.0f green:((float)((c & 0xFF00) >> 8))/255.0f blue:((float)(c & 0xFF))/255.0f alpha:1.0]
@implementation AddCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.addImageV];
        
        
    }
    return self;
}

- (UIButton *)addImageV{
    if (!_addImageV) {
        self.addImageV =[UIButton buttonWithType:UIButtonTypeCustom];
        self.addImageV.frame = self.bounds;
        
            _addImageV.backgroundColor = RGB(0xF6FAFE);
            _addImageV.layer.borderColor = RGB(0xA3CCF9).CGColor;
            _addImageV.layer.borderWidth = 0.5;
            _addImageV.titleLabel.font = [UIFont systemFontOfSize:12];
            [_addImageV setTitleColor:RGB(0x197CF5) forState:UIControlStateNormal];
            _addImageV.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _addImageV.userInteractionEnabled =NO;
         
    }
    return _addImageV;
}
@end
