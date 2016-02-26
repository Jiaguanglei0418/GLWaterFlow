//
//  GLShopDBUtils.h
//  GLWaterFlow
//
//  Created by jiaguanglei on 16/2/25.
//  Copyright © 2016年 roseonly. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GLShop;

@interface GLShopDBUtils : NSObject

/**
 *  缓存一条shop -  模型
 *
 *  @param dict 需要缓存的微博数据
 */
+ (void)addShop:(GLShop *)shop;


/**
 *  缓存多条shops
 *
 *  @param  需要缓存的 -  模型数组
 */
+ (void)addShops:(NSArray *)shops;


/**
 *  加载缓存中的shop数据
 *
 *  @param param 请求参数
 *
 *  @return shop数组
 */
//+ (NSArray *)shopsWithParam:(PPHomeStatusesParam *)param;
+ (NSArray *)shopsWithParam:(BOOL)isDB;
@end
