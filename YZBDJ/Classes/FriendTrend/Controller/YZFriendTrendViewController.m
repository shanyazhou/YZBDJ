//
//  YZFriendTrendViewController.m
//  YZBDJ
//
//  Created by lilida on 2018/2/2.
//  Copyright © 2018年 shanyazhou. All rights reserved.
//

#import "YZFriendTrendViewController.h"
#import "YZLoginViewController.h"

@interface YZFriendTrendViewController ()
- (IBAction)loginBtnClick:(UIButton *)sender;

@end

@implementation YZFriendTrendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"friendsRecommentIcon"] HighImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] Target:self action:@selector(recommentClick)];
    
    self.navigationItem.title = @"我的关注";
}

- (void)recommentClick
{
    
}

- (IBAction)loginBtnClick:(UIButton *)sender {
    YZLoginViewController *loginVc = [[YZLoginViewController alloc] init];
    [self presentViewController:loginVc animated:YES completion:nil];
}
@end
