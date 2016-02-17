//
//  STPickerSingle.h
//  STPickerView
//
//  Created by https://github.com/STShenZhaoliang/STPickerView on 16/2/16.
//  Copyright © 2016年 shentian. All rights reserved.
//

#import "STPickerView.h"
NS_ASSUME_NONNULL_BEGIN
@class STPickerSingle;
@protocol  STPickerSingleDelegate<NSObject>
- (void)pickerSingle:(STPickerSingle *)pickerSingle selectedTitle:(NSString *)selectedTitle;
@end

@interface STPickerSingle : STPickerView

/** 1.设置字符串数据数组 */
@property (nonatomic, strong)NSMutableArray<NSString *> *arrayData;
/** 2.设置单位标题 */
@property (nonatomic, strong)NSString *titleUnit;

@property(nonatomic, weak)id <STPickerSingleDelegate>delegate;

@end
NS_ASSUME_NONNULL_END
