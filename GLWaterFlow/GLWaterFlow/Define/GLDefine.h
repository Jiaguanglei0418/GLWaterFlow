//
//  GLDefine.h
//  GLWaterFlow
//
//  Created by jiaguanglei on 16/2/24.
//  Copyright © 2016年 roseonly. All rights reserved.
//

#ifndef GLDefine_h
#define GLDefine_h

/**
 *  1. 属性
 */
#define PROPERTYWEAK(UIImageView, imageView) @property (nonatomic, weak) UIImageView *imageView;
#define PROPERTYSTRONG(UIImageView, imageView) @property (nonatomic, strong) UIImageView *imageView;
#define PROPERTYCOPY(NSString, name) @property (nonatomic, copy) NSString *name;
#define PROPERTYASSIGN(int, i) @property (nonatomic, assign) int i;
#define PROPERTYDELEGATE(PPComposeToolbarDelegate, delegate) @property (nonatomic, weak) id<PPComposeToolbarDelegate> delegate;


/**
 *  2.通知
 */
#define PPNOTICEFICATION [NSNotificationCenter defaultCenter]



/**
 *  3. 获取屏幕宽度
 */
#define GL_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define GL_SCREEN_HIGHT [UIScreen mainScreen].bounds.size.height
#define GL_SCREEN_SIZE [UIScreen mainScreen].bounds.size
#define GL_SCREEN_RECT [UIScreen mainScreen].bounds


/**
 *  4. weakSelf
 */
#define WS(weakSelf)  __weak typeof(self)weakSelf = self


/**
 *  1. RGB背景色
 */
#define GL_COLOR_RGB(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

#define GL_COLOR_BG [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1]

#define GL_COLOR_RANDOM GL_COLOR_RGB(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))




#endif /* GLDefine_h */

