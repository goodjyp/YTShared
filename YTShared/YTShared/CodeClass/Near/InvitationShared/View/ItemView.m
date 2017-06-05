//
//  ItemView.m
//  NewTourGroups
//
//  Created by SunShine.Rock on 16/7/5.
//  Copyright © 2016年 Berton. All rights reserved.
//

#import "ItemView.h"

#define IconViewWidth 40
#define IconViewHeight 40

#define TitleLabelHeight 20

@implementation ItemView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width - 40) / 2, 0, IconViewWidth, IconViewHeight)];
        _iconView.layer.cornerRadius = IconViewWidth / 2;
        _iconView.layer.masksToBounds = YES; //没这句话它圆不起来
        [self addSubview:_iconView];
        
        self.titleL = [[UILabel alloc] initWithFrame:CGRectMake(0, IconViewHeight, self.frame.size.width, TitleLabelHeight)];
        _titleL.font = [UIFont systemFontOfSize:15];
        _titleL.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleL];
        
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleClick)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)handleClick {
    if ([self.delegate respondsToSelector:@selector(itemDidCilck:)]) {
        [self.delegate itemDidCilck:self.index];
    }
}

- (void)setSubViewWithImage:(NSString *)imageStr title:(NSString *)title {
    _iconView.image = [UIImage imageNamed:imageStr];
    _titleL.text = title;
}

@end
