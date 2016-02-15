//
//  STPickerArea.h
//  STPickerView
//
//  Created by https://github.com/STShenZhaoliang/STPickerView on 16/2/15.
//  Copyright © 2016年 shentian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STPickerArea : UIButton
@property (nonatomic, copy) NSString *province; // 省份
@property (nonatomic, copy) NSString *city;  // 城市
@property (nonatomic, copy) NSString *area;  // 地区
- (void)show;
@end
