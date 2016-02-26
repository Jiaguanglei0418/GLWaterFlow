//
//  ViewController.m
//  GLWaterFlow
//
//  Created by jiaguanglei on 16/2/24.
//  Copyright © 2016年 roseonly. All rights reserved.
//

#import "ViewController.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "GLShop.h"
#import "GLShopCell.h"
#import "GLWaterFlowLayout.h"

#import "GLShopDBUtils.h"
@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, GLWaterFlowLayoutDelegate>
/** tableView */
PROPERTYWEAK(UICollectionView, collectionView)


PROPERTYSTRONG(NSMutableArray, datas)
@end

@implementation ViewController
// 懒加载
- (NSMutableArray *)datas
{
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}


/**
 *  初始化collectionView
 */
- (void)setupCollectionView
{
    GLWaterFlowLayout *layout = [[GLWaterFlowLayout alloc] init];
    layout.delegate = self;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:GL_SCREEN_RECT collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor lightGrayColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    
    [collectionView registerClass:[GLShopCell class]forCellWithReuseIdentifier:@"shop"];
    
    self.collectionView = collectionView;
}

/**
 *  初始化refresh
 */
- (void)setupRefresh
{
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshMethod)];
    [self.collectionView.mj_header beginRefreshing];
    
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshMethod)];
//    [self.collectionView.mj_footer setHidden:YES];
}

- (void)headerRefreshMethod
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.datas removeAllObjects];
        
        [_datas addObjectsFromArray:[GLShopDBUtils shopsWithParam:YES]];
//        LogRed(@"%@", _datas);
        if (!_datas.count) {
            NSArray *shops = [GLShop mj_objectArrayWithFilename:@"1.plist"];
            [self.datas addObjectsFromArray:shops];
//            LogGreen(@"%@", _datas);
            // 存储
            [GLShopDBUtils addShops:shops];
            
//            LogPurple(@"%@", [GLShopDBUtils shopsWithParam:YES]);
        }
        

        [self.collectionView reloadData];
        
        [self.collectionView.mj_header endRefreshing];
    });
}


- (void)footerRefreshMethod
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSArray *shops = [GLShop mj_objectArrayWithFilename:@"1.plist"];
        [self.datas addObjectsFromArray:shops];
        
        
        [self.collectionView reloadData];
        [self.collectionView.mj_footer endRefreshing];
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupCollectionView];
    
    [self setupRefresh];
}


#pragma mark - GLWaterFlowDelegate
- (CGFloat)waterflowLayout:(GLWaterFlowLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth
{
    GLShop *shop = self.datas[index];
    
    CGFloat H = [shop.h doubleValue] * itemWidth / [shop.w doubleValue];
    return H;
}

- (CGFloat)rowMarginInWaterflowLayout:(GLWaterFlowLayout *)waterflowLayout
{
    return 10;
}

- (CGFloat)columnMarginInWaterflowLayout:(GLWaterFlowLayout *)waterflowLayout
{
    return 10;
}

- (NSInteger)columnCountInWaterflowLayout:(GLWaterFlowLayout *)waterflowLayout
{
    return 3;
}

- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(GLWaterFlowLayout *)waterflowLayout
{
    return UIEdgeInsetsMake(20, 5, 5, 5);
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    LogRed(@"%ld", self.datas.count);
    return self.datas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"shop";
    GLShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    GLShop *shop = self.datas[indexPath.row];
    cell.shop = shop;
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
