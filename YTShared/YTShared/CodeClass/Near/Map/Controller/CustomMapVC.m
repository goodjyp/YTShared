//
//  CustomMapVC.m
//  YTShared
//
//  Created by ypj on 2017/6/4.
//  Copyright © 2017年 ypj. All rights reserved.
//

#import "CustomMapVC.h"
#import "CustomAnnotationView.h"
#import "MANaviAnnotation.h"
#import "MANaviRoute.h"
static const NSString *RoutePlanningViewControllerStartTitle       = @"起点";
static const NSString *RoutePlanningViewControllerDestinationTitle = @"终点";
static const NSInteger RoutePlanningPaddingEdge                    = 20;

@interface CustomMapVC ()<MAMapViewDelegate,AMapSearchDelegate>
@property (strong , nonatomic)MAPointAnnotation *startAnnotation;
@property (strong , nonatomic)MAPointAnnotation *destinationAnnotation;

@property (assign , nonatomic)CLLocationCoordinate2D startCoordinate; // 起点
@property (assign , nonatomic)CLLocationCoordinate2D endCoordinate; // 终点

// 路线规划
@property (nonatomic, strong) AMapSearchAPI *search;
@property (strong , nonatomic)NSMutableArray *annos;

/* 用于显示当前路线方案. */
@property (nonatomic , strong) MANaviRoute * naviRoute;
@property (nonatomic, strong) AMapRoute *route;

@end





@implementation CustomMapVC

- (void)initMapBlock
{
    __weak CustomMapVC *(weakSelf) = self;
    self.mapBlock = ^(MAOtherAnnotation *start,MAOtherAnnotation *end){
        weakSelf.search  = [[AMapSearchAPI alloc] init];
        weakSelf.search.delegate = weakSelf;
        weakSelf.mapView.delegate = weakSelf;
        [weakSelf.annos addObject:start];
        [weakSelf.annos addObject:end];
        // 添加两个大头针到地图
        [weakSelf.mapView addAnnotations:weakSelf.annos];
        // 画线
        // 路线规划
        [weakSelf routePlanningStart:start end:end];
    };
}

#pragma mark --- 路线规划
- (void)routePlanningStart:(MAOtherAnnotation *)startAnnotation end: (MAOtherAnnotation *)endAnnotation
{
    self.destinationAnnotation = endAnnotation; // 终点
    self.startAnnotation = startAnnotation; // 起点
    
    self.startCoordinate = CLLocationCoordinate2DMake(self.startAnnotation.coordinate.latitude, self.startAnnotation.coordinate.longitude);
    self.endCoordinate = CLLocationCoordinate2DMake(endAnnotation.coordinate.latitude, endAnnotation.coordinate.longitude);
    
    
    [self searchRoutePlanningWalk:self.startCoordinate :endAnnotation.coordinate];
}

#pragma mark -路线规划 do search
- (void)searchRoutePlanningWalk :(CLLocationCoordinate2D )startCoordinate :(CLLocationCoordinate2D )endCoordinate
{
    
    AMapWalkingRouteSearchRequest *navi = [[AMapWalkingRouteSearchRequest alloc] init];
    
    /* 提供备选方案*/
    navi.multipath = 1;
    
    /* 出发点. */
    navi.origin = [AMapGeoPoint locationWithLatitude:startCoordinate.latitude
                                           longitude:startCoordinate.longitude];
    /* 目的地. */
    navi.destination = [AMapGeoPoint locationWithLatitude:endCoordinate.latitude
                                                longitude:endCoordinate.longitude];
    
    [self.search AMapWalkingRouteSearch:navi];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:self.mapView];
    [self.mapView setZoomLevel:17 animated:YES];
    self.mapView.delegate =self;
    [self initMapBlock];

    
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    
    if ([annotation isKindOfClass:[MAOtherAnnotation class]]) {
        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        CustomAnnotationView *customView = (CustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (customView == nil) {
            customView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
        }
        customView.canShowCallout = NO;
        customView.draggable = NO;
        
        UIImage *otherView = [UIImage imageNamed:@"fixed_point_one_normal"];
        
        UIImageView *otherV = [[UIImageView alloc] initWithImage:otherView];
        
        CGPoint point = [mapView convertCoordinate:((MAOtherAnnotation *)annotation).coordinate toPointToView:mapView];
        
        customView.center = point;
        
        customView.bounds = CGRectMake(0, 0, otherView.size.width, otherView.size.height);
        
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
        customView.image = [UIImage imageNamed:@"wind_00042"];
        return customView;
        
    }
    return nil;
}

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[LineDashPolyline class]])
    {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:((LineDashPolyline *)overlay).polyline];
        polylineRenderer.lineWidth   = 8;
        polylineRenderer.lineDash = NO;
        polylineRenderer.strokeColor = [UIColor colorWithHexString:@"32a6f7"];
        
        return polylineRenderer;
    }
    if ([overlay isKindOfClass:[MANaviPolyline class]])
    {
        MANaviPolyline *naviPolyline = (MANaviPolyline *)overlay;
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:naviPolyline.polyline];
        
        polylineRenderer.lineWidth = 8;
        
        if (naviPolyline.type == MANaviAnnotationTypeWalking)
        {
            polylineRenderer.strokeColor = [UIColor colorWithHexString:@"32a6f7"];
        }
        else if (naviPolyline.type == MANaviAnnotationTypeRailway)
        {
            polylineRenderer.strokeColor = self.naviRoute.railwayColor;
        }
        else
        {
            polylineRenderer.strokeColor = self.naviRoute.routeColor;
        }
        
        return polylineRenderer;
    }
    if ([overlay isKindOfClass:[MAMultiPolyline class]])
    {
        MAMultiColoredPolylineRenderer * polylineRenderer = [[MAMultiColoredPolylineRenderer alloc] initWithMultiPolyline:overlay];
        
        polylineRenderer.lineWidth = 10;
        polylineRenderer.strokeColors = [self.naviRoute.multiPolylineColors copy];
        polylineRenderer.gradient = YES;
        
        return polylineRenderer;
    }
    
    return nil;
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
