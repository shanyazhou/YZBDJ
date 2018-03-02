//
//  YZTagSubTableViewCell.h
//  YZBDJ
//
//  Created by lilida on 2018/3/2.
//  Copyright © 2018年 shanyazhou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YZTagSubCellModel;
@interface YZTagSubTableViewCell : UITableViewCell
@property (strong, nonatomic) YZTagSubCellModel *tagSubCellModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
