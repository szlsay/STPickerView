//
//  STPickerSingle.m
//  STPickerView
//
//  Created by https://github.com/STShenZhaoliang/STPickerView on 16/2/16.
//  Copyright © 2016年 shentian. All rights reserved.
//

#import "STPickerSingle.h"
#import "STConfig.h"

static CGFloat const PickerViewHeight = 240;
static CGFloat const PickerViewLabelWeight = 32;

@interface STPickerSingle()<UIPickerViewDataSource, UIPickerViewDelegate>

/** 1.选择器 */
@property (nonatomic, strong, nullable)UIPickerView *pickerView;
/** 2.工具器 */
@property (nonatomic, strong, nullable)STToolbar *toolbar;
/** 3.边线 */
@property (nonatomic, strong, nullable)UIView *lineView;
/** 4.选中的字符串 */
@property (nonatomic, strong, nullable)NSString *selectedTitle;

@end

@implementation STPickerSingle

#pragma mark - --- init 视图初始化 ---

- (instancetype)initWithArrayData:(NSArray<NSString *>*)arrayData
                        titleUnit:(NSString *)titleUnit
                         delegate:(nullable id)delegate
{
    self.arrayData = arrayData.mutableCopy;
    self.titleUnit = titleUnit;
    
    self = [self init];
    self.delegate = delegate;
    return self;
}

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
    [self.layer setOpaque:0.0];
    [self addSubview:self.pickerView];
    [self.pickerView addSubview:self.lineView];
    [self addSubview:self.toolbar];
    [self addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - --- delegate 视图委托 ---

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return 1;
    }else if (component == 1){
        return self.arrayData.count;
    }else {
        return 1;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return STControlNormalHeight;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    
    if (component == 0) {
        return (ScreenWidth-PickerViewLabelWeight)/2;
    }else if (component == 1){
        return PickerViewLabelWeight;
    }else {
        return (ScreenWidth-PickerViewLabelWeight)/2;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectedTitle = self.arrayData[row];
    [self.toolbar setTitle:[NSString stringWithFormat:@"%@ %@", self.selectedTitle, self.titleUnit]];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view
{
    
    if (component == 0) {
        return nil;
    }else if (component == 1){
        UILabel *label = [[UILabel alloc]init];
        [label setText:self.arrayData[row]];
        [label setTextAlignment:NSTextAlignmentCenter];
        return label;
    }else {
        UILabel *label = [[UILabel alloc]init];
        [label setText:self.titleUnit];
        [label setTextAlignment:NSTextAlignmentLeft];
        return label;
    }
}
#pragma mark - --- event response 事件相应 ---

- (void)selectedOk
{
    [self.delegate pickerSingle:self selectedTitle:self.selectedTitle];
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
    [UIView animateWithDuration:0.33 animations:^{
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
    [UIView animateWithDuration:0.33 animations:^{
        [self.layer setOpacity:0];
        self.toolbar.frame = frameTool;
        self.pickerView.frame = framePicker;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - --- setters 属性 ---

- (void)setArrayData:(NSMutableArray<NSString *> *)arrayData
{
    _arrayData = arrayData;
    _selectedTitle = arrayData.firstObject;
    [self.pickerView reloadAllComponents];
}

- (void)setTitleUnit:(NSString *)titleUnit
{
    _titleUnit = titleUnit;
    [self.pickerView reloadAllComponents];
}

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
        [_pickerView setDataSource:self];
        [_pickerView setDelegate:self];
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

