//
//  YZNewViewController.m
//  YZBDJ
//
//  Created by lilida on 2018/2/2.
//  Copyright © 2018年 shanyazhou. All rights reserved.
//

#import "YZNewViewController.h"

@interface YZNewViewController ()

@end

@implementation YZNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"nav_coin_icon"] HighImage:[UIImage imageNamed:@"nav_coin_icon_click"] Target:self action:@selector(coinClick)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"MainTagSubIcon"] HighImage:[UIImage imageNamed:@"MainTagSubIconClick"] Target:self action:@selector(tagSubIconClick)];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
}

- (void)coinClick
{
    YZFUNC;
}

- (void)tagSubIconClick
{
    YZFUNC;
}

@end
