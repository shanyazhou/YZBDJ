//
//  UIBarButtonItem+YZBarButtonItem.h
//  YZBDJ
//
//  Created by lilida on 2018/2/12.
//  Copyright © 2018年 shanyazhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (YZBarButtonItem)
+ (UIBarButtonItem *)itemWithImage:(UIImage *)image HighImage:(UIImage *)highImage Target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)itemWithImage:(UIImage *)image SelImage:(UIImage *)selectImage Target:(id)target action:(SEL)action;

/*返回按钮**/
+ (UIBarButtonItem *)itemWithImage:(UIImage *)image HighImage:(UIImage *)highImage Target:(id)target action:(SEL)action title:(NSString *)title;
@end
