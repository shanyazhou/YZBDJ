//
//  YZAdViewController.m
//  YZBDJ
//
//  Created by lilida on 2018/2/26.
//  Copyright © 2018年 shanyazhou. All rights reserved.
//

#import "YZAdViewController.h"

@interface YZAdViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *adImage;
@property (weak, nonatomic) IBOutlet UIButton *jumpBtn;

@end

@implementation YZAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

- (void)jump
{
    YZFUNC;
}

@end
