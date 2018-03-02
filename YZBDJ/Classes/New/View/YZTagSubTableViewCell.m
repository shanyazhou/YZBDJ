//
//  YZTagSubTableViewCell.m
//  YZBDJ
//
//  Created by lilida on 2018/3/2.
//  Copyright © 2018年 shanyazhou. All rights reserved.
//

#import "YZTagSubTableViewCell.h"
#import "YZTagSubCellModel.h"

@interface YZTagSubTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *themeLabel;
@property (weak, nonatomic) IBOutlet UILabel *subNumLabel;

@end

@implementation YZTagSubTableViewCell

- (void)setTagSubCellModel:(YZTagSubCellModel *)tagSubCellModel
{
    _tagSubCellModel = tagSubCellModel;
    self.themeLabel.text = _tagSubCellModel.theme_name;
    self.subNumLabel.text = [NSString stringWithFormat:@"%ld人订阅", _tagSubCellModel.sub_number];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString * ID = @"tagSubCellID";
    YZTagSubTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[YZTagSubTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}
//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//
//    return self;
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    
    // Initialization code
}

@end
