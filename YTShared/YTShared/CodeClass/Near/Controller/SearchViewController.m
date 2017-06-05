//
//  SearchViewController.m
//  Dibaibike
//
//  Created by 陈成 on 2016/10/18.
//  Copyright © 2016年 cn.chengbai.item. All rights reserved.
//

#import "SearchViewController.h"
#import "MTSearchBar.h"
#import "UIBarButtonItem+Extension.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "LocationTableViewCell.h"
#import "DataBase.h"
#import "locModel.h"
#import "CCButton.h"
#import "NearVC.h"



// 搜索
static NSString *indentity = @"cell";
@interface SearchViewController ()<UITextFieldDelegate , UITableViewDataSource , UITableViewDelegate , AMapSearchDelegate , UITextFieldDelegate>
{
    
        BOOL _isFirstIn; // 是否是第一次进来
    
}

@property (nonatomic , weak)UITextField *searchField; // 搜索框

@property (nonatomic , strong)AMapGeocodeSearchRequest *geo; //请求参数类

@property (nonatomic , strong)NSMutableArray<locModel *> * locations; //存放查出来的所有数据

@property (nonatomic , copy)void  (^myBlock)(NSMutableArray<locModel *> * locations);

@property (nonatomic , strong)AMapInputTipsSearchRequest *tips;

@property (nonatomic , assign)CGFloat footViewH;

@property (nonatomic , assign)NSInteger index;//是否点击确认

@property (nonatomic , weak)MTSearchBar *searchBar;

@property (weak , nonatomic) UIView *navgationView;  // 自定义导航栏

@property (weak , nonatomic) UITableView *tableView;



@end
@implementation SearchViewController

