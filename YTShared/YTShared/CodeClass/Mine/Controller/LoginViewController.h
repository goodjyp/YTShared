//
//  LoginViewController.h
//  YTShared
//
//  Created by 周江 on 2017/6/2.
//  Copyright © 2017年 ypj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MineVC.h"

@interface LoginViewController : BaseViewController



@property(weak, nonatomic) IBOutlet  UIButton *ime;

@property(weak, nonatomic) IBOutlet UIButton *btnb;


@property (weak, nonatomic) IBOutlet UIButton *denlgu;
@property (weak, nonatomic) IBOutlet UIButton *yzm;

@property(weak ,nonatomic) IBOutlet UITextField *tel;
@property(weak ,nonatomic) IBOutlet UITextField *tl_yzm;
@end
