//
//  CreditViewController.m
//  YTShared
//
//  Created by 周江 on 2017/6/2.
//  Copyright © 2017年 ypj. All rights reserved.
//

#import "CreditViewController.h"

@interface CreditViewController (){
    UIButton * button;
}


@end

@implementation CreditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"信用积分";
    [self addCustomeNavgationBar];
    UIButton *btn =[[UIButton alloc] initWithFrame:CGRectMake(kWidth-50, 20, 44, 44)];
    [btn setTitle:@"历史" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(Cred:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
-(void)Cred:(id)sender{
    HistoryViewController *histro = [[HistoryViewController alloc] initWithNibName:@"HistoryViewController" bundle:nil];
    [self.navigationController pushViewController:histro animated:YES];
}
- (IBAction)Rules:(UIButton *)btn {
    if (btn.tag==20) {
        RulesViewController *rules =[[RulesViewController alloc] initWithNibName:@"RulesViewController" bundle:nil];
        rules.lbl = _gz.titleLabel.text;
        [self.navigationController pushViewController:rules animated:YES];
    }else if (btn.tag==21){
        
        RulesViewController *rules =[[RulesViewController alloc] initWithNibName:@"RulesViewController" bundle:nil];
        rules.lbl = _fm.titleLabel.text;
        [self.navigationController pushViewController:rules animated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
