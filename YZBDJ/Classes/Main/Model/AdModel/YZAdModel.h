//
//  YZAdModel.h
//  YZBDJ
//
//  Created by lilida on 2018/2/27.
//  Copyright © 2018年 shanyazhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YZAdModel : NSObject

/**
 广告图片的urlString地址
 */
@property (copy, nonatomic) NSString *w_picurl;
/**
 广告点击跳转
 */
@property (copy, nonatomic) NSString *ori_curl;

@property (assign, nonatomic) CGFloat w;
@property (assign, nonatomic) CGFloat h;
@end
