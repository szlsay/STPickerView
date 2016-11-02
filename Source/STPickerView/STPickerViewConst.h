//
//  STPickerViewConst.h
//  STPickerView
//
//  Created by https://github.com/STShenZhaoliang/STPhotoBrowser.git on 16/1/15.
//  Copyright © 2016年 ST. All rights reserved.
//


/**
 *  1.屏幕尺寸
 */
#define STScreenWidth  CGRectGetWidth([UIScreen mainScreen].bounds)
#define STScreenHeight CGRectGetHeight([UIScreen mainScreen].bounds)

/**
 *  2.返回一个RGBA格式的UIColor对象
 */
#define STRGBA(r, g, b, a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

/**
 *  3.返回一个RGB格式的UIColor对象
 */
#define STRGB(r, g, b) STRGBA(r, g, b, 1.0f)

/**
 *  4.弱引用
 */
#define STWeakSelf __weak typeof(self) weakSelf = self;
