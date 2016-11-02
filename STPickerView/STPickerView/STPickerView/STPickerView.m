//
//  STPickerView.m
//  STPickerView
//
//  Created by https://github.com/STShenZhaoliang/STPickerView on 16/2/17.
//  Copyright © 2016年 shentian. All rights reserved.
//

#import "STPickerView.h"


@implementation STPickerView

#pragma mark - --- init 视图初始化 ---
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupDefault];
        [self setupUI];
    }
    return self;
}

- (void)setupDefault
{
    // 1.设置数据的默认值
    _title             = nil;
    _font              = [UIFont systemFontOfSize:15];
    _titleColor        = [UIColor blackColor];
    _borderButtonColor = STRGB(205, 205, 205);
    _heightPicker      = 240;
    _contentMode       = STPickerContentModeBottom;
    
    // 2.设置自身的属性
    self.bounds = [UIScreen mainScreen].bounds;
    self.backgroundColor = STRGBA(0, 0, 0, 102.0/255);
    self.layer.opacity = 0.0;
    [self addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
    
    // 3.添加子视图
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.pickerView];
    [self.contentView addSubview:self.buttonLeft];
    [self.contentView addSubview:self.buttonRight];
    [self.contentView addSubview:self.labelTitle];
    [self.contentView addSubview:self.lineViewDown];
}

- (void)setupUI
{}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.contentMode == STPickerContentModeBottom) {
    }else {
        self.buttonLeft.st_y = self.lineViewDown.st_bottom + STMarginSmall;
        self.buttonRight.st_y = self.lineViewDown.st_bottom + STMarginSmall;
    }
}

#pragma mark - --- delegate 视图委托 ---

#pragma mark - --- event response 事件相应 ---

- (void)selectedOk
{
    [self remove];
}

- (void)selectedCancel
{
    [self remove];
}

#pragma mark - --- private methods 私有方法 ---


- (void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self setCenter:[UIApplication sharedApplication].keyWindow.center];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self];
    
    if (self.contentMode == STPickerContentModeBottom) {
        CGRect frameContent =  self.contentView.frame;
        frameContent.origin.y -= self.contentView.st_height;
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self.layer setOpacity:1.0];
            self.contentView.frame = frameContent;
        } completion:^(BOOL finished) {
        }];
    }else {
        CGRect frameContent =  self.contentView.frame;
        frameContent.origin.y -= (STScreenHeight+self.contentView.st_height)/2;
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self.layer setOpacity:1.0];
            self.contentView.frame = frameContent;
        } completion:^(BOOL finished) {
        }];
    }
}

- (void)remove
{
    if (self.contentMode == STPickerContentModeBottom) {
        CGRect frameContent =  self.contentView.frame;
        frameContent.origin.y += self.contentView.st_height;
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self.layer setOpacity:0.0];
            self.contentView.frame = frameContent;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }else {
        CGRect frameContent =  self.contentView.frame;
        frameContent.origin.y += (STScreenHeight+self.contentView.st_height)/2;
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self.layer setOpacity:0.0];
            self.contentView.frame = frameContent;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
}

#pragma mark - --- setters 属性 ---

- (void)setTitle:(NSString *)title
{
    _title = title;
    [self.labelTitle setText:title];
}

- (void)setFont:(UIFont *)font
{
    _font = font;
    [self.buttonLeft.titleLabel setFont:font];
    [self.buttonRight.titleLabel setFont:font];
    [self.labelTitle setFont:font];
}

- (void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    [self.labelTitle setTextColor:titleColor];
    [self.buttonLeft setTitleColor:titleColor forState:UIControlStateNormal];
    [self.buttonRight setTitleColor:titleColor forState:UIControlStateNormal];
}

- (void)setBorderButtonColor:(UIColor *)borderButtonColor
{
    _borderButtonColor = borderButtonColor;
    [self.buttonLeft addBorderColor:borderButtonColor];
    [self.buttonRight addBorderColor:borderButtonColor];
}

- (void)setHeightPicker:(CGFloat)heightPicker
{
    _heightPicker = heightPicker;
    self.contentView.st_height = heightPicker;
}

