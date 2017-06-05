//
//  MTSearchBar.m
//  Dibaibike
//
//  Created by 贝庆 on 16/10/27.
//  Copyright © 2016年 cn.chengbai.item. All rights reserved.
//

#import "MTSearchBar.h"

@implementation MTSearchBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.size = CGSizeMake(300, 30);
        
        self.font = [UIFont systemFontOfSize:15];
        self.placeholder = @"去哪找我";
        // 提前在Xcode上设置图片中间拉伸
        self.background = [UIImage imageNamed:@"searchbar_textfield_background"];
        
        // 通过init初始化的控件大多都没有尺寸
        UIImageView *searchIcon = [[UIImageView alloc] init];
        searchIcon.image = [UIImage imageNamed:@"navigationbar_search_normal"];
        // contentMode：default is UIViewContentModeScaleToFill，要设置为UIViewContentModeCenter：使图片居中，防止图片填充整个imageView
        searchIcon.contentMode = UIViewContentModeCenter;
        searchIcon.size = CGSizeMake(30, 30);
        
        self.leftView = searchIcon;
        self.leftViewMode = UITextFieldViewModeAlways;
        self.returnKeyType = UIReturnKeyDone;
    }
    return self;
}


//- (void)layoutSubviews
//{
//    
//    
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        self.frame = CGRectMake(30, 5, KSW - 100, 30);
//    });
//    
//    [super layoutSubviews];
//}

+(instancetype)searchBar
{
    return [[self alloc] init];
}


@end
