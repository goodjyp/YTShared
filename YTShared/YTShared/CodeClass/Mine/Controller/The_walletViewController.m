//
//  The_walletViewController.m
//  YTShared
//
//  Created by 周江 on 2017/6/2.
//  Copyright © 2017年 ypj. All rights reserved.
//

#import "The_walletViewController.h"

@interface The_walletViewController ()

@end

@implementation The_walletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"我的钱包";
    [self addCustomeNavgationBar];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(kWidth-60, 20, 44, 44)];
    [btn setTitle:@"明细" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(detail:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
-(void)detail:(id)sender{
    NSLog(@"明细");
}
- (IBAction)topup:(UIButton *)btn {
    if (btn.tag==9) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"退押金需要2-7个工作日，期间不能用车，确定退押金？" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"取消");
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"确定");
        }]];
        
        [self presentViewController:alert animated:true completion:nil];
        
    }else if (btn.tag==10) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请先支付押金。。。" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }
}

@end
