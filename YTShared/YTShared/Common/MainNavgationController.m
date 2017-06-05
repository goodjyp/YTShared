//
//  MainNavgationController.m
//  Dibaibike
//
//  Created by 陈成 on 2016/10/17.
//  Copyright © 2016年 cn.chengbai.item. All rights reserved.
//

#import "MainNavgationController.h"
#import "UIViewController+MMDrawerController.h"
#import "UIView+Extension.h"
#import "CCButton.h"
#import "AppDelegate.h"

#import "NearVC.h"
#import "SearchViewController.h"
//#import "RechargeViewController.h"//支付控制器
//#import "CyclingEndViewController.h"
//#import "ReportController.h"//投诉举报控制器
//#import "FaultController.h"






@interface MainNavgationController ()

@property (strong , nonatomic)UIViewController *vc;
@end

@implementation MainNavgationController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self view];

}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    if (self = [super initWithRootViewController:rootViewController]) {
        
        CCButton *button = [CCButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(goToRootView) forControlEvents:UIControlEventTouchUpInside];
        
        button.size = CGSizeMake(60, 20);
        
        rootViewController.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc] initWithCustomView:button];
        
    }
    return self;
}

- (void)goToRootView
{
//    [ShareApp.drawerController setCenterViewController:ShareApp.centerNav withCloseAnimation:YES completion:nil];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
        self.vc = viewController;
        if(self.childViewControllers.count > 0 )
    {
        
        CCButton *button = [CCButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
        if ([viewController isKindOfClass:NSClassFromString(@"SearchViewController")]) {
            button.size  = CGSizeMake(30, 20);
        }else
        {
            button.size = CGSizeMake(100, 40);
        }
       
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        
    }

    [super pushViewController:viewController animated:animated];
}

- (void)goBack
{
//    self.mm_drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
//   
//    if([self.vc isKindOfClass:[RechargeViewController class]])
//    {
//        [self.vc.navigationController popToRootViewControllerAnimated:YES];
//          self.vc = nil;
//        return;
//    }
//    
//     [self.vc.view endEditing:YES];
//    
//     [self popViewControllerAnimated:YES];

}




- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}



@end
