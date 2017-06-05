//
//  MineVC.m
//  YTShared
//
//  Created by 周江 on 2017/6/1.
//  Copyright © 2017年 ypj. All rights reserved.
//

#import "MineVC.h"

@interface MineVC ()

@end

@implementation MineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //头像
    _btn_tx.clipsToBounds=YES;
    
    
    _btn_tx.layer.cornerRadius = 50;
    _btn_tx.layer.masksToBounds = YES;
    _btn_tx.layer.borderWidth = 2;
    _btn_tx.layer.borderColor = [[UIColor whiteColor]CGColor];
    [_btn_tx addTarget:self action:@selector(btn2:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [_btn_tx setBackgroundImage:[UIImage imageNamed:@"touxi"] forState:UIControlStateNormal];
    //登录后用户名
    _txtFld.text = @"请登录";
    [_txtFld setEnabled: NO];
    [self btn_style];
    
}
#pragma mark --按钮样式
-(void)btn_style{
    
    _btn_li.layer.cornerRadius = 16;
    _btn_li.layer.shadowOffset =  CGSizeMake(1, 1);
    _btn_li.layer.shadowOpacity = 0.5;
    _btn_li.layer.shadowColor =  [UIColor colorForHex:@"AAAAAA"].CGColor;
    
    _btn_li2.layer.cornerRadius = 16;
    _btn_li2.layer.shadowOffset =  CGSizeMake(1, 1);
    _btn_li2.layer.shadowOpacity = 0.5;
    _btn_li2.layer.shadowColor =  [UIColor colorForHex:@"AAAAAA"].CGColor;
    
    _btn_li3.layer.cornerRadius = 16;
    _btn_li3.layer.shadowOffset =  CGSizeMake(1, 1);
    _btn_li3.layer.shadowOpacity = 0.5;
    _btn_li3.layer.shadowColor =  [UIColor colorForHex:@"AAAAAA"].CGColor;
    
    _btn_li4.layer.cornerRadius = 16;
    _btn_li4.layer.shadowOffset =  CGSizeMake(1, 1);
    _btn_li4.layer.shadowOpacity = 0.5;
    _btn_li4.layer.shadowColor =  [UIColor colorForHex:@"AAAAAA"].CGColor;
    
    _btn_li5.layer.cornerRadius = 16;
    _btn_li5.layer.shadowOffset =  CGSizeMake(1, 1);
    _btn_li5.layer.shadowOpacity = 0.5;
    _btn_li5.layer.shadowColor =  [UIColor colorForHex:@"AAAAAA"].CGColor;
    
    _btn_li6.layer.cornerRadius = 16;
    _btn_li6.layer.shadowOffset =  CGSizeMake(1, 1);
    _btn_li6.layer.shadowOpacity = 0.5;
    _btn_li6.layer.shadowColor =  [UIColor colorForHex:@"AAAAAA"].CGColor;
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    
}
#pragma mark --按钮点击事件
- (IBAction)btn2:(UIButton *)sender {
    if (sender.tag==1) {
        The_walletViewController *the = [[The_walletViewController alloc] initWithNibName:@"The_walletViewController" bundle:nil];
        the.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:the animated:YES];
    }else if (sender.tag==2){
        TripViewController *trip= [[TripViewController alloc] initWithNibName:@"TripViewController" bundle:nil];
        trip.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:trip animated:YES];
    }else if (sender.tag==3){
        CreditViewController *cer = [[CreditViewController alloc] initWithNibName:@"CreditViewController" bundle:nil];
        cer.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:cer animated:YES];
    }else if (sender.tag==4){
    }else if (sender.tag==5){
    }else if (sender.tag==6){
    } if (sender.tag==7) {
        [self.navigationController popViewControllerAnimated:NO];
    }
}

@end
