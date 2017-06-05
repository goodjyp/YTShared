//
//  NearVC.m
//  YTShared
//
//  Created by ypj on 2017/6/1.
//  Copyright © 2017年 ypj. All rights reserved.
//

#import "NearVC.h"
#import "MenuBarView.h"
#import "ShareVC.h"
#import "CustomAnnotationView.h"
#import "MAOtherAnnotation.h"
#import "MACenterAnnotation.h"
#import "MACenterPinAnnotationView.h"
#import "CCMapView.h"
#import "LocationBikeM.h"
#import "MANaviRoute.h"
#import "LocationBikeVM.h"
#import "MMExampleDrawerVisualStateManager.h"
#import "MANaviRoute.h"
#define DefaultLocationTimeout  6
#define DefaultReGeocodeTimeout 3
#define APPOINTMENT_H 200.f
@interface NearVC ()<MAMapViewDelegate,AMapLocationManagerDelegate ,AMapSearchDelegate,MenuBarViewDelegate>
@property (weak , nonatomic)  MACenterPinAnnotationView *centerView;

@property (assign , nonatomic) CLLocationCoordinate2D startCoordinate; // 起点
@property (assign , nonatomic) CLLocationCoordinate2D endCoordinate; // 终点

@property (assign , nonatomic) CLLocationCoordinate2D locationCoordinate;  // 定位点判断

@property (strong , nonatomic)NSMutableArray<MAOtherAnnotation *> *annotationArr;        // 存放annotation的数组

@property (strong , nonatomic)NSMutableArray<CustomAnnotationView *> *annotationViewArr; // 存放大头针的数组

@property (strong , nonatomic)MACenterAnnotation *centerAnnotation;

@property (weak , nonatomic) UIImageView *centerImageView;  // 定位中心点
@property (nonatomic, copy) AMapLocatingCompletionBlock completionBlock;

/* 用于显示当前路线方案. */
@property (nonatomic) MANaviRoute * naviRoute;
@property (nonatomic, strong) AMapRoute *route;


@end

@implementation NearVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"搜索.png"] style:UIBarButtonItemStylePlain target:self action:@selector(handleLeftBarButton:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"分享.png"] style:UIBarButtonItemStylePlain target:self action:@selector(handleRightBarButton:)];
    
    MenuBarView *menuBV = [[MenuBarView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 40) fontSize:18 menuArray:@[@"彩虹伞",@"A骑单车"]];
    menuBV.delegate = self;
    
    [self.view addSubview:menuBV];
    self.mapView.logoCenter = CGPointMake(40, kHeight - 160);//设置高德地图4个字的中心点位置
    [self centerImageView];
    [self initCompleteBlock];
    [self configLocationManager];
    self.mapView.customizeUserLocationAccuracyCircleRepresentation = YES;

    
    
    
    
}

- (void)clickMenuBarWithIndex:(NSInteger)index
{
    NSLog(@"%ld",(long)index);
    if (index == 1) {
        self.mapView.logoCenter = CGPointMake(40, kHeight - 160);//设置高德地图4个字的中心点位置
        [self centerImageView];
        [self initCompleteBlock];
        [self configLocationManager];
        self.mapView.customizeUserLocationAccuracyCircleRepresentation = YES;
        
        
    } else {
        [self.mapView reloadMap];
//        self.mapView.logoCenter = CGPointMake(40, kHeight - 160);//设置高德地图4个字的中心点位置
        [self centerImageView];
        [self initCompleteBlock];
        [self configLocationManager];
        self.mapView.customizeUserLocationAccuracyCircleRepresentation = YES;
        
    }
}

- (void)locAction
{
    
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    //进行单次定位请求
    [self.locationManager requestLocationWithReGeocode:NO completionBlock:self.completionBlock];
}

- (void)viewDidAppear:(BOOL)animated
{
//    [self hsUpdateApp];
    [super viewDidAppear:animated];
    
    [YJProgressHUD hide];
    
    if (self.searchDict[@"lon"] != nil) {
        
        return;
    }
    
//    [self getDatas];
    
    //定位
    [self reGeocodeAction];
    
    //延迟一秒进行手动定位(解决返回地图界面页面偏移BUG)
    [self performSelector:@selector(locTap:) withObject:nil afterDelay:1.0f];
}

