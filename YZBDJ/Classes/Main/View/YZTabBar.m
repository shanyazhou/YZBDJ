//
//  YZTabBar.m
//  YZBDJ
//
//  Created by lilida on 2018/2/9.
//  Copyright © 2018年 shanyazhou. All rights reserved.
//

#import "YZTabBar.h"

@interface YZTabBar()
@property (weak, nonatomic) UIButton *plusBtn;
@property (weak, nonatomic) UIControl *preTabBar;
@end

@implementation YZTabBar

- (UIButton *)plusBtn
{
    if (_plusBtn == nil ) {
        UIButton *plusBtn = [[UIButton alloc] init];
        [plusBtn setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [plusBtn setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [plusBtn sizeToFit];
        _plusBtn = plusBtn;
        //因为_plusBtn是弱指针，在{}后，plusBtn只有一个弱指针引用，就消失了，因此，必须加上下面的代码
        [self addSubview:plusBtn];
    }
    return _plusBtn;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    NSInteger count = self.items.count + 1;
    CGFloat btnW = self.yz_width / count;
    CGFloat btnH = self.yz_height;
    int i = 0;
    for (UIControl *btn in self.subviews) {//通过这个 YZLog(@"%@",btn.superclass); 知道，btn是UIControl类型的
        if ([btn isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            if (i == 0 && self.preTabBar == nil) {
                self.preTabBar = btn;
            }
            
            if (i == 2) {
                i += 1;
            }
            btn.frame = CGRectMake(i * btnW, 0, btnW, btnH);
            i++;
        }
    }
    self.plusBtn.center = CGPointMake(self.yz_width * 0.5, self.yz_height * 0.5);
}

//尽量不要在这里直接去切换控制器，tabbar的工作量太大，发放下去，谁的事情谁去做
//一对多，用通知
- (void)btnClick:(UIControl *)btn
{
    if (self.preTabBar == btn) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TabBarDoubleClickRefresh" object:self];
    }
    
    self.preTabBar = btn;
}


@end
