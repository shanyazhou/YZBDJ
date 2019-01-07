//
//  YZEssenceViewController.m
//  YZBDJ
//
//  Created by lilida on 2018/2/2.
//  Copyright © 2018年 shanyazhou. All rights reserved.
//

#import "YZEssenceViewController.h"
#import "YZAllTableViewController.h"
#import "YZVideoTableViewController.h"
#import "YZVoiceTableViewController.h"
#import "YZImageTableViewController.h"
#import "YZWordTableViewController.h"

#define titleViewH 35

@interface YZEssenceViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) UIScrollView *scrollView;
@property (weak, nonatomic) UIView *titleView;
@property (weak, nonatomic) UIButton *preTitleBtn;
@property (weak, nonatomic) UIView *line;
@end

@implementation YZEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupScrollView];
    
    [self setupTitleView];
    
    [self setupChildsVc];
    
    //添加第0个控制器
    [self addChildViewIntoScrollView:0];
}

- (void)setupNav
{
    self.view.backgroundColor = [UIColor redColor];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"nav_item_game_icon"] HighImage:[UIImage imageNamed:@"nav_item_game_click_icon"] Target:self action:@selector(gameClick)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"navigationButtonRandom"] HighImage:[UIImage imageNamed:@"navigationButtonRandomClick"] Target:self action:@selector(randomClick)];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
}

- (void)setupScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = CGRectMake(0, 0, YZScreenWidth, YZScreenHeight);
    scrollView.pagingEnabled = YES;
//    scrollView.backgroundColor = [UIColor greenColor];
    scrollView.contentSize = CGSizeMake(5 * YZScreenWidth, 0);
    scrollView.delegate = self;
    self.scrollView = scrollView;
    [self.view addSubview:scrollView];
}

- (void)setupTitleView
{
    UIView *titleView = [[UIView alloc] init];
    titleView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    titleView.frame = CGRectMake(0, 64, YZScreenWidth, titleViewH);
    [self.view addSubview:titleView];
    self.titleView = titleView;
    [self setupTitleBtn];
}

- (void)setupTitleBtn
{
    NSArray *titleBtnNameArray = @[@"全部", @"视频", @"声音", @"图片", @"段子"];
    NSInteger count = titleBtnNameArray.count;
    CGFloat titleBtnW = YZScreenWidth / count;
    CGFloat titleBtnH = self.titleView.yz_height - 2;
    CGFloat titleBtnY = 0;
    for (int i = 0; i<count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.tag = i+1;//因为view的tag默认是0，因此，tag尽量不要以0开始
        btn.font = [UIFont systemFontOfSize:16];
        btn.frame = CGRectMake(i * titleBtnW, titleBtnY, titleBtnW, titleBtnH);
        [btn setTitle:titleBtnNameArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titleView addSubview:btn];
    }
    
    [self setupUnderLine];
    
    //把第一个按钮选中
    UIButton *firstBtn = self.titleView.subviews[0];
    firstBtn.selected = YES;
    self.preTitleBtn = firstBtn;

    self.line.yz_width = [firstBtn.currentTitle sizeWithFont:firstBtn.font].width + 10;
    self.line.yz_centerX = firstBtn.yz_centerX;
}

- (void)setupUnderLine
{
    UIView *line = [[UIView alloc] init];
    UIButton *btn = self.titleView.subviews[0];
    CGFloat lineH = 2;
    line.frame = CGRectMake(0, self.titleView.yz_height - lineH, YZScreenWidth/5, lineH);
    line.backgroundColor = [btn titleColorForState:UIControlStateSelected];
    self.line = line;
    [self.titleView addSubview:line];
}


- (void)setupChildsVc
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    YZAllTableViewController *allVc = [[YZAllTableViewController alloc] init];
    [self addChildViewController:allVc];
    
    YZVideoTableViewController *videoVc = [[YZVideoTableViewController alloc] init];
    [self addChildViewController:videoVc];
    
    YZVoiceTableViewController *voiceVc = [[YZVoiceTableViewController alloc] init];
    [self addChildViewController:voiceVc];
    
    YZImageTableViewController *imageVc = [[YZImageTableViewController alloc] init];
    [self addChildViewController:imageVc];
    
    YZWordTableViewController *wordlVc = [[YZWordTableViewController alloc] init];
    [self addChildViewController:wordlVc];
    
//    for (int i = 0; i<5; i++) {
//        UIView *childView = self.childViewControllers[i].view;
//        childView.frame = CGRectMake(i * YZScreenWidth, 0, YZScreenWidth, YZScreenHeight);
//        [self.scrollView addSubview:childView];
//    }
}

#pragma mark - action
- (void)titleBtnClick:(UIButton *)btn
{
    if (self.preTitleBtn == btn) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TitleBtnDoubleClickRefresh" object:self];
    }
    
    btn.selected = !btn.selected;
    self.preTitleBtn.selected = !btn.selected;
    self.preTitleBtn = btn;
    
    NSUInteger index = btn.tag - 1;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.line.yz_width = [btn.currentTitle sizeWithFont:btn.font].width + 10;
        self.line.yz_centerX = btn.yz_centerX;
    } completion:^(BOOL finished) {
        [self addChildViewIntoScrollView:index];
    }];
    
    
    //tableView与标题的联动
    for (int i = 0; i<5; i++) {
        if (btn.tag == i+1) {
            [UIView animateWithDuration:0.3 animations:^{
                self.scrollView.contentOffset = CGPointMake(i*YZScreenWidth, 0);
            }];
        }
    }
}

- (void)gameClick
{
    YZFUNC;
}

- (void)randomClick
{
    YZFUNC;
}

- (void)addChildViewIntoScrollView:(NSUInteger)index
{
    UIView *childView = self.childViewControllers[index].view;
    childView.frame = CGRectMake(index * YZScreenWidth, 0, YZScreenWidth, YZScreenHeight);
    [self.scrollView addSubview:childView];
}

#pragma mark - scrollViewDelegate
//scrollView结束减速，即，真正的停止
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //偏移量/屏幕宽度=第几个按钮
    NSInteger i = self.scrollView.contentOffset.x/YZScreenWidth;
    
    UIButton *btn = self.titleView.subviews[i];
    
    [self titleBtnClick:btn];
}


@end
