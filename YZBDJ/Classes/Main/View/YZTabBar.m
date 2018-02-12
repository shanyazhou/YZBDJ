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
    for (UIView *btn in self.subviews) {
        if ([btn isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            if (i == 2) {
                i += 1;
            }
            btn.frame = CGRectMake(i * btnW, 0, btnW, btnH);
            i++;
        }
    }
    self.plusBtn.center = CGPointMake(self.yz_width * 0.5, self.yz_height * 0.5);
}

@end
