//
//  STToolbar.h
//  STPickerView
//
//  Created by https://github.com/STShenZhaoliang/STPickerView on 16/2/16.
//  Copyright © 2016年 shentian. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface STToolbar : UIView

/** 1.标题，default is nil */
@property(nullable, nonatomic,copy) NSString          *title;
/** 2.字体，default is nil (system font 17 plain) */
@property(null_resettable, nonatomic,strong) UIFont   *font;
/** 3.字体颜色，default is nil (text draws black) */
@property(null_resettable, nonatomic,strong) UIColor  *titleColor;
/** 4.按钮边框颜色颜色，default is RGB(205, 205, 205) */
@property(null_resettable, nonatomic,strong) UIColor  *borderButtonColor;

/**
 *  1.初始化方法
 *
 *  @param title             <#title description#>
 *  @param cancelButtonTitle <#cancelButtonTitle description#>
 *  @param okButtonTitle     <#okButtonTitle description#>
 *  @param target            <#target description#>
 *  @param cancelAction      <#cancelAction description#>
 *  @param okAction          <#okAction description#>
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithTitle:(nullable NSString *)title
            cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                okButtonTitle:(nullable NSString *)okButtonTitle
                    addTarget:(nullable id)target
                 cancelAction:(SEL)cancelAction
                     okAction:(SEL)okAction;
@end
NS_ASSUME_NONNULL_END