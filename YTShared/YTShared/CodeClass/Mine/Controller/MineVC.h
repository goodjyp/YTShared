//
//  MineVC.h
//  YTShared
//
//  Created by 周江 on 2017/6/1.
//  Copyright © 2017年 ypj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "The_walletViewController.h"
#import "TripViewController.h"
#import "CreditViewController.h"
@interface MineVC : BaseViewController

@property (weak, nonatomic) IBOutlet UIButton *btn_tx;//头像

@property (weak, nonatomic) IBOutlet UITextField *txtFld;//名称

@property (weak, nonatomic) IBOutlet UIButton *btn_li;
@property (weak, nonatomic) IBOutlet UIButton *btn_li2;
@property (weak, nonatomic) IBOutlet UIButton *btn_li3;
@property (weak, nonatomic) IBOutlet UIButton *btn_li4;
@property (weak, nonatomic) IBOutlet UIButton *btn_li5;
@property (weak, nonatomic) IBOutlet UIButton *btn_li6;
@end
