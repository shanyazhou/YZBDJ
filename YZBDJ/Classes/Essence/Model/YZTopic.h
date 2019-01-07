//
//  YZTopic.h
//  YZBDJ
//
//  Created by lilida on 2018/7/13.
//  Copyright © 2018年 shanyazhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YZTopic : NSObject
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *profile_image;
@property (copy, nonatomic) NSString *text;
@property (copy, nonatomic) NSString *passtime;

@property (assign, nonatomic) NSInteger ding;
@property (assign, nonatomic) NSInteger cai;
@property (assign, nonatomic) NSInteger repost;
@property (assign, nonatomic) NSInteger comment;
@end
