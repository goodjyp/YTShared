//
//  ShareVC.m
//  YTShared
//
//  Created by ypj on 2017/6/2.
//  Copyright © 2017年 ypj. All rights reserved.
//

#import "ShareVC.h"
#import "ItemView.h"

@interface ShareVC ()<UITextFieldDelegate,ItemViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UITextField *invitionTF;
@property (weak, nonatomic) IBOutlet UILabel *invitionLabel;
@property (nonatomic, assign) NSString *str;


@end

@implementation ShareVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"邀请好友";
    self.submitBtn.layer.cornerRadius = 7;
    _submitBtn.layer.borderWidth = 1;
    _submitBtn.layer.borderColor=[UIColor grayColor].CGColor;
    
    
    [self.view addSubview:self.backView];
    
    
    
    
    if (self.invitionTF.hidden == NO) {
        [_submitBtn addTarget:self action:@selector(submitBtn:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.view addSubview:_submitBtn];
        [self.view addSubview:self.invitionTF];
        
    } else {
        [self inviteSuccess];
        self.submitBtn.hidden = YES;
        self.invitionTF.hidden = YES;
    }
    
    
    
    
    [self shareBtn];
    
}

//提交邀请码按钮
- (void)submitBtn:(UIButton *)sumbitBtn
{
    NSLog(@"%@",_invitionTF.text);
    if ([_invitionTF.text isEqualToString:@"123"]) {
        self.invitionTF.hidden = YES;
        self.submitBtn.hidden = YES;
        [self inviteSuccess];
        [self AddIntegral];
        
    } else {
        NSLog(@"错了");
    }
}

- (void)inviteSuccess
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.invitionLabel.Y_height + 10, kWidth, 30)];
    label.text = @"您已接受XXX的邀请,快去邀请好友吧!";
    label.textColor = [UIColor colorWithRed:99 / 255.0 green:99 / 255.0 blue:99 / 255.0 alpha:1];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview: label];
}

- (void)itemDidCilck:(NSInteger)index
{
    NSLog(@"%ld",(long)index);
    
    
}

- (void)shareBtn
{
    NSArray *btnArr = @[@"微信",@"QQ",@"微博",@"QQ空间",@"朋友圈"];
    NSArray *imgArr = @[@"微信",@"qq",@"微博",@"qq空间",@"朋友圈"];
    CGFloat btnWidth = 60;//高
    CGFloat btnHeight = 50;//宽
    CGFloat horGap = (kWidth - btnWidth * 5) / 7;//横向间隙
    for (int i = 0; i < btnArr.count; i++) {
        int col = i % 5;
        ItemView *view = [[ItemView alloc] initWithFrame:CGRectMake(horGap + col * (horGap + btnWidth), 50, btnWidth, btnHeight)];
        view.delegate = self;
        view.tag = 200 + i;
        view.index = i;
        [view setSubViewWithImage:[NSString stringWithFormat:@"%@",imgArr[i]] title:[NSString stringWithFormat:@"%@",btnArr[i]]];


        [self.backView addSubview:view];
    }
    
}


- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
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
