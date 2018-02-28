//
//  YZNavigationViewController.m
//  YZBDJ
//
//  Created by lilida on 2018/2/12.
//  Copyright © 2018年 shanyazhou. All rights reserved.
//

#import "YZNavigationViewController.h"

@interface YZNavigationViewController ()<UIGestureRecognizerDelegate>

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
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    pan.delegate = self;//添加代理，控制根控制器不需要滑动
    [self.view addGestureRecognizer:pan];
    self.interactivePopGestureRecognizer.enabled = NO;//禁止之前的手势
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    /**
     <UIScreenEdgePanGestureRecognizer: 0x10040efc0; state = Possible; delaysTouchesBegan = YES; view = <UILayoutContainerView 0x100318280>; target= <(action=handleNavigationTransition:, target=<_UINavigationInteractiveTransition 0x100402ae0>)>>
     */
    
    //如果是根控制器，则不加这句话
    if (self.viewControllers.count) {
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"navigationButtonReturn"] HighImage:[UIImage imageNamed:@"navigationButtonReturnClick"] Target:self action:@selector(backBtnClick) title:@"返回"];
        
//        YZLog(@"%@",self.interactivePopGestureRecognizer);
    }

    
    [super pushViewController:viewController animated:animated];
}

- (void)backBtnClick
{
    [self popViewControllerAnimated:YES];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if (self.childViewControllers.count > 1) {
        return YES;
    }else{
        return NO;
    }
}

@end
