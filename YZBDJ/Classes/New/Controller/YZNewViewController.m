//
//  YZNewViewController.m
//  YZBDJ
//
//  Created by lilida on 2018/2/2.
//  Copyright © 2018年 shanyazhou. All rights reserved.
//

#import "YZNewViewController.h"
#import "YZTagSubViewController.h"

@interface YZNewViewController ()

@end

@implementation YZNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"MainTagSubIcon"] HighImage:[UIImage imageNamed:@"MainTagSubIconClick"] Target:self action:@selector(tagSubIconClick)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"nav_coin_icon"] HighImage:[UIImage imageNamed:@"nav_coin_icon_click"] Target:self action:@selector(coinClick)];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
}

- (void)tagSubIconClick
{
    YZTagSubViewController *tagSubVc = [[YZTagSubViewController alloc] init];
    tagSubVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:tagSubVc animated:YES];
}

- (void)coinClick
{
    YZFUNC;
}
@end
