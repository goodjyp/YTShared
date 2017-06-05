//
//  ItemView.h
//  NewTourGroups
//
//  Created by SunShine.Rock on 16/7/5.
//  Copyright © 2016年 Berton. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ItemViewWidth [UIScreen mainScreen].bounds.size.width / 5
#define ItemViewHeight 70


@protocol ItemViewDelegate <NSObject>
- (void)itemDidCilck:(NSInteger)index;
@end

@interface ItemView : UIView
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *titleL;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) id <ItemViewDelegate> delegate;
- (void)setSubViewWithImage:(NSString *)imageStr title:(NSString *)title;
@end
