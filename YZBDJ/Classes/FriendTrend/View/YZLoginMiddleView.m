//
//  YZLoginMiddleView.m
//  YZBDJ
//
//  Created by lilida on 2018/3/6.
//  Copyright © 2018年 shanyazhou. All rights reserved.
//

#import "YZLoginMiddleView.h"

@interface YZLoginMiddleView()

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;


@end

@implementation YZLoginMiddleView

+ (instancetype)getLoginMiddleView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"YZLoginMiddleView" owner:nil options:nil] firstObject];
}

+ (instancetype)getRegistMiddleView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"YZLoginMiddleView" owner:nil options:nil] lastObject];
}

- (void)awakeFromNib
{
    UIImage *image =  self.loginBtn.currentBackgroundImage;
    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    [self.loginBtn setBackgroundImage:image forState:UIControlStateNormal];
}

@end
