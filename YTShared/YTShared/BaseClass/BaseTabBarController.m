//
//  BaseTabBarController.m
//  OTS-V7
//
//  Created by ypj on 15/12/18.
//  Copyright © 2015年 ypj. All rights reserved.
//

#import "BaseTabBarController.h"

@interface BaseTabBarController ()<UITabBarControllerDelegate>{
    //最近一次选择的Index
    NSUInteger _lastSelectedIndex;
}
@property(readonly, nonatomic) NSUInteger lastSelectedIndex;

@end

@implementation BaseTabBarController
@synthesize lastSelectedIndex=_lastSelectedIndex;

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addChildVC:[[NearVC alloc] init] Title:@"附近" ImageName:@"iconMid33.png" SelectedImage:@"iconMid3"];
    [self addChildVC:[[MyMessageVC alloc] init] Title:@"我的消息" ImageName:@"iconMid22.png" SelectedImage:@"iconMid2.png"];
    [self addChildVC:[[LoginViewController alloc] init] Title:@"我的" ImageName:@"iconMid11.png" SelectedImage:@"iconMid1"];
  self.tabBar.tintColor = [UIColor orangeColor];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 64)];
    view.backgroundColor = [UIColor whiteColor];
    [self.tabBar addSubview:view];
    
    self.tabBarController.delegate = self;//代理是否被再次点击

}

- (void)addChildVC:(UIViewController *)childVC Title:(NSString *)Title ImageName:(NSString *)ImageName SelectedImage:(NSString *)SelectedImage
{
    childVC.title = Title;//标题
    childVC.tabBarItem.image = [UIImage imageNamed:ImageName];//默认图标
//     [childVC.tabBarController.tabBarsetSelectedImageTintColor:[UIColor greenColor]];
    childVC.tabBarController.tabBar.barTintColor = [UIColor orangeColor];
    UINavigationController *NAVC = [[UINavigationController alloc] initWithRootViewController:childVC];
    NSDictionary *dic = @{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont boldSystemFontOfSize:20]};
    NAVC.navigationBar.titleTextAttributes = dic;
     NAVC.navigationBar.translucent = NO;
    NAVC.navigationBar.barTintColor = [UIColor blackColor];//nav背景色
    NAVC.navigationBar.tintColor = [UIColor whiteColor];
    [self addChildViewController:NAVC];
}

-(void)setSelectedIndex:(NSUInteger)selectedIndex
{
    //判断是否相等,不同才设置
    if (self.selectedIndex != selectedIndex) {
        //设置最近一次
        _lastSelectedIndex = self.selectedIndex;
        NSLog(@"1 OLD:%lu , NEW:%lu",(unsigned long)self.lastSelectedIndex,(unsigned long)selectedIndex);
    }
    
    //调用父类的setSelectedIndex
    [super setSelectedIndex:selectedIndex];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    //获得选中的item
    NSUInteger tabIndex = [tabBar.items indexOfObject:item];
    if (tabIndex != self.selectedIndex) {
        //设置最近一次变更
        _lastSelectedIndex = self.selectedIndex;
        
        NSLog(@"2 OLD:%lu , NEW:%lu",(unsigned long)self.lastSelectedIndex,(unsigned long)tabIndex);
    }
}
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    return NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
