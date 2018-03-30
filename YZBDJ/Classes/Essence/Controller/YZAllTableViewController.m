//
//  YZAllTableViewController.m
//  YZBDJ
//
//  Created by lilida on 2018/3/26.
//  Copyright © 2018年 shanyazhou. All rights reserved.
//

#import "YZAllTableViewController.h"

@interface YZAllTableViewController ()
@property (assign, nonatomic) BOOL isFooterRefresh;
@property (assign, nonatomic) NSUInteger cellNum;
@property (weak, nonatomic) UIView *footerView;
@property (weak, nonatomic) UILabel *footerLabel;
@end

@implementation YZAllTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = YZRandomColor;
    self.tableView.contentInset = UIEdgeInsetsMake(35, 0, 0, 0);
    
    self.cellNum = 30;
    
    [self getNotification];
    
    [self addFooterView];
}

- (void)getNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarClick) name:@"TabBarDoubleClickRefresh" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleBtnClick) name:@"TitleBtnDoubleClickRefresh" object:nil];
}

- (void)addFooterView
{
    UIView *footerView = [[UIView alloc] init];
    footerView.frame = CGRectMake(0, 0, YZScreenWidth, 35);
    footerView.backgroundColor = [UIColor redColor];
    
    UILabel *footerLabel = [[UILabel alloc] init];
    footerLabel.frame = CGRectMake(0, 0, footerView.yz_width, footerView.yz_height);
    footerLabel.text = @"上拉加载更多";
    footerLabel.textAlignment = NSTextAlignmentCenter;
    footerLabel.textColor = [UIColor blackColor];
    [footerView addSubview:footerLabel];
    
    self.footerView = footerView;
    self.footerLabel = footerLabel;
    self.tableView.tableFooterView = footerView;
}

#pragma mark - dealloc
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - action
- (void)tabBarClick
{
    //YZLog(@"%@,%@,%@",self, self.view, self.view.window);
    //首先，谁都能接收到，因此，必须找到当前显示view刷新
    if (self.view.window == nil) return;//如果不显示，则 self.view.window == nil 重要知识点
    
    //现在能确定是在精华界面，但是不知道是（全部、视频、声音），咋办？
    UIScrollView *scrollView = (UIScrollView *)self.tableView.superview;
    if (scrollView.contentOffset.x/YZScreenWidth == 0) {
        YZLog(@"%@-刷新",self.class);
    }
}

- (void)titleBtnClick
{
    [self tabBarClick];
}

#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.cellNum;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"ID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@--%ld",self.class, indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

#pragma mark - scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    YZLog(@"%f",scrollView.contentOffset.y);
    
    //如果偏移量大于footer的底部，则刷新
    //如何求 footer底部的坐标？

    if (self.tableView.contentSize.height == 0) return;//如果没有内容，不要
    if (self.isFooterRefresh == YES) return;//如果正在刷新，不要
    CGFloat offsetY = self.tableView.contentSize.height - (self.tableView.yz_height - self.tabBarController.tabBar.yz_height);
    if (scrollView.contentOffset.y > offsetY) {
        YZFUNC;
        self.isFooterRefresh = YES;
        
        self.footerView.backgroundColor = [UIColor blueColor];
        self.footerLabel.text = @"正在加载中...";
        
        //模拟加载数据
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            self.cellNum += 5;
            [self.tableView reloadData];
            self.isFooterRefresh = NO;
            self.footerView.backgroundColor = [UIColor redColor];
            self.footerLabel.text = @"上拉加载更多";
        });
        
    }
}
@end
