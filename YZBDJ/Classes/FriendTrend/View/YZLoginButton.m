//
//  YZLoginButton.m
//  YZBDJ
//
//  Created by lilida on 2018/3/5.
//  Copyright © 2018年 shanyazhou. All rights reserved.
//

#import "YZLoginButton.h"

@implementation YZLoginButton

//子控件布局，用layoutSubviews
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.yz_centerX = self.yz_width/2;
    self.imageView.yz_y = 20; 
    
    self.titleLabel.yz_y = CGRectGetMaxY(self.imageView.frame) + 5;
    [self.titleLabel sizeToFit];
    self.titleLabel.yz_centerX = self.imageView.yz_centerX;
}

//- (instancetype)initWithFrame:(CGRect)frame
//{
//    if (self = [super initWithFrame:frame]) {
//
//        CGPoint imageCenter = self.imageView.center;
//
//        self.imageView.center = CGPointMake(self.yz_width/2, imageCenter.y);
//    }
//
//    return self;
//}

@end
