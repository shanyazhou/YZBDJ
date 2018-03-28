//
//  YZNewViewController.m
//  YZBDJ
//
//  Created by lilida on 2018/2/2.
//  Copyright © 2018年 shanyazhou. All rights reserved.
//

#import "YZNewViewController.h"
#import "YZTagSubViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>

@interface YZNewViewController ()

@end

@implementation YZNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"MainTagSubIcon"] HighImage:[UIImage imageNamed:@"MainTagSubIconClick"] Target:self action:@selector(tagSubIconClick)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"nav_coin_icon"] HighImage:[UIImage imageNamed:@"nav_coin_icon_click"] Target:self action:@selector(coinClick)];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
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

- (void)tagSubIconClick
{
    YZTagSubViewController *tagSubVc = [[YZTagSubViewController alloc] init];
    tagSubVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:tagSubVc animated:YES];
}

- (void)coinClick
{
    YZFUNC;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"parentId"] = @"7";

    
    [manager GET:@"http://2d.cc:8080/api-restservice/getSomething" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        YZLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        YZLog(@"%@",error);
    }];
    
    
}
@end
