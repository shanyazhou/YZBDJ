//
//  UIView+YZFrame.m
//  YZBDJ
//
//  Created by lilida on 2018/2/12.
//  Copyright © 2018年 shanyazhou. All rights reserved.
//

#import "UIView+YZFrame.h"

@implementation UIView (YZFrame)
- (void)setYz_width:(CGFloat)yz_width
{
    CGRect rect = self.frame;
    rect.size.width = yz_width;
    self.frame = rect;
}

- (CGFloat)yz_width
{
    return self.frame.size.width;
}

- (void)setYz_height:(CGFloat)yz_height
{
    CGRect rect = self.frame;
    rect.size.height = yz_height;
    self.frame = rect;
}

- (CGFloat)yz_height
{
    return self.frame.size.height;
}

- (void)setYz_x:(CGFloat)yz_x
{
    CGRect rect = self.frame;
    rect.origin.x = yz_x;
    self.frame = rect;
}

- (CGFloat)yz_x
{
    return self.frame.origin.x;
}

- (void)setYz_y:(CGFloat)yz_y
{
    CGRect rect = self.frame;
    rect.origin.y = yz_y;
    self.frame = rect;
}

- (CGFloat)yz_y
{
    return self.frame.origin.y;
}

@end
