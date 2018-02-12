//
//  UIImage+YZImage.m
//  YZBDJ
//
//  Created by lilida on 2018/2/5.
//  Copyright © 2018年 shanyazhou. All rights reserved.
//

#import "UIImage+YZImage.h"

@implementation UIImage (YZImage)
/**
 图片不需要渲染
 */
+ (UIImage *)imageWithOriginalImageName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}
@end
