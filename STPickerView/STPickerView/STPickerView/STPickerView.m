//
//  STPickerView.m
//  STPickerView
//
//  Created by https://github.com/STShenZhaoliang/STPickerView on 16/2/17.
//  Copyright © 2016年 shentian. All rights reserved.
//

#import "STPickerView.h"


static CGFloat const PickerViewHeight = 240;

@interface STPickerView()



@end

@implementation STPickerView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    self.bounds = [UIScreen mainScreen].bounds;
    self.backgroundColor = RGBA(0, 0, 0, 102.0/255);
    self.layer.opacity = 0.0;

    [self addSubview:self.pickerView];
    [self.pickerView addSubview:self.lineView];
    [self addSubview:self.toolbar];
    [self addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
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

    CGRect frameTool = self.toolbar.frame;
    frameTool.origin.y -= PickerViewHeight;

    CGRect framePicker =  self.pickerView.frame;
    framePicker.origin.y -= PickerViewHeight;
    [UIView animateWithDuration:0.3 animations:^{
        [self.layer setOpacity:1];
        self.toolbar.frame = frameTool;
        self.pickerView.frame = framePicker;
    } completion:^(BOOL finished) {
    }];
}

- (void)remove
{
    CGRect frameTool = self.toolbar.frame;
    frameTool.origin.y += PickerViewHeight;

    CGRect framePicker =  self.pickerView.frame;
    framePicker.origin.y += PickerViewHeight;
    [UIView animateWithDuration:0.3 animations:^{
        [self.layer setOpacity:0];
        self.toolbar.frame = frameTool;
        self.pickerView.frame = framePicker;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - --- setters 属性 ---

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.toolbar.title = title;
}

#pragma mark - --- getters 属性 ---

- (UIPickerView *)pickerView
{
    if (!_pickerView) {
        CGFloat pickerW = ScreenWidth;
        CGFloat pickerH = PickerViewHeight - STControlSystemHeight;
        CGFloat pickerX = 0;
        CGFloat pickerY = ScreenHeight+STControlSystemHeight;
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(pickerX, pickerY, pickerW, pickerH)];
        [_pickerView setBackgroundColor:[UIColor whiteColor]];
    }
    return _pickerView;
}

- (STToolbar *)toolbar
{
    if (!_toolbar) {
        _toolbar = [[STToolbar alloc]initWithTitle:@""
                                 cancelButtonTitle:@"取消"
                                     okButtonTitle:@"确定"
                                         addTarget:self
                                      cancelAction:@selector(selectedCancel)
                                          okAction:@selector(selectedOk)];
        _toolbar.x = 0;
        _toolbar.y = ScreenHeight;
    }
    return _toolbar;
}

- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
        [_lineView setBackgroundColor:RGB(205, 205, 205)];
    }
    return _lineView;
}
@end

