//
//  GLShopCell.m
//  GLWaterFlow
//
//  Created by jiaguanglei on 16/2/24.
//  Copyright © 2016年 roseonly. All rights reserved.
//

#import "GLShopCell.h"
#import "GLShop.h"

@interface GLShopCell ()
@property (weak, nonatomic) UIImageView *iconView;
@property (weak, nonatomic) UILabel *priceLabel;

@end

@implementation GLShopCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        // img
        UIImageView *icon = [[UIImageView alloc] init];
        [self addSubview:icon];
        self.iconView = icon;
        
        // label
        UILabel *price = [[UILabel alloc] init];
        price.textAlignment = NSTextAlignmentCenter;
        price.textColor = [UIColor redColor];
        price.backgroundColor = GL_COLOR_RANDOM;
        [self addSubview:price];
        self.priceLabel = price;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // img
    self.iconView.frame = CGRectMake(0, 0, self.width, self.height - 30);
    // label
    self.priceLabel.frame = CGRectMake(0, CGRectGetMaxY(self.iconView.frame), self.width, 30);
}

- (void)setShop:(GLShop *)shop
{
    _shop = shop;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:shop.img] placeholderImage:[UIImage imageNamed:@"1"]];
//    LogGreen(@"image = %@", shop.img);
//    LogRed(@"text = %@", shop.price);
    self.priceLabel.text = shop.price;
}

@end
