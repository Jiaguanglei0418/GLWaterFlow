//
//  UIBarButtonItem+Extension.m
//
//
//  Created by apple on 14-10-7.
//  Copyright (c) 2014年 jiaguanglei. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"
//#import "UIView+Extension.h"
@implementation UIBarButtonItem (Extension)
/**
 *  创建一个item
 *  
 *  @param target    点击item后调用哪个对象的方法
 *  @param action    点击item后调用target的哪个方法
 *  @param image     图片
 *  @param highImage 高亮的图片
 *
 *  @return 创建完的item
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 设置图片
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    // 设置尺寸
    btn.size = btn.currentBackgroundImage.size;
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (UIBarButtonItem *)itemWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:title forState:UIControlStateNormal];
    
    [btn setTitleColor:PPCOLOR_TABBAR_TITLE forState:UIControlStateNormal];
    [btn setTitleColor:PPCOLOR_TABBAR_DISABLED forState:UIControlStateDisabled];
    [btn setTitleColor:PPCOLOR_TABBAR_TITLE forState:UIControlStateHighlighted];
    // 设置尺寸
    btn.size = CGSizeMake(44, 44);
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

@end