- (MTSearchBar *)searchBar
{
    if (!_searchBar) {
        
        MTSearchBar *searchBar = [MTSearchBar searchBar];
     
        searchBar.frame = CGRectMake(0, 0, 300.0/375.0 * kWidth, 30);
        
        [searchBar addTarget:self action:@selector(searchFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
        
        self.navigationItem.titleView = searchBar;
        
        searchBar.tintColor=[UIColor blueColor];
        
        if([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)
        {
            [searchBar setTintColor:[UIColor blueColor]];
        }
        _searchBar = searchBar;
    }
    return _searchBar;
}

- (void)setIndex:(NSInteger)index
{
    _index = index;
    if (_index == 1) {
        
        self.locations = [NSMutableArray array];
        [self.tableView reloadData];
    }
}

- (UITableView *)tableView
{
    if (!_tableView) {
        
        UITableView *tableView =[[UITableView alloc] initWithFrame:CGRectMake(0, -24, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStyleGrouped];
        
        self.automaticallyAdjustsScrollViewInsets = NO;
        
        [self.view addSubview:tableView];
        
        _tableView = tableView;
    }
    return _tableView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationItem setHidesBackButton:YES];
    
    [self setUpNavUI];
    
    _isFirstIn = YES;
    
    [self checkDBModel];
    
//    self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"LocationTableViewCell" bundle:nil] forCellReuseIdentifier:indentity];
    
    
    // 注册清除历史记录的cell
    [self.tableView registerNib:[UINib nibWithNibName:@"ClearHistoryCell" bundle:nil] forCellReuseIdentifier:@"history"];
    
    
    __weak typeof(self) weakSelf = self;
    self.myBlock = ^(NSMutableArray<locModel *> * locations){
        
        weakSelf.locations = locations;
        
        [weakSelf.tableView reloadData];
        
        
    };
    
    self.tableView.delegate  = self;
    self.tableView.dataSource = self;
    
    [self initAMapSearchAPI];
    
    [self searchField];
    
}

- (void)initAMapSearchAPI
{
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
}


// 检测数据库中有没有模型
- (void)checkDBModel
{
    DataBase *db = [DataBase sharedDataBase];
    // 有模型
    
    NSMutableArray * arr = [db getAllLocationModel];
    
    self.locations = [NSMutableArray<locModel *>  array];
    
    if (arr.count !=0) {
        
        for (locModel *loc in arr) {
            
            [self.locations addObject:loc];
        }
        // 刷新tableView
        [self.tableView reloadData];
    } else {
    
        self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    
    }
    
}

- (void)initNavigationBar{

    [self searchBar];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self andAction:@selector(back) titleName:@"取消"];

}


- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

// 导航栏界面
- (void)setUpNavUI
{
    [self initNavigationBar];
}


#pragma mark -- 搜索框文字改变时触发事件
- (void)searchFieldValueChanged:(UITextField *)textField
{
    
    // 搜索框的内容
    NSString *searchString = textField.text;
    
    //if (![searchString  isEqual: @""]) {
        
        [self requestSearchContentWith:searchString];
        
        _isFirstIn = NO;
   // }
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
}

/* 输入提示回调. */
- (void)onInputTipsSearchDone:(AMapInputTipsSearchRequest *)request response:(AMapInputTipsSearchResponse *)response
{
    //解析response获取提示词，具体解析见 Demo
    
    if (response.tips.count == 0)
    {
        return;
    }
    
    //解析response获取POI信息，具体解析见 Demo
    NSMutableArray<locModel *> * locations = [NSMutableArray array];
    
    for (AMapTip* poi in response.tips) {
        locModel *location = [[locModel alloc] init];
        location.name = poi.name;
        location.district = poi.district;
        location.latitude = poi.location.latitude;
        location.longitude = poi.location.longitude;
        
        [locations addObject:location];
    }
    
    self.myBlock(locations);
    
}


#pragma mark --- 清空历史记录
- (void)clearBtnClick
{
    //初始化提示框；
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"确定要清空历史搜索吗?" preferredStyle:  UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //点击按钮的响应事件；
        // 清除全部历史记录
        [[DataBase sharedDataBase] deleteAllLocationModel];
        
        self.index = 1;
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    
    [self presentViewController:alert animated:true completion:nil];
    
}

// 根据输入框的内容开始检索
- (void)requestSearchContentWith:(NSString *)address
{
    self.geo.address = address;
    
    self.tips = [[AMapInputTipsSearchRequest alloc] init];    // 发起地理编码查询
    self.tips.keywords = address;
    [self.search AMapInputTipsSearch:self.tips];
}

// 取消
- (void)cancelBtnClick{

    [self.searchBar removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark --- 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_isFirstIn && self.locations.count!=0) {   //第一次进来, 并且数据库中有数据
        return self.locations.count + 1;
    }
    return self.locations.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LocationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentity];
  
    if (_isFirstIn && self.locations.count !=0 && indexPath.row == self.locations.count) { // 第一次进来
    
        return [tableView dequeueReusableCellWithIdentifier:@"history"];
    
    }else
    {
        if (!cell) {
            
            cell = [[LocationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentity];
            
        }
        
        cell.locModel =  self.locations[indexPath.row];
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"当前位置 : %@",self.address];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.f;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.f;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        // 获取当前的cell 取出模型存库
        LocationTableViewCell *cell = nil;
    
        // 第一次进入点击
        if (_isFirstIn && self.locations.count!=0 && indexPath.row == self.locations.count) {
            
            [self clearBtnClick];
            
        }else
        {
        
        cell = [tableView cellForRowAtIndexPath:indexPath];
            
        cell.selected = NO;
        
        // 模型
        
        locModel *loc =  cell.locModel;
            
            BOOL isRepeat = NO;
        
        DataBase *db = [DataBase sharedDataBase];
        
        for (locModel *model in [db getAllLocationModel]) {

            NSLog(@"%@", loc.name);
            NSLog(@"%@",model.name);
            
            if ([model.name isEqualToString:[NSString stringWithFormat:@"%@", loc.name]]){
            
                isRepeat = YES;
            
            }
            
        }
            
            //判断数据库中没有重复数据并且该选中cell模型的经纬度不为空
        if(!isRepeat && cell.locModel.longitude && cell.locModel.latitude){
        
            [db addLocationModel:loc];
        
        }
        
        
    }
    
    // 获取到当前点击cell的经纬度
    
    if (cell.locModel.longitude && cell.locModel.latitude){
        NSLog(@"%f,%f",cell.locModel.longitude,cell.locModel.latitude);
        [self.navigationController popViewControllerAnimated:YES];
        
        NearVC *centerVc = self.homeVc;
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[@"lon"] = [NSString stringWithFormat:@"%f",cell.locModel.longitude];
        dict[@"lat"] = [NSString stringWithFormat:@"%lf",cell.locModel.latitude];
        
        centerVc.searchDict = dict;
    }else{
        
        if (cell.locModel!=nil) {
            [YJProgressHUD showMessage:@"当前地址无效,请重新选择地点" inView:self.view afterDelayTime:2.0];

        }
   
    }
    

}


- (void)dealloc
{
    XXLog(@"销毁");
}


@end