- (void)setContentMode:(STPickerContentMode)contentMode
{
    _contentMode = contentMode;
    if (contentMode == STPickerContentModeCenter) {
        self.contentView.st_height += STControlSystemHeight;
    }
}
#pragma mark - --- getters 属性 ---
- (UIView *)contentView
{
    if (!_contentView) {
        CGFloat contentX = 0;
        CGFloat contentY = STScreenHeight;
        CGFloat contentW = STScreenWidth;
        CGFloat contentH = self.heightPicker;
        _contentView = [[UIView alloc]initWithFrame:CGRectMake(contentX, contentY, contentW, contentH)];
        [_contentView setBackgroundColor:[UIColor whiteColor]];
    }
    return _contentView;
}

- (UIView *)lineView
{
    if (!_lineView) {
        CGFloat lineX = 0;
        CGFloat lineY = STControlSystemHeight;
        CGFloat lineW = self.contentView.st_width;
        CGFloat lineH = 0.5;
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(lineX, lineY, lineW, lineH)];
        [_lineView setBackgroundColor:self.borderButtonColor];
    }
    return _lineView;
}

- (UIPickerView *)pickerView
{
    if (!_pickerView) {
        CGFloat pickerW = self.contentView.st_width;
        CGFloat pickerH = self.contentView.st_height - self.lineView.st_bottom;
        CGFloat pickerX = 0;
        CGFloat pickerY = self.lineView.st_bottom;
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(pickerX, pickerY, pickerW, pickerH)];
        [_pickerView setBackgroundColor:[UIColor whiteColor]];
    }
    return _pickerView;
}

- (UIButton *)buttonLeft
{
    if (!_buttonLeft) {
        CGFloat leftW = STControlSystemHeight;
        CGFloat leftH = self.lineView.st_top - STMargin;
        CGFloat leftX = STMarginBig;
        CGFloat leftY = (self.lineView.st_top - leftH) / 2;
        _buttonLeft = [[UIButton alloc]initWithFrame:CGRectMake(leftX, leftY, leftW, leftH)];
        [_buttonLeft setTitle:@"取消" forState:UIControlStateNormal];
        [_buttonLeft setTitleColor:self.titleColor forState:UIControlStateNormal];
        [_buttonLeft addBorderColor:self.borderButtonColor];
        [_buttonLeft.titleLabel setFont:self.font];
        [_buttonLeft addTarget:self action:@selector(selectedCancel) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buttonLeft;
}

- (UIButton *)buttonRight
{
    if (!_buttonRight) {
        CGFloat rightW = self.buttonLeft.st_width;
        CGFloat rightH = self.buttonLeft.st_height;
        CGFloat rightX = self.contentView.st_width - rightW - self.buttonLeft.st_x;
        CGFloat rightY = self.buttonLeft.st_y;
        _buttonRight = [[UIButton alloc]initWithFrame:CGRectMake(rightX, rightY, rightW, rightH)];
        [_buttonRight setTitle:@"确定" forState:UIControlStateNormal];
        [_buttonRight setTitleColor:self.titleColor forState:UIControlStateNormal];
        [_buttonRight addBorderColor:self.borderButtonColor];
        [_buttonRight.titleLabel setFont:self.font];
        [_buttonRight addTarget:self action:@selector(selectedOk) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buttonRight;
}

- (UILabel *)labelTitle
{
    if (!_labelTitle) {
        CGFloat titleX = self.buttonLeft.st_right + STMarginSmall;
        CGFloat titleY = 0;
        CGFloat titleW = self.contentView.st_width - titleX * 2;
        CGFloat titleH = self.lineView.st_top;
        _labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(titleX, titleY, titleW, titleH)];
        [_labelTitle setTextAlignment:NSTextAlignmentCenter];
        [_labelTitle setTextColor:self.titleColor];
        [_labelTitle setFont:self.font];
        _labelTitle.adjustsFontSizeToFitWidth = YES;
    }
    return _labelTitle;
}

- (UIView *)lineViewDown
{
    if (!_lineViewDown) {
        CGFloat lineX = 0;
        CGFloat lineY = self.pickerView.st_bottom;
        CGFloat lineW = self.contentView.st_width;
        CGFloat lineH = 0.5;
        _lineViewDown = [[UIView alloc]initWithFrame:CGRectMake(lineX, lineY, lineW, lineH)];
        [_lineViewDown setBackgroundColor:self.borderButtonColor];
    }
    return _lineViewDown;
}
@end

