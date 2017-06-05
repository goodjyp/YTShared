//
//  BaseViewController.h
//  e-contract-iPhone
//
//  Created by ludongliang on 15/12/24.
//  Copyright © 2015年 ludongliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

- (void)addProgress;
- (void)deleteProgress;
- (void)AddIntegral;//邀请成功提示信用积分加1

/**
 *  添加自定义导航
 */
- (void)addCustomeNavgationBar;
@end
