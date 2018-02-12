//
//  YZTabBarController.m
//  YZBDJ
//
//  Created by lilida on 2018/2/5.
//  Copyright © 2018年 shanyazhou. All rights reserved.
//

#import "YZTabBarController.h"
#import "YZEssenceViewController.h"
#import "YZFriendTrendViewController.h"
#import "YZNewViewController.h"
#import "YZPublishViewController.h"
#import "YZMeViewController.h"
#import "UIImage+YZImage.h"
#import "YZTabBar.h"
#import "YZNavigationViewController.h"

@interface YZTabBarController ()

@end

@implementation YZTabBarController
/**
 1 选中图片被渲染
 2 选中标题颜色：黑色，标题字体大
 3 发布按钮显示不出来
 */

//当程序启动的时候，所有的类的load方法都会被调用一次
+ (void)load
{
    //关于appearance
//    UITabBarItem *item = [UITabBarItem appearance];
    
    //尽量不要用上面那个，那个是全局的。用下面这个，这个只是这个类的
    //appearance只有遵循它的代理，才能够使用
    //appearance只有在控件显示前调用才有用，在显示后再调用就没有效果了。因此，一般，把之前的控件移除，之后调用appearance，再把控件加上去
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    [item setTitleTextAttributes:attrs forState:UIControlStateSelected];
    
    //字体大小的设置只有在normal状态下才有用
    NSMutableDictionary *attrsNor = [NSMutableDictionary dictionary];
    attrsNor[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:attrsNor forState:UIControlStateNormal];
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupAllChildViewController];
    
    [self setupAllTabBarItem];
    
    [self setupTabBar];
}

- (void)setupAllChildViewController
{
    //精华
    YZEssenceViewController *essenceVc = [[YZEssenceViewController alloc] init];
    YZNavigationViewController *nav = [[YZNavigationViewController alloc] initWithRootViewController:essenceVc];
    [self addChildViewController:nav];
    
    //新贴
    YZNewViewController *newVc = [[YZNewViewController alloc] init];
    YZNavigationViewController *nav1 = [[YZNavigationViewController alloc] initWithRootViewController:newVc];
    [self addChildViewController:nav1];
    
//    //发布
//    YZPublishViewController *publicVc = [[YZPublishViewController alloc] init];
//    [self addChildViewController:publicVc];
    
    //关注
    YZFriendTrendViewController *friendTrendVC = [[YZFriendTrendViewController alloc] init];
    YZNavigationViewController *nav3 = [[YZNavigationViewController alloc] initWithRootViewController:friendTrendVC];
    [self addChildViewController:nav3];
    
    //我
    YZMeViewController *meVc = [[YZMeViewController alloc] init];
    YZNavigationViewController *nav4 = [[YZNavigationViewController alloc] initWithRootViewController:meVc];
    [self addChildViewController:nav4];
}

- (void)setupAllTabBarItem
{
    //精华
    YZNavigationViewController *nav = self.childViewControllers[0];
    nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"精华" image:[UIImage imageNamed:@"tabBar_essence_icon"] selectedImage:[UIImage imageWithOriginalImageName:@"tabBar_essence_click_icon"]];
    
    //新贴
    YZNavigationViewController *nav1 = self.childViewControllers[1];
    nav1.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"新贴" image:[UIImage imageNamed:@"tabBar_new_icon"] selectedImage:[UIImage imageWithOriginalImageName:@"tabBar_new_click_icon"]];
    
//    //发布
//    YZPublishViewController *publicVc = self.childViewControllers[2];
//    publicVc.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageWithOriginalImageName:@"tabBar_publish_icon"] selectedImage:[UIImage imageWithOriginalImageName:@"tabBar_publish_click_icon"]];
//    publicVc.tabBarItem.imageInsets = UIEdgeInsetsMake(7, 0, -7, 0);
    
    //关注
    YZNavigationViewController *nav3 = self.childViewControllers[2];
    nav3.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"关注" image:[UIImage imageNamed:@"tabBar_friendTrends_icon"] selectedImage:[UIImage imageWithOriginalImageName:@"tabBar_friendTrends_click_icon"]];
    
    //我
    YZNavigationViewController *nav4 = self.childViewControllers[3];
    nav4.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我" image:[UIImage imageNamed:@"tabBar_me_icon"] selectedImage:[UIImage imageWithOriginalImageName:@"tabBar_me_click_icon"]];
}

- (void)setupTabBar
{
    YZTabBar *tabBar = [[YZTabBar alloc] init];
    [self setValue:tabBar forKeyPath:@"tabBar"];//self.tabBar = tabBar;
}

@end
