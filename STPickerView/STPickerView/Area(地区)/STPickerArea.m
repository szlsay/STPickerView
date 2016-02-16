//
//  STPickerArea.m
//  STPickerView
//
//  Created by https://github.com/STShenZhaoliang/STPickerView on 16/2/15.
//  Copyright © 2016年 shentian. All rights reserved.
//

#import "STPickerArea.h"
#import "STToolbar.h"

#import "STConfig.h"

static CGFloat const PickerViewHeight = 244;

@interface STPickerArea()<UIPickerViewDataSource, UIPickerViewDelegate>

/** 1.数据源数组 */
@property (nonatomic, strong, nullable)NSArray *arrayRoot;
/** 2.当前省数组 */
@property (nonatomic, strong, nullable)NSMutableArray *arrayProvince;
/** 3.当前城市数组 */
@property (nonatomic, strong, nullable)NSMutableArray *arrayCity;
/** 4.当前地区数组 */
@property (nonatomic, strong, nullable)NSMutableArray *arrayArea;
/** 5.当前选中数组 */
@property (nonatomic, strong, nullable)NSMutableArray *arraySelected;

/** 6.选择器 */
@property (nonatomic, strong, nullable)UIPickerView *pickerView;
/** 7.工具器 */
@property (nonatomic, strong, nullable)STToolbar *toolbar;
/** 8.边线 */
@property (nonatomic, strong, nullable)UIView *lineView;

/** 9.省份 */
@property (nonatomic, strong, nullable)NSString *province;
/** 10.城市 */
@property (nonatomic, strong, nullable)NSString *city;
/** 11.地区 */
@property (nonatomic, strong, nullable)NSString *area;

@end

@implementation STPickerArea

#pragma mark - --- init 视图初始化 ---

- (instancetype)initWithDelegate:(nullable id /*<STPickerAreaDelegate>*/)delegate
{
    self = [self init];
    self.delegate = delegate;
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
        [self loadData];
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

- (void)loadData
{
    [self.arrayRoot enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.arrayProvince addObject:obj[@"state"]];
    }];

    NSMutableArray *citys = [NSMutableArray arrayWithArray:[self.arrayRoot firstObject][@"cities"]];
    [citys enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.arrayCity addObject:obj[@"city"]];
    }];

    self.arrayArea = [citys firstObject][@"area"];

    self.province = self.arrayProvince[0];
    self.city = self.arrayCity[0];
    if (self.arrayArea.count != 0) {
        self.area = self.arrayArea[0];
    }else{
        self.area = @"";
    }

}
#pragma mark - --- delegate 视图委托 ---

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return self.arrayProvince.count;
    }else if (component == 1) {
        return self.arrayCity.count;
    }else{
        return self.arrayArea.count;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return STControlSystemHeight;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        self.arraySelected = self.arrayRoot[row][@"cities"];

        [self.arrayCity removeAllObjects];
        [self.arraySelected enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.arrayCity addObject:obj[@"city"]];
        }];

        self.arrayArea = [NSMutableArray arrayWithArray:[self.arraySelected firstObject][@"areas"]];

        [pickerView reloadComponent:1];
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:1 animated:YES];
        [pickerView selectRow:0 inComponent:2 animated:YES];

    }else if (component == 1) {
        if (self.arraySelected.count == 0) {
            self.arraySelected = [self.arrayRoot firstObject][@"cities"];
        }

        self.arrayArea = [NSMutableArray arrayWithArray:[self.arraySelected objectAtIndex:row][@"areas"]];

        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:YES];

    }else{
    }

    NSInteger index0 = [pickerView selectedRowInComponent:0];
    NSInteger index1 = [pickerView selectedRowInComponent:1];
    NSInteger index2 = [pickerView selectedRowInComponent:2];
    self.province = self.arrayProvince[index0];
    self.city = self.arrayCity[index1];
    if (self.arrayArea.count != 0) {
        self.area = self.arrayArea[index2];
    }else{
        self.area = @"";
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view
{

    NSString *text;
    if (component == 0) {
        text =  self.arrayProvince[row];
    }else if (component == 1){
        text =  self.arrayCity[row];
    }else{
        if (self.arrayArea.count > 0) {
            text = self.arrayArea[row];
        }else{
            text =  @"";
        }
    }


    UILabel *label = [[UILabel alloc]init];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont systemFontOfSize:17]];
    [label setText:text];
    return label;


}
#pragma mark - --- event response 事件相应 ---

- (void)selectedOk
{
    [self.delegate pickerArea:self province:self.province city:self.city area:self.area];
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

#pragma mark - --- getters 属性 ---

- (NSArray *)arrayRoot
{
    if (!_arrayRoot) {
        NSString *path = [[NSBundle mainBundle]pathForResource:@"area" ofType:@"plist"];
        _arrayRoot = [[NSArray alloc]initWithContentsOfFile:path];
    }
    return _arrayRoot;
}

- (NSMutableArray *)arrayProvince
{
    if (!_arrayProvince) {
        _arrayProvince = [NSMutableArray array];
    }
    return _arrayProvince;
}

- (NSMutableArray *)arrayCity
{
    if (!_arrayCity) {
        _arrayCity = [NSMutableArray array];
    }
    return _arrayCity;
}

- (NSMutableArray *)arrayArea
{
    if (!_arrayArea) {
        _arrayArea = [NSMutableArray array];
    }
    return _arrayArea;
}

- (NSMutableArray *)arraySelected
{
    if (!_arraySelected) {
        _arraySelected = [NSMutableArray array];
    }
    return _arraySelected;
}

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
        _toolbar = [[STToolbar alloc]initWithTitle:@"选择城市地区"
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


