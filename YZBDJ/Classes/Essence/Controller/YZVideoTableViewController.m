//
//  YZVideoTableViewController.m
//  YZBDJ
//
//  Created by lilida on 2018/3/26.
//  Copyright © 2018年 shanyazhou. All rights reserved.
//

#import "YZVideoTableViewController.h"

@interface YZVideoTableViewController ()

@end

@implementation YZVideoTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = YZRandomColor;
    
    
    self.tableView.contentInset = UIEdgeInsetsMake(35, 0, 0, 0);
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
