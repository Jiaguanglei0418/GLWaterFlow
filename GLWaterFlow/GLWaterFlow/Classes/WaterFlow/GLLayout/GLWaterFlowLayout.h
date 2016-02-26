//
//  GLWaterFlowLayout.h
//  GLWaterFlow
//
//  Created by jiaguanglei on 16/2/25.
//  Copyright © 2016年 roseonly. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GLWaterFlowLayout;

@protocol GLWaterFlowLayoutDelegate <NSObject>
@required
/** 根据图片宽度计算 iconView的高度 */
- (CGFloat)waterflowLayout:(GLWaterFlowLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth;

@optional
- (NSInteger)columnCountInWaterflowLayout:(GLWaterFlowLayout *)waterflowLayout;
- (CGFloat)columnMarginInWaterflowLayout:(GLWaterFlowLayout *)waterflowLayout;
- (CGFloat)rowMarginInWaterflowLayout:(GLWaterFlowLayout *)waterflowLayout;
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(GLWaterFlowLayout *)waterflowLayout;

@end

@interface GLWaterFlowLayout : UICollectionViewLayout


PROPERTYDELEGATE(GLWaterFlowLayoutDelegate, delegate)
@end
