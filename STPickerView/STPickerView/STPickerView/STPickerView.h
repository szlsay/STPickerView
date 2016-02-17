//
//  STPickerView.h
//  STPickerView
//
//  Created by 沈兆良 on 16/2/17.
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

- (void)setupUI;

- (void)selectedOk;

- (void)show;

- (void)remove;

@end
NS_ASSUME_NONNULL_END
