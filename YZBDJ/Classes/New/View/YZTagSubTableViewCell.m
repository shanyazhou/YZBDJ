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

//- (void)setFrame:(CGRect)frame
//{
//    frame.size.height -= 1;
//    [super setFrame:frame];
//}

- (void)setTagSubCellModel:(YZTagSubCellModel *)tagSubCellModel
{
    _tagSubCellModel = tagSubCellModel;
    self.themeLabel.text = _tagSubCellModel.theme_name;
    
    if (_tagSubCellModel.sub_number >= 10000) {
        self.subNumLabel.text = [NSString stringWithFormat:@"%.1f万人订阅", _tagSubCellModel.sub_number/10000.0];
    }else{
        self.subNumLabel.text = [NSString stringWithFormat:@"%ld人订阅", _tagSubCellModel.sub_number];
    }

    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:_tagSubCellModel.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString * ID = @"tagSubCellID";
    YZTagSubTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    if (cell == nil) {
//        cell = [[[NSBundle mainBundle] loadNibNamed:@"YZTagSubTableViewCell" owner:nil options:nil] lastObject];
//    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.iconImageView.layer.cornerRadius = 30;
    self.iconImageView.layer.masksToBounds = YES;
    // Initialization code
    
    self.layoutMargins = UIEdgeInsetsZero;
}

@end
