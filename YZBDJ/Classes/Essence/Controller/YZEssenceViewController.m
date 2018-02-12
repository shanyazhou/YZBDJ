//
//  YZEssenceViewController.m
//  YZBDJ
//
//  Created by lilida on 2018/2/2.
//  Copyright © 2018年 shanyazhou. All rights reserved.
//

#import "YZEssenceViewController.h"

@interface YZEssenceViewController ()

@end

@implementation YZEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    NSLog(@"%d", AAA);
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"nav_item_game_icon"] HighImage:[UIImage imageNamed:@"nav_item_game_click_icon"] Target:self action:@selector(gameClick)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"navigationButtonRandom"] HighImage:[UIImage imageNamed:@"navigationButtonRandomClick"] Target:self action:@selector(randomClick)];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
}

- (void)gameClick
{
    YZFUNC;
}

- (void)randomClick
{
    YZFUNC;
}
@end
