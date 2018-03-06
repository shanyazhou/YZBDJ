//
//  YZTagSubViewController.m
//  YZBDJ
//
//  Created by lilida on 2018/3/2.
//  Copyright © 2018年 shanyazhou. All rights reserved.
//

#import "YZTagSubViewController.h"
#import <AFNetworking.h>
#import "YZTagSubCellModel.h"
#import "YZTagSubTableViewCell.h"
#import <SVProgressHUD.h>

@interface YZTagSubViewController ()
@property (strong, nonatomic) NSMutableArray *tagSubArray;
@end

@implementation YZTagSubViewController

#pragma mark - 懒加载
- (NSMutableArray *)tagSubArray
{
    if (_tagSubArray == nil) {
        NSMutableArray *tagSubArray = [NSMutableArray array];
        _tagSubArray = tagSubArray;
    }
    return _tagSubArray;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    
    /**方法三：*/
    [self.tableView registerNib:[UINib nibWithNibName:@"YZTagSubTableViewCell" bundle:nil] forCellReuseIdentifier:@"tagSubCellID"];
    
    //错误写法。NIB不是bundle
//    [self.tableView registerNib:[[NSBundle mainBundle] loadNibNamed:@"YZTagSubTableViewCell" owner:nil options:nil][0] forCellReuseIdentifier:@"tagSubCellID"];
    
    self.title = @"推荐标签";
    
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.separatorInset = UIEdgeInsetsZero;
    
//    self.tableView.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0  blue:220/255.0  alpha:1];
}

- (void)loadData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"tag_recommend";
    parameters[@"action"] = @"sub";
    parameters[@"c"] = @"topic";
    
    [SVProgressHUD showWithStatus:@"正在加载中..."];
    
    [manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        YZLog(@"%@",responseObject);
        
        _tagSubArray = [YZTagSubCellModel mj_objectArrayWithKeyValuesArray:responseObject];
        
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        YZLog(@"%@",error);
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tagSubArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /**方法一：*/
//    static NSString * ID = @"tagSubCellID";
//    YZTagSubTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
////    if (cell == nil) {
////        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([YZTagSubTableViewCell class]) owner:nil options:nil][0];
////    }
//    YZTagSubCellModel *tagSubCellModel = self.tagSubArray[indexPath.row];
//    cell.tagSubCellModel = tagSubCellModel;
//    return cell;
    
    /**方法二：*/
    YZTagSubTableViewCell *cell = [YZTagSubTableViewCell cellWithTableView:tableView];
    YZTagSubCellModel *tagSubCellModel = self.tagSubArray[indexPath.row];
    cell.tagSubCellModel = tagSubCellModel;
    return cell;
}


@end
