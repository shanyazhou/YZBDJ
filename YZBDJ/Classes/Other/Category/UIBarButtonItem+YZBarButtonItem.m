//
//  UIBarButtonItem+YZBarButtonItem.m
//  YZBDJ
//
//  Created by lilida on 2018/2/12.
//  Copyright © 2018年 shanyazhou. All rights reserved.
//

#import "UIBarButtonItem+YZBarButtonItem.h"

@implementation UIBarButtonItem (YZBarButtonItem)
+ (UIBarButtonItem *)itemWithImage:(UIImage *)image HighImage:(UIImage *)highImage Target:(id)target action:(SEL)action
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highImage forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    
    UIView *containView = [[UIView alloc] init];
    [containView addSubview:btn];
    containView.frame = btn.bounds;
    return [[UIBarButtonItem alloc] initWithCustomView:containView];
}

+ (UIBarButtonItem *)itemWithImage:(UIImage *)image SelImage:(UIImage *)selectImage Target:(id)target action:(SEL)action
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:selectImage forState:UIControlStateSelected];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    
    UIView *containView = [[UIView alloc] init];
    [containView addSubview:btn];
    containView.frame = btn.bounds;
    return [[UIBarButtonItem alloc] initWithCustomView:containView];
}
@end
