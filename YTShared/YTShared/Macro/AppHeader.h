//
//  AppHeader.h
//  OTS-V7
//
//  Created by ypj on 15/12/18.
//  Copyright © 2015年 ypj. All rights reserved.
//

#ifndef AppHeader_h
#define AppHeader_h

/********************** 注册微信支付相关参数 *****************************/
// 开放平台登录https://open.weixin.qq.com的开发者中心获取APPID
#define WX_APPID @"wxed27ad86265f5b7a"
// 开放平台登录https://open.weixin.qq.com的开发者中心获取AppSecret。
#define WX_APPSecret @"1c7592c5b58d7e7956c64c520dda573b"
// 微信支付商户号
#define MCH_ID  @"1415626102"
// 安全校验码（MD5）密钥，商户平台登录账户和密码登录http://pay.weixin.qq.com 平台设置的“API密钥”，为了安全，请设置为以数字和字母组成的32字符串。
#define WX_PartnerKey @"uFc5FPJAqG3lSn9aABggvd7jgio4amW5"
//RSA加密
#define rsaStr @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDGaeXY1/bTQ/exo57QGqZ30FNVsaPKyz1SJtjVj+5gYs0ml9YGqzXm2Y3xtR9q2xkdO5TKMkDeL95Lidp49RAOMC8/105LkyESwZVVAWB8GKS5RbCi7chbct0alYT2eSJkI9ihEc8aouQ2/P5+sGUUqzVPe/n+bs7fTlL4OJV/bQIDAQAB"
/** 获取微信支付参数 **/
#define WX_PAY [NSString stringWithFormat:@"http://%@/pay%@",ONLINE,ACTION]  // 微信支付

#pragma mark - 统一下单请求参数键值

//  应用id
#define WXAPPID @"appid"
//  商户号
#define WXMCHID @"mch_id"
//  随机字符串
#define WXNONCESTR @"nonce_str"
//  签名
#define WXSIGN @"sign"
//  商品描述
#define WXBODY @"body"
//  商户订单号
#define WXOUTTRADENO @"out_trade_no"
//  总金额
#define WXTOTALFEE @"total_fee"
//  终端IP
#define WXEQUIPMENTIP @"spbill_create_ip"
//  通知地址
#define WXNOTIFYURL @"notify_url"
//  交易类型
#define WXTRADETYPE @"trade_type"
//  预支付交易会话
#define WXPREPAYID @"prepay_id"

#pragma mark - 微信下单接口

/** 微信统一下单接口连接 */
#define WXUNIFIEDORDERURL @"https://api.mch.weixin.qq.com/pay/unifiedorder"
/** 微信退款接口  */
#define WXREFUND_URL @"https://api.mch.weixin.qq.com/secapi/pay/refund";
/********************** 注册微信支付相关参数 *****************************/

/** 单点登录 **/
#define ONLY_LOGIN [NSString stringWithFormat:@"http://%@/SSO%@",ONLINE,ACTION]  // 单点登录

/** 退出登录 **/
#define LogOut [NSString stringWithFormat:@"http://%@/LogOff%@",ONLINE,ACTION]  // 退出登录






#ifdef DEBUG
#define XXLog(...) NSLog(__VA_ARGS__)
#else
#define XXLog(...)
#endif

#define kKeyWindow [UIApplication sharedApplication].keyWindow
#define XXLogFunc XMGLog(@"%s", __func__)
//屏幕宽高
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
#define kCoefficient [UIScreen mainScreen].bounds.size.width / 320
//背景色
#define kBackColor [UIColor colorWithRed:16 / 255.0 green:124 / 255.0 blue:187 / 255.0 alpha:1]

//选中颜色
#define kSelectColor [UIColor colorWithRed:38 / 255.0 green:220 / 255.0 blue:226 / 255.0 alpha:1]

#define kBackgroundColor [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1]
//线路字体颜色
#define kFontColor [UIColor colorWithRed:16 / 255.0 green:130 / 255.0 blue:230 / 255.0 alpha:1]
//字体颜色
#define kTextColor [UIColor colorWithRed:39 / 255.0 green:227 / 255.0 blue:233 / 255.0 alpha:1]

#define MyAlertView(errorStr) [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"%@", errorStr] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil]



//字体大小
#define kFontSizeFifteen [UIFont fontWithName:@"STHeitiSC-Light" size:15 * kCoefficient]
#define kFont [UIFont boldSystemFontOfSize:14 * kCoefficient]
#define kFontSize [UIFont fontWithName:@"STHeitiSC-Light" size:15]
#define kFontSizeThir [UIFont fontWithName:@"STHeitiSC-Light" size:13 * kCoefficient]
#define kFontSizeEleven [UIFont fontWithName:@"STHeitiSC-Light" size:13 * kCoefficient]
#define kFontSizeTen [UIFont fontWithName:@"STHeitiSC-Light" size:10 * kCoefficient]
#define kFontSizeTwelve [UIFont fontWithName:@"STHeitiSC-Light" size:12 * kCoefficient]


#pragma mark - 设备类型
#define kiPhone4     ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define kiPhone5     ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define kiPhone6     ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define kiPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)


//kal color

#define RGBCOLOR(R,G,B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1]
#define RGBACOLOR(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]


#define kDarkGrayColor       RGBCOLOR(51, 51, 51)
#define kGrayColor           RGBCOLOR(153, 153, 153)
#define kLightGrayColor      RGBCOLOR(185, 185, 185)

#define BYHUD(message, detail, delay) \
\
MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];\
\
hud.mode = MBProgressHUDModeText;\
\
hud.labelText = [NSString stringWithFormat:@"%@", message];\
\
hud.detailsLabelText = [NSString stringWithFormat:@"%@", detail];\
\
hud.margin = 10.f;\
\
hud.removeFromSuperViewOnHide = YES;\
\
[hud hide:YES afterDelay:delay];\
\


#define AddBYProgress(view, string) \
\
MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];\
\
hud.mode = MBProgressHUDModeIndeterminate;\
\
hud.labelText = [NSString stringWithFormat:@"%@", string];\
\



#endif /* AppHeader_h */
