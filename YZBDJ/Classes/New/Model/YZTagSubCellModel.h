//
//  YZTagSubCellModel.h
//  YZBDJ
//
//  Created by lilida on 2018/3/2.
//  Copyright © 2018年 shanyazhou. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 "image_list" = "http://img.spriteapp.cn/ugc/2017/06/c1d053a4565411e78e1f842b2b4c75ab.png";
 "is_default" = 0;
 "is_sub" = 0;
 "sub_number" = 285115;
 "theme_id" = 3096;
 "theme_name" = "\U7ea2\U4eba\U9891\U9053";
 */
@interface YZTagSubCellModel : NSObject
@property (copy, nonatomic) NSString *image_list;
@property (copy, nonatomic) NSString *theme_name;
@property (assign, nonatomic) NSInteger theme_id;
@property (assign, nonatomic) NSInteger sub_number;
@property (assign, nonatomic) BOOL is_sub;
@end
