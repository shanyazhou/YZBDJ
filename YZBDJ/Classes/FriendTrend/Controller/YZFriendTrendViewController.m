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
    
    [self getNotification];
}

- (void)getNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarClick) name:@"TabBarDoubleClickRefresh" object:nil];
}

#pragma mark - dealloc
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - action
- (void)tabBarClick
{
    //YZLog(@"%@,%@,%@",self, self.view, self.view.window);
    //首先，谁都能接收到，因此，必须找到当前显示view刷新
    if (self.view.window == nil) return;//如果不显示，则 self.view.window == nil 重要知识点
    
    YZLog(@"%@-刷新",self.class);
}

- (void)recommentClick
{
    
}

- (IBAction)loginBtnClick:(UIButton *)sender {
    YZLoginViewController *loginVc = [[YZLoginViewController alloc] init];
    [self presentViewController:loginVc animated:YES completion:nil];
}
@end
