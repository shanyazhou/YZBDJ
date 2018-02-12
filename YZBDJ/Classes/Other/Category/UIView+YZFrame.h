//
//  UIView+YZFrame.h
//  YZBDJ
//
//  Created by lilida on 2018/2/12.
//  Copyright © 2018年 shanyazhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YZFrame)
//在category中，扩展的属性，不能够自动生成get set方法和_属性。需要自己自定义get set方法
@property CGFloat yz_width;
@property CGFloat yz_height;
@property CGFloat yz_x;
@property CGFloat yz_y;
@end
