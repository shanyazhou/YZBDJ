//
//  YZFastLoginView.m
//  YZBDJ
//
//  Created by lilida on 2018/3/6.
//  Copyright © 2018年 shanyazhou. All rights reserved.
//

#import "YZFastLoginView.h"

@implementation YZFastLoginView

+ (instancetype)getFastLoginView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"YZFastLoginView" owner:nil options:nil] firstObject];
}

@end
