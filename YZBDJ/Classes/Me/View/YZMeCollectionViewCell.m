//
//  YZMeCollectionViewCell.m
//  YZBDJ
//
//  Created by lilida on 2018/3/7.
//  Copyright © 2018年 shanyazhou. All rights reserved.
//

#import "YZMeCollectionViewCell.h"

@interface YZMeCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation YZMeCollectionViewCell

- (void)setModel:(YZMeCollectionViewCellModel *)model
{
    _model = model;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.icon]];
    self.nameLabel.text = model.name;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.backgroundColor = [UIColor whiteColor];
}

@end