// 定位/刷新 按钮
- (void)locTap:(UIGestureRecognizer *)tap
{
    [self clear];
    
    //点击定位,收回预约界面
    [UIView animateWithDuration:0.1 animations:^{
        
//        self.appointmentV.frame = CGRectMake(0, 0 - APPOINTMENT_H, kWidth, 0);
    }];
    
    if(tap == nil)
    {
        if (self.centerAnnotation.lockedToScreen == NO) {
            self.centerAnnotation.lockedToScreen = YES;
            self.centerAnnotation.lockedScreenPoint = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2-47);
            self.centerImageView.hidden = NO;
        }
    }
    
    
    self.startCoordinate = CLLocationCoordinate2DMake(self.mapView.userLocation.coordinate.latitude, self.mapView.userLocation.coordinate.longitude);
    
    [self getAllBikeLocationInfoBy: [NSString stringWithFormat:@"%f",self.mapView.userLocation.coordinate.longitude] :[NSString stringWithFormat:@"%f",self.mapView.userLocation.coordinate.latitude]];
    
    [self.mapView setZoomLevel:17 animated:YES];
    [self.mapView setCenterCoordinate:self.mapView.userLocation.coordinate animated:YES];
}

/* 清空地图上已有的路线. */
- (void)clear
{
    [self.naviRoute removeFromMapView];
}

- (void)cleanUpAction
{
    //停止定位
    [self.locationManager stopUpdatingLocation];
    
    [self.locationManager setDelegate:nil];
    
    [self.mapView removeAnnotations:self.mapView.annotations];
}

- (void)reGeocodeAction
{
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    //进行单次带逆地理定位请求
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:self.completionBlock];
    
    
}

- (void)initCompleteBlock
{
    __weak NearVC *weakSelf = self;
    self.completionBlock = ^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error)
    {
        if (error)
        {
            
            [YJProgressHUD showMessage:@"定位失败，请检查网络..." inView:weakSelf.mapView afterDelayTime:2.0];
            
            //如果为定位失败的error，则不进行annotation的添加
            if (error.code == AMapLocationErrorLocateFailed)
            {
                [YJProgressHUD showMessage:@"定位失败，请检查网络..." inView:weakSelf.mapView afterDelayTime:2.0];
                return;
            }
        }
        
        //得到定位信息，添加annotation
        if (location)
        {
            MACenterAnnotation *annotation = [[MACenterAnnotation alloc] init];
            weakSelf.centerAnnotation = annotation;
            [annotation setCoordinate:location.coordinate];
            
            
            
            if (regeocode)
            {
                
                [annotation setTitle:[NSString stringWithFormat:@"%@", regeocode.formattedAddress]];
                [annotation setSubtitle:[NSString stringWithFormat:@"%@-%@-%.2fm", regeocode.citycode, regeocode.adcode, location.horizontalAccuracy]];
            }
            else
            {
                [annotation setTitle:[NSString stringWithFormat:@"lat:%f;lon:%f;", location.coordinate.latitude, location.coordinate.longitude]];
                [annotation setSubtitle:[NSString stringWithFormat:@"accuracy:%.2fm", location.horizontalAccuracy]];
            }
            
            NearVC *strongSelf = weakSelf;
            [strongSelf addAnnotationToMapView:annotation];
            
            weakSelf.startCoordinate = CLLocationCoordinate2DMake(annotation.coordinate.latitude, annotation.coordinate.longitude);
            
            // 请求后台，读取所有附近车辆信息
            [weakSelf getAllBikeLocationInfoBy:[NSString stringWithFormat:@"%f",annotation.coordinate.longitude] :[NSString stringWithFormat:@"%f",annotation.coordinate.latitude]];
            NSLog(@"%f",annotation.coordinate.longitude);
        }
    };
}

- (void)addAnnotationToMapView:(id<MAAnnotation>)annotation
{
    [self.mapView addAnnotation:annotation];
    
    [self.mapView selectAnnotation:annotation animated:YES];
    [self.mapView setZoomLevel:17 animated:NO];
    [self.mapView setCenterCoordinate:annotation.coordinate animated:YES];
}

- (UIImageView *)centerImageView
{
    if (!_centerImageView) {
        
        UIImageView *imageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search_poi_annotation"]];
        
        //imageview.center = CGPointMake(self.mapView.center.x, self.mapView.center.y-44);
        imageview.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height / 2 - 47);
        
        [self.mapView addSubview:imageview];
        
        _centerImageView = imageview;
    }
    return _centerImageView;
}

