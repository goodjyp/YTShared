//
//  UrlHeader.h
//  OTS-V7
//
//  Created by ypj on 15/12/18.
//  Copyright © 2015年 ypj. All rights reserved.
//

#ifndef UrlHeader_h
#define UrlHeader_h

//基础测试Url
//#define kOTSBaseUrl @"http://test.m.api.ots.palmyou.com"

//测试Url
//#define kBSUrl @"http://test.palmdata.palm.im"

//本地
//#define kBSUrl @"http://192.168.1.137:10000"

#define HTML5_URL @"https://www.bqbike.com/Dibike/findH5.action"

// 云服务(正式)
#define ONLINE @"www.bqbike.com/Dibike"
#define ACTION @".action"
// 本地(测试)
//#define ONLINE @"192.168.0.10:8080/Dibike"
//#define ACTION @".action"

/*****网络请求的url*****/
#define SUCCESS_CODE       @"01001"                                                 // 正确返回码

#define ICON_BASE @"https://www.bqbike.com/img"
#define versionUrl [NSString stringWithFormat:@"http://%@/findIOS%@",ONLINE,ACTION]


#endif /* UrlHeader_h */

