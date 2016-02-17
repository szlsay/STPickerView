//
//  STPickerView.h
//  STPickerView
//
//  Created by https://github.com/STShenZhaoliang/STPickerView on 16/2/17.
//  Copyright © 2016年 shentian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STToolbar.h"
#import "STConfig.h"

NS_ASSUME_NONNULL_BEGIN
@interface STPickerView : UIButton

/** 1.选择器 */
@property (nonatomic, strong)UIPickerView *pickerView;
/** 2.工具器 */
@property (nonatomic, strong)STToolbar *toolbar;
/** 3.边线 */
@property (nonatomic, strong)UIView *lineView;
/** 4.标题 */
@property (nonatomic, strong)NSString *title;

/**
 *  5.创建视图
 */
- (void)setupUI;

/**
 *  6.确认按钮的点击事件
 */
- (void)selectedOk;

/**
 *  7.显示
 */
- (void)show;

/**
 *  8.移除
 */
- (void)remove;

@end
NS_ASSUME_NONNULL_END
