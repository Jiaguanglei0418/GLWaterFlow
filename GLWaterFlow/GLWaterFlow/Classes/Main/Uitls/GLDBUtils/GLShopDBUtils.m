//
//  GLShopDBUtils.m
//  GLWaterFlow
//
//  Created by jiaguanglei on 16/2/25.
//  Copyright © 2016年 roseonly. All rights reserved.
//

#import "GLShopDBUtils.h"
#import "FMDB.h"
#import "GLShop.h"
#import "SDWebimageManager.h"

/**
 *  采用多线程
 */
static FMDatabaseQueue *_dbQueue;
@implementation GLShopDBUtils
//TODO: 数据缓存
+ (void)initialize
{
    // 0. 获得沙盒路径
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"shops.sqlite"];
    
    // 1. 创建队列
    _dbQueue = [FMDatabaseQueue databaseQueueWithPath:path];
    
    // 2. 创建表
    [_dbQueue inDatabase:^(FMDatabase *db) {
        BOOL suc = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_shops (id integer primary key autoincrement, img blob, price text, w text, h text);"];
        if (suc) {
            LogRed(@"创建表成功!!!");
        }else{
            LogYellow(@"建表失败!!!");
        }
    }];
}

/**
 *  缓存字典数组
 */
+ (void)addShops:(NSArray *)shops
{
    [shops enumerateObjectsUsingBlock:^(GLShop * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self addShop:obj];
    }];
}

/**
 *  缓存 模型 数组
 */
+ (void)addShop:(GLShop *)shop
{
    // 3. 写入数据
    [_dbQueue inDatabase:^(FMDatabase *db) {
        NSString *price = shop.price;
        NSString *w = shop.w;
        NSString *h = shop.h;
        NSString *img = shop.img;
        
//        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:shop];
        //        NSData *statusData = [];
        [db executeUpdate:@"INSERT INTO t_shops (img, price, w, h) values(?, ?, ?, ?)", img, price, w, h];
        //        [db executeUpdate:@"INSERT INTO t_statuses (access_token, idstr, dict) values(?, ? , ?)", token, idstr, data];
    }];
    [_dbQueue close];
}

/**
 *  从缓存中读取数据
 *
 *  @param param 请求参数 (加载更多, 刷新)
 *
 *  @return 字典数组
 */
+ (NSArray *)shopsWithParam:(BOOL)isDB
{
    __block NSMutableArray *shops = [NSMutableArray array];
    
    // 4. 查数据
    [_dbQueue inDatabase:^(FMDatabase *db) {
       
        FMResultSet *set = nil;
        if (isDB) {
            set = [db executeQuery:@"SELECT * FROM t_shops;"];
        }
//        if (param.since_id) {
//            set = [db executeQuery:@"SELECT * FROM t_statuses where access_token = ? and idstr > ? order by idstr desc limit 0, ?;", accessToken, param.since_id, param.count];
//        }else if (param.max_id){
//            set = [db executeQuery:@"SELECT * FROM t_statuses where access_token = ? and idstr <= ? order by idstr desc limit 0, ?;", accessToken, param.max_id, param.count];
//        }else{
//            set = [db executeQuery:@"SELECT * FROM t_statuses where access_token = ? order by idstr desc limit 0, ?;", accessToken, param.count];
//        }
        
        while([set next]) {
            NSString *img = [set stringForColumn:@"img"];
            NSString *price = [set stringForColumn:@"price"];
            NSString *w = [set stringForColumn:@"w"];
            NSString *h = [set stringForColumn:@"h"];
//            NSDictionary *status = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            GLShop *shop = [[GLShop alloc] init];
            shop.img = img;
            shop.price = price;
            shop.w = w;
            shop.h = h;
            [shops addObject:shop];
        }
    }];
    [_dbQueue close];
    
    return shops;
}

@end
