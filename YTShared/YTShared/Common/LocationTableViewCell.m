//
//  LocationTableViewCell.m
//  Search_Map
//
//  Created by 贝庆 on 16/10/27.
//  Copyright © 2016年 贝庆. All rights reserved.
//

#import "LocationTableViewCell.h"
#import "locModel.h"
@interface LocationTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *distructLabel;
@end

@implementation LocationTableViewCell

- (void)setLocModel:(locModel *)locModel
{
    _locModel = locModel;
    
    self.nameLabel.text = locModel.name;
    self.distructLabel.text = locModel.district;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