#pragma mark --- 移动地图
- (void)mapView:(MAMapView *)mapView mapDidMoveByUser:(BOOL)wasUserAction
{
    if (wasUserAction == YES) {
        // 取出定位图标的底部xy
        CGPoint point = CGPointMake((self.centerView.center.x + self.centerView.width / 2), CGRectGetMaxY(self.centerView.frame));
        
        CLLocationCoordinate2D randomCoordinate =  [self.mapView convertPoint:point toCoordinateFromView:self.view];
        
        self.startCoordinate = CLLocationCoordinate2DMake(randomCoordinate.latitude, randomCoordinate.longitude);
        
        CLLocationDistance distance =  0.0;
        
        distance = MAMetersBetweenMapPoints(MAMapPointForCoordinate(self.locationCoordinate), MAMapPointForCoordinate(self.startCoordinate));
        
        // 一公里之外搜索
        if (distance >= 500) {
            
            [self getAllBikeLocationInfoBy: [NSString stringWithFormat:@"%f",randomCoordinate.longitude] :[NSString stringWithFormat:@"%f",randomCoordinate.latitude]];
        }
        
    }
}



#pragma mark --- 根据当前经纬度，请求后台读取所有车辆
- (void)getAllBikeLocationInfoBy:(NSString *)lng :(NSString *)lat
{
    
    
    [LocationBikeVM getBikeLocationInfoBy:lng andLat:lat :^(NSMutableArray<LocationBikeM *> *dict) {
        
        // 清除数组
        
        if (self.annotationViewArr!=nil && self.annotationViewArr.count > 0) {
            
            for (int i = 0; i<self.annotationViewArr.count; i++) {
                
                [self.annotationViewArr[i] removeFromSuperview];
            }
            self.annotationViewArr = nil;
        }
        // 得到所有的车辆信息
        if (dict.count>0) {
            
            if (self.annotationArr.count>0) {
                // 清除大头针
                
                [self.mapView removeAnnotations:self.annotationArr];
                self.annotationArr = nil;
            }
            
            CLLocationDistance distance3 =  0.0;
            // 距离
            CLLocationDistance distance =  0.0;
            
            MAOtherAnnotation *annos = nil;
            
            int a = 0;
            for (LocationBikeM *bike in dict) {
                
                CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([bike.lat floatValue], [bike.lng floatValue]);
                
                // 创建大头针
                MAOtherAnnotation *anno = [[MAOtherAnnotation alloc] init];
                anno.coordinate = coordinate;
                anno.bikeNo = bike.bikeNO;
                
                distance = MAMetersBetweenMapPoints(MAMapPointForCoordinate(self.startCoordinate), MAMapPointForCoordinate(coordinate));
                
                if (a == 0) distance3 = distance;
                
                
                if (distance <= distance3) {
                    distance3 = distance;
                    annos = anno;
                }
                [self.annotationArr addObject:anno];
                a++;
            }
            annos.zuijin = @"ok";// 表示该点最近
            self.locationCoordinate = CLLocationCoordinate2DMake(annos.coordinate.latitude, annos.coordinate.longitude);
            
            [self.mapView addAnnotations:self.annotationArr];
            
        }else
        {
            [YJProgressHUD showMessage:@"附近未投放车辆..." inView:self.mapView afterDelayTime:1.0];
        }
        
    } :^{
        
        [YJProgressHUD showMessage:@"寻车错误，请重新刷新定位..." inView:self.mapView afterDelayTime:1.0];
    }];
}


- (void)loadView
{
    CCMapView *mapView = [[CCMapView alloc] initWithFrame:CGRectMake(0, 40, kWidth, kHeight - 100)];
    mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    mapView.delegate = self;
    mapView.rotateCameraEnabled = NO;
    
    mapView.showsUserLocation = YES;
    //    mapView.userTrackingMode = MAUserTrackingModeFollow;
    mapView.showsCompass = NO;//指南针
    mapView.showsScale = NO;
    self.mapView = mapView;
    self.view = self.mapView;
}


#pragma mark =====左侧分享=====
- (void)handleLeftBarButton:(UIBarButtonItem *)leftSender
{
    
}

