//
//  UIView+STFrame.h
//  STPickerView
//
//  Created by ST on 16/10/31.
//  Copyright © 2016年 ST. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (STPicker)

/** 1.间隔X值 */
@property (nonatomic, assign) CGFloat st_x;

/** 2.间隔Y值 */
@property (nonatomic, assign) CGFloat st_y;

/** 3.宽度 */
@property (nonatomic, assign) CGFloat st_width;

/** 4.高度 */
@property (nonatomic, assign) CGFloat st_height;

/** 5.中心点X值 */
@property (nonatomic, assign) CGFloat st_centerX;

/** 6.中心点Y值 */
@property (nonatomic, assign) CGFloat st_centerY;

/** 7.尺寸大小 */
@property (nonatomic, assign) CGSize st_size;

/** 8.起始点 */
@property (nonatomic, assign) CGPoint st_origin;

/** 9.上 */
@property (nonatomic) CGFloat st_top;

/** 10.下 */
@property (nonatomic) CGFloat st_bottom;

/** 11.左 */
@property (nonatomic) CGFloat st_left;

/** 12.右 */
@property (nonatomic) CGFloat st_right;

/**
 *  1.添加边框
 *
 *  @param color <#color description#>
 */
- (void)addBorderColor:(UIColor *)color;

@end

