//
//  CCButton.m
//  Dibaibike
//
//  Created by 陈成 on 2016/10/17.
//  Copyright © 2016年 cn.chengbai.item. All rights reserved.
//

#import "CCButton.h"

@implementation CCButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setUpUI];
        
    }
    
    return self;
}

- (void)setUpUI
{
    [self setImage:[UIImage imageNamed:@"normalBack"] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:@"selectedBack"] forState:UIControlStateHighlighted];

    //self.backgroundColor = [UIColor redColor];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    self.contentEdgeInsets = UIEdgeInsetsMake(0, -(self.frame.size.width), 0, 0);
    
    //self.bounds = CGRectMake(0, 0, 20, 20);
    
    self.imageView.bounds = CGRectMake(0, 0, 16, 16);
}

@end
