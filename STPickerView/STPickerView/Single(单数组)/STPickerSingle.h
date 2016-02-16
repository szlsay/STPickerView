//
//  STPickerSingle.h
//  STPickerView
//
//  Created by https://github.com/STShenZhaoliang/STPickerView on 16/2/16.
//  Copyright © 2016年 shentian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class STPickerSingle;
@protocol  STPickerSingleDelegate<NSObject>
- (void)pickerSingle:(STPickerSingle *)pickerSingle selectedTitle:(NSString *)selectedTitle;

@end

@interface STPickerSingle : UIButton

/** 1.设置字符串数据数组 */
@property (nonatomic, strong)NSMutableArray<NSString *> *arrayData;
/** 2.设置单位标题 */
@property (nonatomic, strong)NSString *titleUnit;
/** 3.标题 */
@property (nonatomic, strong)NSString *title;

@property(nonatomic, weak)id <STPickerSingleDelegate>delegate;

- (instancetype)initWithArrayData:(NSArray<NSString *>*)arrayData
                        titleUnit:(NSString *)titleUnit
                         delegate:(nullable id)delegate;

- (void)show;
@end
NS_ASSUME_NONNULL_END
