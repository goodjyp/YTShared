//
//  BaseViewController.m
//  e-contract-iPhone
//
//  Created by ludongliang on 15/12/24.
//  Copyright © 2015年 ludongliang. All rights reserved.
//

#import "BaseViewController.h"
#import "AppDelegate.h"
#define kNavgationBarHeight         64
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kBackgroundColor;
//只要返回箭头 不要文字
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backBtn;
    
    //添加键盘处理事件
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]
                                                    initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    if ([self respondsToSelector:@selector(keyboardHide:)]) {
        [self.view addGestureRecognizer:tapGestureRecognizer];
    }
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [self.view endEditing:YES];
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
     self.navigationController.delegate = self;
    //方便调试定位问题，打印当前类
    NSLog(@"--------->>>>>>>>> %@ <<<<<<<<<---------",NSStringFromClass([self class]));
}

//- (void)handleLeftBarButton:(UIBarButtonItem *)sender {
//    [self.navigationController popViewControllerAnimated:YES];
//}

- (void)addProgress {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
//    hud.labelText = @"加载中...";
    hud.labelText = @"加载中";
}
- (void)deleteProgress {
    //删除风火轮
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)AddIntegral
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.color = [UIColor grayColor];
    hud.yOffset = 120;
    hud.labelText = @"您的信用积分增加1分";
    [hud hide:YES afterDelay:1];
}

#pragma mark - UINavigationControllerDelegate
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 自定义导航
- (void)addCustomeNavgationBar{
    
    UIView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kNavgationBarHeight)];
    view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:view];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setFrame:CGRectMake(0, 20, 44, 44)];
    [backBtn setImage:[UIImage imageNamed:@"Back-icon-"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(searion) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 20, kWidth - 100, 44)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor  colorForHex:@"eb6100"];
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    titleLabel.text = self.title;
    [self.view addSubview:titleLabel];
}
#pragma mark - 导航返回事件，子类如需自己返回重写此方法
- (void)searion{
    
    [self.navigationController popViewControllerAnimated:YES];
}
CG_INLINE CGRect
TS_CGRectMake(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    CGRect rect;
    rect.origin.x = x * myDelegate.autoSizeScaleX;
    rect.origin.y = y * myDelegate.autoSizeScaleY;
    rect.size.width = width * myDelegate.autoSizeScaleX;
    rect.size.height = height * myDelegate.autoSizeScaleY;
    return rect;
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