- (void)handleRightBarButton:(UIBarButtonItem *)rightsender
{
    ShareVC *share = [[ShareVC alloc] init];
    
    [self.navigationController pushViewController:share animated:YES];
}

- (void)configLocationManager
{
    self.locationManager = [[AMapLocationManager alloc] init];
    
    [self.locationManager setDelegate:self];
    
    //设置期望定位精度
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    
    //设置不允许系统暂停定位
    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
    
    //设置允许在后台定位
    [self.locationManager setAllowsBackgroundLocationUpdates:YES];
    
    //设置定位超时时间
    [self.locationManager setLocationTimeout:DefaultLocationTimeout];
    
    //设置逆地理超时时间
    [self.locationManager setReGeocodeTimeout:DefaultReGeocodeTimeout];
}

//搜索
- (void)setSearchDict:(NSMutableDictionary *)searchDict
{
    _searchDict = searchDict;
    
    // 重新寻找定位
    CLLocation *location = [[CLLocation alloc] initWithLatitude:[searchDict[@"lat"] doubleValue] longitude:[searchDict[@"lon"] doubleValue]];
    
    [self getAllBikeLocationInfoBy: searchDict[@"lon"] :searchDict[@"lat"]];
    
    [self.mapView setZoomLevel:17 animated:YES];
    [self.mapView setCenterCoordinate:location.coordinate animated:YES];
}

#pragma mark - MAMapView Delegate
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if (annotation == mapView.userLocation)
    {
        return nil;
    }
    
    if ([annotation isKindOfClass:[MACenterAnnotation class]])    // 定位大头针
    {
        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        
        self.startCoordinate = CLLocationCoordinate2DMake(((MACenterAnnotation *)annotation).coordinate.latitude, ((MACenterAnnotation *)annotation).coordinate.longitude);
        
        CGPoint point = [mapView convertCoordinate:((MACenterAnnotation *)annotation).coordinate toPointToView:mapView];
        
        
        ((MACenterAnnotation *)annotation).lockedToScreen = YES;
        
        ((MACenterAnnotation *)annotation).lockedScreenPoint = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2-47);
        
        MACenterPinAnnotationView *annotationView = (MACenterPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MACenterPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
        }
        
        annotationView.hidden = NO;
        annotationView.canShowCallout   = NO;
        annotationView.draggable        = NO;
        
        UIImage *centerImage = [UIImage imageNamed:@"search_poi_annotation"];
        
        UIImageView *pointView = [[UIImageView alloc] initWithImage:centerImage];
        
        
        annotationView.frame = CGRectMake(point.x, point.y - centerImage.size.height/2 , centerImage.size.width, centerImage.size.height);
        
        [annotationView addSubview:pointView];
        
        self.centerView = annotationView;
        
        return annotationView;
    }
    
    if ([annotation isKindOfClass:[MAOtherAnnotation class]]) {
        
        static NSString *otherReuseIndetifier = @"otherReuseIndetifier";
        
        CustomAnnotationView *customView = (CustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:otherReuseIndetifier];
        
        if (customView == nil) {
            
            customView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:otherReuseIndetifier];
        }
        
        [self.annotationViewArr addObject:customView];  // 添加大头针到数组
        
        customView.canShowCallout = NO;
        customView.draggable = NO;
        
        UIImage *otherView = [UIImage imageNamed:@"fixed_point_one_normal"];
        
        UIImageView *otherV = [[UIImageView alloc] initWithImage:otherView];
        
        CGPoint point = [mapView convertCoordinate:((MAOtherAnnotation *)annotation).coordinate toPointToView:mapView];
        
        customView.bounds = CGRectMake(0, 0, otherView.size.width, otherView.size.height);
        
        customView.center = point;
        
        customView.zuijin = ((MAOtherAnnotation *)annotation).zuijin;
        
        [customView addSubview:otherV];
        
        return customView;
    }
    
    // 清除多余的标注
    if ([annotation isKindOfClass:[MANaviAnnotation class]]) {
        
        static NSString *otherReuseIndetifier = @"otherReuseIndetifier";
        
        CustomAnnotationView *customView = (CustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:otherReuseIndetifier];
        
        if (customView == nil) {
            
            customView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:otherReuseIndetifier];
        }
        //wind_00042
        customView.image = [UIImage imageNamed:@"wind_00042"];
        
        customView.enabled = NO;
        return customView;
        
    }
    
    return nil;
}


- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
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
