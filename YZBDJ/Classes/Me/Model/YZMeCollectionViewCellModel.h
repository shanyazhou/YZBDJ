//
//  YZMeCollectionViewCellModel.h
//  YZBDJ
//
//  Created by lilida on 2018/3/7.
//  Copyright © 2018年 shanyazhou. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 android = "";
 icon = "http://img.spriteapp.cn/ugc/2015/05/20/150532_5078.png";
 id = 28;
 ipad = "";
 iphone = "";
 market = "";
 name = "\U5ba1\U5e16";
 url = "mod://BDJ_To_Check";
 */
@interface YZMeCollectionViewCellModel : NSObject
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *icon;
@property (strong, nonatomic) NSString *url;
@end
