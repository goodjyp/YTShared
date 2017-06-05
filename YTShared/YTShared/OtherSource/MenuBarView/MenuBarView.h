//
//  MenuBarView.h
//  TestWithMenu
//
//  Created by ludongliang on 16/1/5.
//  Copyright © 2016年 ludongliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MenuBarViewDelegate <NSObject>
- (void)clickMenuBarWithIndex:(NSInteger)index;
@end

@interface MenuBarView : UIView
@property (nonatomic, assign) id<MenuBarViewDelegate>delegate;
@property (nonatomic, strong) UIScrollView *mScrollView;
- (instancetype)initWithFrame:(CGRect)frame fontSize:(CGFloat)fontSize menuArray:(NSArray *)menuArray;
@end
