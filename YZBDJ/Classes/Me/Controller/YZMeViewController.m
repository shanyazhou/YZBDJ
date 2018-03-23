//
//  YZMeViewController.m
//  YZBDJ
//
//  Created by lilida on 2018/2/2.
//  Copyright © 2018年 shanyazhou. All rights reserved.
//

#import "YZMeViewController.h"
#import "YZSettingViewController.h"
#import "YZMeCollectionViewCell.h"
#import <AFNetworking.h>
#import "YZMeCollectionViewCellModel.h"
#import "YZWebViewController.h"
#import <SafariServices/SafariServices.h>

@interface YZMeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, SFSafariViewControllerDelegate>
@property (strong, nonatomic) NSMutableArray *collectionCellModelsArray;
@property (weak, nonatomic) UICollectionView *collectionView;
@end

@implementation YZMeViewController

#pragma mark - 懒加载
- (NSMutableArray *)collectionCellModelsArray
{
    if (_collectionCellModelsArray == nil) {
        NSMutableArray *array = [NSMutableArray array];
        _collectionCellModelsArray = array;
    }
    return _collectionCellModelsArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavBar];
    
    [self setupFootView];
    
    [self loadData];
    
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
}

- (void)setupNavBar
{
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-setting-icon"] HighImage:[UIImage imageNamed:@"mine-setting-icon-click"] Target:self action:@selector(settingClick)];
    
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-moon-icon"] SelImage:[UIImage imageNamed:@"mine-moon-icon-click"] Target:self action:@selector(moonClick:)];
    
    self.navigationItem.rightBarButtonItems = @[settingItem, moonItem];
    
    self.navigationItem.title = @"我的";
}

- (void)setupFootView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((YZScreenWidth-3)/4, (YZScreenWidth-3)/4);
    layout.minimumInteritemSpacing = 1;//列间距
    layout.minimumLineSpacing = 1;//行间距
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 300) collectionViewLayout:layout];
    self.collectionView = collectionView;
    collectionView.backgroundColor = self.tableView.backgroundColor;
    //注册cell
    [collectionView registerNib:[UINib nibWithNibName:@"YZMeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"YZMeCollectionViewCellID"];
    collectionView.scrollEnabled = NO;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    self.tableView.tableFooterView = collectionView;
}

- (void)loadData
{
    AFHTTPSessionManager * manage = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"square";
    parameters[@"c"] = @"topic";
    [manage GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        YZLog(@"%@",responseObject);
        
        NSArray *square_listArray = responseObject[@"square_list"];
        self.collectionCellModelsArray = [YZMeCollectionViewCellModel mj_objectArrayWithKeyValuesArray:square_listArray];
        
        self.collectionView.yz_height = (YZScreenWidth-3)/4 * ((self.collectionCellModelsArray.count - 1)/4 + 1);
        
        self.tableView.tableFooterView = self.collectionView;
        [self.collectionView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)moonClick:(UIButton *)btn
{
    btn.selected = !btn.selected;
    YZFUNC;
}

- (void)settingClick
{
    YZFUNC;
    YZSettingViewController *settingVc = [[YZSettingViewController alloc] init];
    settingVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:settingVc animated:YES];
}

#pragma mark - collectionView
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YZMeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YZMeCollectionViewCellID" forIndexPath:indexPath];
    cell.model = self.collectionCellModelsArray[indexPath.item];
    
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.collectionCellModelsArray.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    YZWebViewController *webVc = [[YZWebViewController alloc] init];
//    YZMeCollectionViewCellModel *model = self.collectionCellModelsArray[indexPath.item];
//    webVc.urlString = model.url;
//    webVc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:webVc animated:YES];
    
    YZMeCollectionViewCellModel *model = self.collectionCellModelsArray[indexPath.item];
    if (![model.url containsString:@"http"]) {
        return;
    }
    SFSafariViewController *safariVc = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:model.url]];
//    safariVc.hidesBottomBarWhenPushed = YES;
//    safariVc.delegate = self;
//    self.navigationController.navigationBarHidden = YES;
//    [self.navigationController pushViewController:safariVc animated:YES];
    [self presentViewController:safariVc animated:YES completion:nil];
}

#pragma mark - safariViewControllerDidFinish
- (void)safariViewControllerDidFinish:(SFSafariViewController *)controller
{
    [self.navigationController popViewControllerAnimated:YES];
    self.navigationController.navigationBarHidden = NO;
}
@end
