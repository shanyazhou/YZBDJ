//
//  YZAllTableViewController.m
//  YZBDJ
//
//  Created by lilida on 2018/3/26.
//  Copyright © 2018年 shanyazhou. All rights reserved.
//

#import "YZAllTableViewController.h"

@interface YZAllTableViewController ()

@end

@implementation YZAllTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = YZRandomColor;
    self.tableView.contentInset = UIEdgeInsetsMake(35, 0, 0, 0);
    
    [self getNotification];
}

- (void)getNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarClick) name:@"TabBarDoubleClickRefresh" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleBtnClick) name:@"TitleBtnDoubleClickRefresh" object:nil];
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
    return 30;
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



@end
