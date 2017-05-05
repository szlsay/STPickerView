//
//  STPickerArea.m
//  STPickerView
//
//  Created by https://github.com/STShenZhaoliang/STPickerView on 16/2/15.
//  Copyright © 2016年 shentian. All rights reserved.
//

#import "STPickerArea.h"

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

/** 6.省份 */
@property (nonatomic, strong, nullable)NSString *province;
/** 7.城市 */
@property (nonatomic, strong, nullable)NSString *city;
/** 8.地区 */
@property (nonatomic, strong, nullable)NSString *area;

@end

@implementation STPickerArea

#pragma mark - --- init 视图初始化 ---

- (void)setupUI
{
    // 1.获取数据
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
    
    // 2.设置视图的默认属性
    _heightPickerComponent = 32;
    [self setTitle:@"请选择城市地区"];
    [self.pickerView setDelegate:self];
    [self.pickerView setDataSource:self];

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
    return self.heightPickerComponent;
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

    [self reloadData];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view
{

    //设置分割线的颜色
    [pickerView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.frame.size.height <=1) {
            obj.backgroundColor = self.borderButtonColor;
        }
    }];
    
    
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
    if ([self.delegate respondsToSelector:@selector(pickerArea:province:city:area:)]) {
        [self.delegate pickerArea:self province:self.province city:self.city area:self.area];
    }
    [super selectedOk];
}

#pragma mark - --- private methods 私有方法 ---

- (void)reloadData
{
    NSInteger index0 = [self.pickerView selectedRowInComponent:0];
    NSInteger index1 = [self.pickerView selectedRowInComponent:1];
    NSInteger index2 = [self.pickerView selectedRowInComponent:2];
    self.province = self.arrayProvince[index0];
    self.city = self.arrayCity[index1];
    if (self.arrayArea.count != 0) {
        self.area = self.arrayArea[index2];
    }else{
        self.area = @"";
    }
    
    NSString *title = [NSString stringWithFormat:@"%@ %@ %@", self.province, self.city, self.area];
    [self setTitle:title];

}

#pragma mark - --- setters 属性 ---

#pragma mark - --- getters 属性 ---

- (NSArray *)arrayRoot
{
    if (!_arrayRoot) {
        NSString *path = [[NSBundle bundleForClass:[STPickerView class]] pathForResource:@"area" ofType:@"plist"];
        _arrayRoot = [[NSArray alloc]initWithContentsOfFile:path];
    }
    return _arrayRoot;
}

- (NSMutableArray *)arrayProvince
{
    if (!_arrayProvince) {
        _arrayProvince = @[].mutableCopy;
    }
    return _arrayProvince;
}

- (NSMutableArray *)arrayCity
{
    if (!_arrayCity) {
        _arrayCity = @[].mutableCopy;
    }
    return _arrayCity;
}

- (NSMutableArray *)arrayArea
{
    if (!_arrayArea) {
        _arrayArea = @[].mutableCopy;
    }
    return _arrayArea;
}

- (NSMutableArray *)arraySelected
{
    if (!_arraySelected) {
        _arraySelected = @[].mutableCopy;
    }
    return _arraySelected;
}

@end


