//
//  TripViewController.m
//  YTShared
//
//  Created by 周江 on 2017/6/2.
//  Copyright © 2017年 ypj. All rights reserved.
//

#import "TripViewController.h"

@interface TripViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation TripViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的行程";
    [self addCustomeNavgationBar];
    
    
    self.btn1.layer.cornerRadius = 33/2;
    self.btn1.layer.shadowOffset =  CGSizeMake(1, 1);
    self.btn2.layer.cornerRadius = 33/2;
    self.btn2.layer.shadowOffset =  CGSizeMake(1, 1);
    
    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, 111, kWidth, kHeight-111) style:UITableViewStylePlain];
    self.table.dataSource = self;
    self.table.delegate  = self;
    [self.table registerNib:[UINib nibWithNibName:@"Trip_cell" bundle:nil] forCellReuseIdentifier:@"Trip_cell"];
    self.table.backgroundColor = [UIColor colorForHex:@"EEEEF0"];
    self.table.separatorStyle= UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.table];
    
    [self.btn1 addTarget:self action:@selector(setBtn1) forControlEvents:UIControlEventTouchUpInside];
    [self.btn2 addTarget:self action:@selector(setBtn2) forControlEvents:UIControlEventTouchUpInside];
}
-(void)setBtn1{
    self.btn2.backgroundColor= [UIColor whiteColor];
    self.btn1.backgroundColor =[UIColor grayColor];
}
-(void)setBtn2{
    self.btn1.backgroundColor= [UIColor whiteColor];
    self.btn2.backgroundColor =[UIColor grayColor];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 106;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Trip_cell *cell = [self.table dequeueReusableCellWithIdentifier:@"Trip_cell"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;//设置cell点击效果
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
