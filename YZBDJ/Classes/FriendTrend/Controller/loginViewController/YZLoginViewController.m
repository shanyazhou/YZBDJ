//
//  YZLoginViewController.m
//  YZBDJ
//
//  Created by lilida on 2018/3/5.
//  Copyright © 2018年 shanyazhou. All rights reserved.
//

#import "YZLoginViewController.h"
#import "YZLoginButton.h"
#import "YZLoginMiddleView.h"
#import "YZFastLoginView.h"

@interface YZLoginViewController ()
@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *middleViewLeftConstraint;

- (IBAction)closeBtnClick:(UIButton *)sender;
- (IBAction)loginRegistBtnClick:(UIButton *)sender;
@end

@implementation YZLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录注册";
    [self setupMiddleView];
    [self setupBottomView];
}

- (void)setupMiddleView
{
    YZLoginMiddleView *loginMiddleView = [YZLoginMiddleView getLoginMiddleView];
    [self.middleView addSubview:loginMiddleView];
    
    YZLoginMiddleView *registMiddleView = [YZLoginMiddleView getRegistMiddleView];
    [self.middleView addSubview:registMiddleView];
    registMiddleView.yz_x = self.middleView.yz_width * 0.5;
    
}

- (void)setupBottomView
{
    YZFastLoginView *fastLoginView = [YZFastLoginView getFastLoginView];
    [self.bottomView addSubview:fastLoginView];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    YZLoginMiddleView *loginMiddleView = self.middleView.subviews[0];
    loginMiddleView.frame = CGRectMake(0, 0, self.middleView.yz_width * 0.5, self.middleView.yz_height);
    
    YZLoginMiddleView *registMiddleView = self.middleView.subviews[1];
    registMiddleView.frame = CGRectMake(self.middleView.yz_width * 0.5, 0, self.middleView.yz_width * 0.5, self.middleView.yz_height);
    
    YZFastLoginView *fastLoginView = self.bottomView.subviews[0];
    fastLoginView.frame = self.bottomView.bounds;
}

- (IBAction)closeBtnClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)loginRegistBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    if (self.middleViewLeftConstraint.constant == 0) {
        self.middleViewLeftConstraint.constant = -self.middleView.yz_width * 0.5;
    }else{
        self.middleViewLeftConstraint.constant = 0;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
    
}
@end
