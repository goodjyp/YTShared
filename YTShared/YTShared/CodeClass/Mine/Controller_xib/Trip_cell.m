//
//  Trip_cell.m
//  YTShared
//
//  Created by 周江 on 2017/6/2.
//  Copyright © 2017年 ypj. All rights reserved.
//

#import "Trip_cell.h"

@implementation Trip_cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _btn.layer.cornerRadius = 5;
    _btn.layer.shadowOffset =  CGSizeMake(1, 1);
    _btn.layer.shadowOpacity = 0.5;
    _btn.layer.shadowColor =  [UIColor colorForHex:@"AAAAAA"].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
