//
//  YZNavigationViewController.m
//  YZBDJ
//
//  Created by lilida on 2018/2/12.
//  Copyright © 2018年 shanyazhou. All rights reserved.
//

#import "YZNavigationViewController.h"

@interface YZNavigationViewController ()

@end

@implementation YZNavigationViewController

+ (void)load
{
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    navBar.titleTextAttributes = attrs;
    
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    YZFUNC;
    
    //如果是根控制器，则不加这句话
    if (self.viewControllers.count) {
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"navigationButtonReturn"] HighImage:[UIImage imageNamed:@"navigationButtonReturnClick"] Target:self action:@selector(backBtnClick) title:@"返回"];
    }

    
    [super pushViewController:viewController animated:animated];
}

- (void)backBtnClick
{
    [self popViewControllerAnimated:YES];
}


@end
