//
//  MenuBarView.m
//  TestWithMenu
//
//  Created by ludongliang on 16/1/5.
//  Copyright © 2016年 ludongliang. All rights reserved.
//

#import "MenuBarView.h"

@interface MenuBarView()

@property (nonatomic) CGFloat gapX;
@property (nonatomic, strong) UIButton *selectButton;
@property (nonatomic, strong) UIView *underLine;

@end

@implementation MenuBarView

- (instancetype)initWithFrame:(CGRect)frame fontSize:(CGFloat)fontSize menuArray:(NSArray *)menuArray {
    self = [super initWithFrame:frame];
    if (self) {
        self.gapX = 10;
        self.mScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _mScrollView.showsHorizontalScrollIndicator = NO;
        self.mScrollView.backgroundColor = [UIColor blackColor];
        [self addSubview:_mScrollView];
        for (int i = 0; i < menuArray.count; i++) {
            NSString *string = menuArray[i];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            if (i == 0) {
                button.frame = CGRectMake(kWidth / 2 - kWidth / 4 - 40, 0, 80, self.frame.size.height);
            } else {
                button.frame = CGRectMake(kWidth / 2 + kWidth / 4 - 40, 0, 80, self.frame.size.height);
            }
            
            self.gapX += string.length * (fontSize + 8 * kCoefficient);
            [button setTitle:menuArray[i] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
            [button addTarget:self action:@selector(handleButton:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = 600 + i;
            
            if (0 == i) {
                [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            } else {
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
            [_mScrollView addSubview:button];
        }
        NSString *firstStr = menuArray[0];
        self.underLine = [[UIView alloc] initWithFrame:CGRectMake(kWidth / 2 - kWidth / 4 - 40, 38, firstStr.length * (fontSize + 8 * kCoefficient), 2)];
        _underLine.backgroundColor = [UIColor orangeColor];
        [_mScrollView addSubview:_underLine];
        _mScrollView.contentSize = CGSizeMake(self.gapX + 10, 40);
    }
    return self;
}


- (void)handleButton:(UIButton *)sender {
    _underLine.frame = CGRectMake(sender.frame.origin.x, 38, sender.frame.size.width, 2);
    
    if (_selectButton != sender) {
        [sender setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [_selectButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    }
    if (sender.tag != 600) {
        UIButton *button = [self viewWithTag:600];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    }
    _selectButton = sender;
    if ([self.delegate respondsToSelector:@selector(clickMenuBarWithIndex:)]) {
        [self.delegate clickMenuBarWithIndex:sender.tag - 600];
    }
}
@end
