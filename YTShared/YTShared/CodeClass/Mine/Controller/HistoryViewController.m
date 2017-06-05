//
//  HistoryViewController.m
//  YTShared
//
//  Created by 周江 on 2017/6/2.
//  Copyright © 2017年 ypj. All rights reserved.
//

#import "HistoryViewController.h"

@interface HistoryViewController ()

@end

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"历史";
    [self addCustomeNavgationBar];
    
    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kWidth, kHeight-64)];
    self.table.dataSource = self;
    self.table.delegate = self;
    self.table.separatorStyle= UITableViewCellSeparatorStyleNone;
    [self.table registerNib:[UINib nibWithNibName:@"History_cell" bundle:nil] forCellReuseIdentifier:@"History_cell"];
    [self.view addSubview:self.table];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    History_cell *cell = [self.table dequeueReusableCellWithIdentifier:@"History_cell"];
    cell.selectionStyle= UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
