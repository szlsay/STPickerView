//
//  STPickerDate.h
//  STPickerView
//
//  Created by https://github.com/STShenZhaoliang/STPickerView on 16/2/16.
//  Copyright © 2016年 shentian. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@class STPickerDate;
@protocol  STPickerDateDelegate<NSObject>
- (void)pickerDate:(STPickerDate *)pickerDate year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

@end
@interface STPickerDate : UIButton

@property(nonatomic, weak)id <STPickerDateDelegate>delegate ;

- (instancetype)initWithDelegate:(nullable id /*<STPickerDateDelegate>*/)delegate;

- (void)show;
@end
NS_ASSUME_NONNULL_END
