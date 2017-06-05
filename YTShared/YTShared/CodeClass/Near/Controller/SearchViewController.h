//
//  SearchViewController.h
//  Dibaibike
//
//  Created by 陈成 on 2016/10/18.
//  Copyright © 2016年 cn.chengbai.item. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>

@class NearVC;
@interface SearchViewController : UIViewController

@property (nonatomic , strong)AMapSearchAPI *search;

@property (copy , nonatomic)NSString *address;

@property (weak,nonatomic)NearVC *homeVc;



@end
