//
//  STPickerArea.h
//  STPickerView
//
//  Created by https://github.com/STShenZhaoliang/STPickerView on 16/2/15.
//  Copyright © 2016年 shentian. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@class STPickerArea;
@protocol  STPickerAreaDelegate<NSObject>

- (void)pickerArea:(STPickerArea *)pickerArea province:(NSString *)province city:(NSString *)city area:(NSString *)area;

@end
@interface STPickerArea : UIButton

@property(nonatomic, weak)id <STPickerAreaDelegate>delegate ;

- (instancetype)initWithDelegate:(nullable id /*<STPickerAreaDelegate>*/)delegate;

- (void)show;
@end
NS_ASSUME_NONNULL_END