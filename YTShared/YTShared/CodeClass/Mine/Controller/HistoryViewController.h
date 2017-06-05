//
//  HistoryViewController.h
//  YTShared
//
//  Created by 周江 on 2017/6/2.
//  Copyright © 2017年 ypj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "History_cell.h"
@interface HistoryViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) UITableView *table;
@end
