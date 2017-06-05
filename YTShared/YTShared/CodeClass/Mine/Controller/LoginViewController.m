//
//  LoginViewController.m
//  YTShared
//
//  Created by 周江 on 2017/6/2.
//  Copyright © 2017年 ypj. All rights reserved.
//

#import "LoginViewController.h"
//#import "AtuoFillScreenUtils.h"
@interface LoginViewController ()<UITextFieldDelegate> {
    NSString    *previousTextFieldContent;
    UITextRange *previousSelection;
}


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    [AtuoFillScreenUtils autoLayoutFillScreen:self.view];
    //    updateViewsFrame
    
    
    
    self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"timg"]];
    self.navigationController.delegate = self;
    
    [self.ime setUserInteractionEnabled:NO];
    
    self.denlgu.layer.cornerRadius = 10;
    //    self.btnb.layer.masksToBounds = YES;
    [self.denlgu addTarget:self action:@selector(setBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.btnb.layer.cornerRadius = 50;
    self.btnb.layer.masksToBounds = YES;
    //    self.btnb.layer.borderWidth = 2;
    self.btnb.layer.borderColor = [[UIColor whiteColor]CGColor];
    [self.btnb setBackgroundImage:[UIImage imageNamed:@"touxi"] forState:UIControlStateNormal];
    [self.btnb addTarget:self action:@selector(setBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    self.tel.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入手机号" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    self.tel.delegate = self;
    [self.tel addTarget:self action:@selector(formatPhoneNumber:) forControlEvents:UIControlEventEditingChanged];
    
    
    
    self.tl_yzm.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入验证码" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    self.tl_yzm.tag =2;
    self.tl_yzm.delegate = self;
    
    //    self.yzm =  [UIButton buttonWithType:UIButtonTypeCustom];
    [self.yzm addTarget:self action:@selector(open) forControlEvents:UIControlEventTouchUpInside];
    self.yzm.layer.cornerRadius=10;
    
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
}
-(void)open{
    //    if ([[self.tel.text isEqualToString:@""] || self.tel.text == nil]) {
    ////        [UIAlertView alertViewWithTitle:@"友情提示" message:@"请输入手机号码" cancelButtonTitle:@"好的"];
    //    }else{
    //        [self openCountdown];
    //    }
    if ([self.tel.text isEqualToString:@""]) {
        UIAlertView *al = [[UIAlertView  alloc] initWithTitle:@"请输入手机号码" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [al show];
    } else {
        [self openCountdown];
    }
}
-(void)setBtn:(UIButton *)btn{
    if (btn.tag==1) {
        
    }if (btn.tag==2) {
        MineVC *min = [[MineVC alloc] initWithNibName:@"MineVC" bundle:nil];
        
        [self.navigationController pushViewController:min animated:YES];
        
        // [self jiexi];
    } else {
        DLog(@"出来");
    }
}
#pragma mark --开始解析
-(void)jiexi{
    [SVProgressHUD showWithStatus:@"加载中"];
    [LORequestManger GET1:@"http://www.bqbike.com/Dibike/member/login.action"
               parameters:@{@"code":@"7310",@"mark":@"b229052d95ab4defa07c75bcc6f18369",@"phone":@"18323717069"}
                  success:^(id responseObject){
                      DLog(@"《《《《《《《《《《《《《《《%@",responseObject);
                      [SVProgressHUD dismiss];
                  } failure:^(NSError *error) {
                      DLog(@"失败");
                  }];
}
// 开启倒计时效果
-(void)openCountdown{
    
    __block NSInteger time = 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
                [self.yzm setTitle:@"重新发送" forState:UIControlStateNormal];
                [self.yzm setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                self.yzm.userInteractionEnabled = YES;
            });
            
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [self.yzm setTitle:[NSString stringWithFormat:@"%.2ds", seconds] forState:UIControlStateNormal];
                [self.yzm setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                self.yzm.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}

- (void)formatPhoneNumber:(UITextField*)textField
{
    NSUInteger targetCursorPosition =
    [textField offsetFromPosition:textField.beginningOfDocument
                       toPosition:textField.selectedTextRange.start];
    NSLog(@"targetCursorPosition:%li", (long)targetCursorPosition);
    // nStr表示不带空格的号码
    NSString* nStr = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString* preTxt = [previousTextFieldContent stringByReplacingOccurrencesOfString:@" "
                                                                           withString:@""];
    
    char editFlag = 0;// 正在执行删除操作时为0，否则为1
    
    if (nStr.length <= preTxt.length) {
        editFlag = 0;
    }
    else {
        editFlag = 1;
    }
    
    // textField设置text
    if (nStr.length > 11)
    {
        textField.text = previousTextFieldContent;
        textField.selectedTextRange = previousSelection;
        return;
    }
    
    // 空格
    NSString* spaceStr = @" ";
    
    NSMutableString* mStrTemp = [NSMutableString new];
    int spaceCount = 0;
    if (nStr.length < 3 && nStr.length > -1)
    {
        spaceCount = 0;
    }else if (nStr.length < 7 && nStr.length >2)
    {
        spaceCount = 1;
        
    }else if (nStr.length < 12 && nStr.length > 6)
    {
        spaceCount = 2;
    }
    
    for (int i = 0; i < spaceCount; i++)
    {
        if (i == 0) {
            [mStrTemp appendFormat:@"%@%@", [nStr substringWithRange:NSMakeRange(0, 3)], spaceStr];
        }else if (i == 1)
        {
            [mStrTemp appendFormat:@"%@%@", [nStr substringWithRange:NSMakeRange(3, 4)], spaceStr];
        }else if (i == 2)
        {
            [mStrTemp appendFormat:@"%@%@", [nStr substringWithRange:NSMakeRange(7, 4)], spaceStr];
        }
    }
    
    if (nStr.length == 11)
    {
        [mStrTemp appendFormat:@"%@%@", [nStr substringWithRange:NSMakeRange(7, 4)], spaceStr];
    }
    
    if (nStr.length < 4)
    {
        [mStrTemp appendString:[nStr substringWithRange:NSMakeRange(nStr.length-nStr.length % 3,
                                                                    nStr.length % 3)]];
    }else if(nStr.length > 3)
    {
        NSString *str = [nStr substringFromIndex:3];
        [mStrTemp appendString:[str substringWithRange:NSMakeRange(str.length-str.length % 4,
                                                                   str.length % 4)]];
        if (nStr.length == 11)
        {
            [mStrTemp deleteCharactersInRange:NSMakeRange(13, 1)];
        }
    }
    NSLog(@"=======mstrTemp=%@",mStrTemp);
    
    textField.text = mStrTemp;
    // textField设置selectedTextRange
    NSUInteger curTargetCursorPosition = targetCursorPosition;// 当前光标的偏移位置
    if (editFlag == 0)
    {
        //删除
        if (targetCursorPosition == 9 || targetCursorPosition == 4)
        {
            curTargetCursorPosition = targetCursorPosition - 1;
        }
    }
    else {
        //添加
        if (nStr.length == 8 || nStr.length == 3)
        {
            curTargetCursorPosition = targetCursorPosition + 1;
        }
    }
    
    UITextPosition *targetPosition = [textField positionFromPosition:[textField beginningOfDocument]
                                                              offset:curTargetCursorPosition];
    [textField setSelectedTextRange:[textField textRangeFromPosition:targetPosition
                                                         toPosition :targetPosition]];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag==2) {
        
        if (range.location >=4) {
            return NO;
        }
    }else{
        previousTextFieldContent = textField.text;
        previousSelection = textField.selectedTextRange;
    }
    return YES;
}
@end
