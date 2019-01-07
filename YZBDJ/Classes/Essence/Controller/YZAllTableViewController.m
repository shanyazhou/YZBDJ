//
//  YZAllTableViewController.m
//  YZBDJ
//
//  Created by lilida on 2018/3/26.
//  Copyright © 2018年 shanyazhou. All rights reserved.
//

#import "YZAllTableViewController.h"
#import <AFNetworking.h>
#import "YZTopic.h"
#define refreshViewH 45
@interface YZAllTableViewController ()
@property (assign, nonatomic) BOOL isFooterRefresh;
@property (weak, nonatomic) UIView *footerView;
@property (weak, nonatomic) UILabel *footerLabel;

@property (weak, nonatomic) UIView *refreshView;
@property (weak, nonatomic) UILabel *refreshLabel;
@property (assign, nonatomic) BOOL isHeaderRefresh;

@property (weak, nonatomic) UIView *headerView;

@property (strong, nonatomic) NSMutableArray *topicArray;
@end

@implementation YZAllTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = YZRandomColor;
    self.tableView.contentInset = UIEdgeInsetsMake(35, 0, 0, 0);//35是标题栏的高度
    
    [self getNotification];
    
    [self addFooterView];
    
    [self addHeaderView];
    
    [self addRefreshHeader];
}

- (void)getNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarClick) name:@"TabBarDoubleClickRefresh" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleBtnClick) name:@"TitleBtnDoubleClickRefresh" object:nil];
}

/**假设有一个广告条的headerView*/
- (void)addHeaderView
{
    UIView *headerView = [[UIView alloc] init];
    self.headerView = headerView;
    headerView.frame = CGRectMake(0, 0, YZScreenWidth, 35);
    headerView.backgroundColor = [UIColor blueColor];
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = headerView.bounds;
    label.text = @"广告";
    label.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:label];
    
    self.tableView.tableHeaderView = headerView;
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

/**下拉刷新，不能用tableView的header，因为，好多，header都是用作其他用途的，因此，只能自己单独创建一个*/
- (void)addRefreshHeader
{
    UIView *refreshView = [[UIView alloc] init];
    refreshView.frame = CGRectMake(0, -refreshViewH, YZScreenWidth, refreshViewH);
    refreshView.backgroundColor = [UIColor greenColor];
    
    UILabel *refreshLabel = [[UILabel alloc] init];
    refreshLabel.frame = refreshView.bounds;
    refreshLabel.text = @"下拉进行刷新";
    refreshLabel.textAlignment = NSTextAlignmentCenter;
    [refreshView addSubview:refreshLabel];
    
    self.refreshView = refreshView;
    self.refreshLabel = refreshLabel;
    [self.tableView addSubview:refreshView];
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
    
    [self headerBeginRefresh];
}

- (void)titleBtnClick
{
    [self tabBarClick];
}

#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    self.footerView.hidden = (self.topicArray.count == 0);
    return self.topicArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"ID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    YZTopic *topic = self.topicArray[indexPath.row];
    cell.textLabel.text = topic.text;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

#pragma mark - scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self dealHeaderRefreash];
    
    [self dealFooterLoadMore];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    CGFloat offsetY1 = - (99 + refreshViewH);
    if (scrollView.contentOffset.y < offsetY1) {
        [self headerBeginRefresh];
    }
}

- (void)loadNewData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @"1";
    
    [manager GET:YZCommonURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        YZLog(@"请求成功");
        
        self.topicArray = [YZTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.tableView reloadData];
        [self headerEndRefresh];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        YZLog(@"请求失败");
    }];
    
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.refreshView.backgroundColor = [UIColor greenColor];
//        self.refreshLabel.text = @"下拉进行刷新";
//        self.cellNum += 5;
//        [self.tableView reloadData];
//
//        [self headerEndRefresh];
//    });
}


- (void)loadMoreData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @"1";
    
    [manager GET:YZCommonURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        YZLog(@"请求成功");
        
        NSArray *moreTopicsArray = [YZTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topicArray addObjectsFromArray:moreTopicsArray];
        
        [self.tableView reloadData];
        [self footerEndLoadMore];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        YZLog(@"请求失败");
        [self footerEndLoadMore];
    }];
    
}

/**处理下拉刷新的功能*/
- (void)dealHeaderRefreash
{
    if (self.isHeaderRefresh == YES) return;//如果正在加载，return
    
    /**一开始是向下位移了-99，以为nav是64，标题高是35，加起来正好99*/
    CGFloat offsetY = - (99 + refreshViewH);
    if (self.tableView.contentOffset.y < offsetY) {
        NSLog(@"释放进行刷新");
        self.refreshView.backgroundColor = [UIColor yellowColor];
        self.refreshLabel.text = @"释放进行刷新";
        self.isHeaderRefresh = NO;
    }
    else{
        
        /**往下走，才执行；往上走，不执行*/
        
        NSLog(@"下拉进行刷新...");
        
        
        self.isHeaderRefresh = NO;
        self.refreshView.backgroundColor = [UIColor greenColor];
        self.refreshLabel.text = @"下拉进行刷新";
    }
    
    
}

/**处理上拉加载更多的功能*/
- (void)dealFooterLoadMore
{
    //如果偏移量大于footer的底部，则加载更多
    //如何求 footer底部的坐标？
    if (self.tableView.contentSize.height == 0) return;//如果没有内容，return
    if (self.isFooterRefresh == YES) return;//如果正在加载，return
    CGFloat offsetY = self.tableView.contentSize.height - (self.tableView.yz_height - self.tabBarController.tabBar.yz_height);
    
    if (self.tableView.contentOffset.y > offsetY && self.tableView.contentOffset.y > -99) {
        [self footerBeginLoadMore];
    }
}

- (void)headerBeginRefresh
{
    self.refreshView.backgroundColor = [UIColor redColor];
    self.refreshLabel.text = @"正在刷新中...";
    self.isHeaderRefresh = YES;
    [UIView animateWithDuration:0.25 animations:^{
        UIEdgeInsets inset = self.tableView.contentInset;
        inset.top += self.headerView.yz_height;
        self.tableView.contentInset = inset;//35是标题栏的高度
        
        //修改偏移量
        self.tableView.contentOffset = CGPointMake(self.tableView.contentOffset.x, -inset.top);
    }];
    
    [self loadNewData];
    
    
}

- (void)headerEndRefresh
{
    self.isHeaderRefresh = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.tableView.contentInset = UIEdgeInsetsMake(self.headerView.yz_height, 0, 0, 0);//35是标题栏的高度
    }];
}

- (void)footerBeginLoadMore
{
    self.isFooterRefresh = YES;
    
    self.footerView.backgroundColor = [UIColor blueColor];
    self.footerLabel.text = @"正在加载中...";
    
    [self loadMoreData];
}

- (void)footerEndLoadMore
{
    self.isFooterRefresh = NO;
    self.footerView.backgroundColor = [UIColor redColor];
    self.footerLabel.text = @"上拉加载更多";
}

#pragma mark - 懒加载
- (NSMutableArray *)topicArray
{
    if (_topicArray == nil) {
        _topicArray = [NSMutableArray array];
    }
    return _topicArray;
}
@end
