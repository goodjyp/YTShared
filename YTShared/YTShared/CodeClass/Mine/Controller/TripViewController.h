//
//  TripViewController.h
//  YTShared
//
//  Created by 周江 on 2017/6/2.
//  Copyright © 2017年 ypj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Trip_cell.h"

@interface TripViewController : BaseViewController


@property (nonatomic, strong) UITableView *table;

@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;

@end
