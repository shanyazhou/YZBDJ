//
//  YZAdViewController.m
//  YZBDJ
//
//  Created by lilida on 2018/2/26.
//  Copyright © 2018年 shanyazhou. All rights reserved.
//

#import "YZAdViewController.h"
#import <AFNetworking.h>
#import "YZAdModel.h"
#import "YZTabBarController.h"

@interface YZAdViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *adImage;
@property (weak, nonatomic) IBOutlet UIView *adContainView;
@property (weak, nonatomic) IBOutlet UIButton *jumpBtn;

@property (strong, nonatomic) YZAdModel *adModel;
@property (weak, nonatomic) UIImageView *adImageView;
@property (weak, nonatomic) NSTimer *timer;
@end

/*
 http://mobads.baidu.com/cpro/ui/mads.php?code2=phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam
 **/

@implementation YZAdViewController

#pragma mark - 懒加载
- (UIImageView *)adImageView
{
    if (_adImageView == nil) {
        UIImageView *adImageView = [[UIImageView alloc] init];
        [_adContainView addSubview:adImageView];
        
        adImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
        [adImageView addGestureRecognizer:tap];
        
        _adImageView = adImageView;
    }
    return _adImageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupLaunchImage];
    
    [self loadAdData];
    
//    self.timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerChange) userInfo:nil repeats:YES];
//    [self.timer fire];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerChange) userInfo:nil repeats:YES];
}

- (void)loadAdData
{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    para[@"code2"] = @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam";
    
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager manager] GET:@"http://mobads.baidu.com/cpro/ui/mads.php" parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
//        YZLog(@"%@",responseObject);
        NSDictionary *adDict = [responseObject[@"ad"] lastObject];
        
        if (adDict == nil) {
            return;
        }
        self.adModel = [YZAdModel mj_objectWithKeyValues:adDict];
//        [YZAdModel mj_setKeyValues:adDict]
//        [YZAdModel mj_objectWithKeyValues:adDict];
        self.adImageView.frame = CGRectMake(0, 0, YZScreenWidth, self.adModel.h/self.adModel.w *YZScreenWidth);
//        self.adImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.adModel.w_picurl]]];
        [self.adImageView sd_setImageWithURL:[NSURL URLWithString:self.adModel.w_picurl]];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        YZLog(@"%@",error);
    }];
}

- (void)setupLaunchImage
{
    if (isIphone4s){
        self.adImage.image = [UIImage imageNamed:@"LaunchImage"];
    }else if (isIphone5) {
        self.adImage.image = [UIImage imageNamed:@"LaunchImage-568h"];
    }else if(isIphone6){
        self.adImage.image = [UIImage imageNamed:@"LaunchImage-800-667h"];
    }else{
        self.adImage.image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h"];
    }
    
    [self.jumpBtn addTarget:self action:@selector(jump) forControlEvents:UIControlEventTouchUpInside];
}

- (void)tapClick
{
    /**打开浏览器*/
//    NSURL *url = [NSURL URLWithString:self.adModel.ori_curl];
    
    /**appstore*/
    NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/cn/app/xiao-yang-erdemo-yin-le-xie/id735858889?mt=8"];
    
    /**appstore评论*/
//    NSString * appstoreUrlString = [NSString stringWithFormat:
//                                  @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=735858889"];
//    NSURL* url = [NSURL URLWithString:appstoreUrlString];
    
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}

- (void)timerChange
{
    static int i = 3;
    if(i <= 0)
    {
        [self jump];
    }
    i--;
    NSString *title = [NSString stringWithFormat:@"跳过(%ds)", i];
    [self.jumpBtn setTitle:title forState:UIControlStateNormal];
}

- (void)jump
{
    YZTabBarController *tab = [[YZTabBarController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tab;
    [self.timer invalidate];
}

@end
