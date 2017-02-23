//
//  LocationViewController.m
//  ThirdPartyLogin
//
//  Created by 宋江 on 16/2/25.
//  Copyright © 2016年 wt-vrs. All rights reserved.
//

#import "MapKitViewController.h"
#import "SEFilterControl.h"
#import "HsTopView.h"
#import "HsCenterView.h"
#import <CocoaAsyncSocket/GCDAsyncSocket.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "KCAnnotation.h"
@interface MapKitViewController()<CLLocationManagerDelegate,MKMapViewDelegate>
{
    CLLocationManager *_locationManger;
    NSString *_locationStr;
    MKMapView *_mapView;
    CLGeocoder *_geocoder;
    NSString *_locationStartStr;
    
    GCDAsyncSocket *_socket;
    NSTimer *_timer;
    SEFilterControl *_filter;
    UIView *_bottomView;
    UIView *_btnView;
    NSMutableArray *_coordinateArray;
    
}
@property (nonatomic,strong) HsTopView *topView;
@property (nonatomic, nonnull,strong)HsCenterView *centerView;
@property (nonatomic,strong)UIButton *locationBtn;
@end

@implementation MapKitViewController

//- (void)viewWillAppear:(BOOL)animated{
//    self.navigationController.navigationBar.translucent = NO;
//}
//- (void)viewWillDisappear:(BOOL)animated{
//    self.navigationController.navigationBar.translucent = YES;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createBarItem];
    [self createLocation];
    [self createSliderBtn];
    
}
- (void)createBarItem{
    UIBarButtonItem *backBtnItem = [UIBarButtonItem itemWithImageName:@"Back" target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = backBtnItem;
}
- (void)createSliderBtn{
    
    [self.view addSubview:self.topView];
    [_mapView addSubview:self.centerView];
    [_mapView addSubview:self.locationBtn];
    
    
    _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0,[[UIScreen mainScreen]bounds].size.height - 189, self.view.frame.size.width, 125)];
    _bottomView.backgroundColor = [UIColor colorWithRed:212/225.0 green:212/225.0 blue:214/225.0 alpha:1.0];
    [self.view addSubview:_bottomView];
    
    
    _btnView = [[UIView alloc]initWithFrame:CGRectMake(0,40, self.view.frame.size.width, 85)];
    _btnView.backgroundColor = [UIColor redColor];
    [_bottomView addSubview:_btnView];
    
    _filter = [[SEFilterControl alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 85) Titles:[NSArray arrayWithObjects:@"人民轿车", @"高级轿车", @"豪华轿车", @"优步专车", nil]];
    [_filter addTarget:self action:@selector(filterValueChanged:) forControlEvents:UIControlEventTouchUpInside];
    [_filter setProgressColor:[UIColor groupTableViewBackgroundColor]];//设置滑杆的颜色
    [_filter setTopTitlesColor:[UIColor orangeColor]];//设置滑块上方字体颜色
    [_filter setSelectedIndex:0];//设置当前选中
    [_btnView addSubview:_filter];
    
}
- (void)createLocation{
    //实例化定位
    _geocoder = [[CLGeocoder alloc]init];
    
    
    _mapView = [[MKMapView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height - 189)];
    _mapView.delegate = self;
    _mapView.userTrackingMode = MKUserTrackingModeFollow;
    _mapView.mapType = MKMapTypeStandard;
    [self.view addSubview:_mapView];
    
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"定位服务尚未打开，请设置打开");
        return;
    }
    //获取位置信息
    _locationManger = [[CLLocationManager alloc]init];
    //如果没有授权则请求用户授权
    if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined){
        [_locationManger requestWhenInUseAuthorization];
    }else if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedWhenInUse){
        
        //设置代理
        _locationManger.delegate=self;
        //设置定位精度
        _locationManger.desiredAccuracy=kCLLocationAccuracyBest;
        //定位频率,每隔多少米定位一次
        CLLocationDistance distance=10.0;//十米定位一次
        _locationManger.distanceFilter=distance;
        //启动跟踪定位
        [_locationManger startUpdatingLocation];
        
    }
    
    
}


#pragma mark - CoreLocation 代理
#pragma mark 跟踪定位代理方法，每次位置发生变化即会执行（只要定位到相应位置）
//可以通过模拟器设置一个虚拟位置，否则在模拟器中无法调用此方法
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *location = [locations firstObject];
    CLLocationCoordinate2D coordinate = location.coordinate;
    [self showInMapWithCoordinate:location.coordinate];
    [_locationManger stopUpdatingLocation];
    _locationStr = [NSString stringWithFormat:@"经度：%f,纬度：%f,海拔：%f,航向：%f,行走速度：%f",coordinate.longitude,coordinate.latitude,location.altitude,location.course,location.speed];
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    if (error.code == kCLErrorDenied) {
        NSLog(@"%@",error);
    }
}

#pragma mark --将位置信息显示到mapView上
- (void)showInMapWithCoordinate:(CLLocationCoordinate2D)coordinate {
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, MKCoordinateSpanMake(0.025, 0.025));
    [_mapView setRegion:region animated:YES];
    //    [self addAnnotation:coordinate];
}

//#pragma mark --添加大头针
//- (void)addAnnotation:(CLLocationCoordinate2D)coordinate {
////    [_mapView removeAnnotations:_mapView.annotations];
//
//    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
//    annotation.title = _locationStr;
//    annotation.subtitle = @"你要来吗？";
//    annotation.coordinate = coordinate;
//    [_mapView selectAnnotation:annotation animated:YES];
//    [_mapView addAnnotation:annotation];
//
//
//
//}
- (void)addAnnotation:(NSMutableArray *)locationArray{
    NSLog(@"%@",locationArray);
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.title = _locationStr;
    annotation.subtitle = @"你要来吗？";
    //    annotation.coordinate = locationArray[0].coordinate ;
    [_mapView selectAnnotation:annotation animated:YES];
    [_mapView addAnnotation:annotation];
    
    MKPointAnnotation *annotation1 = [[MKPointAnnotation alloc] init];
    annotation1.title = _locationStr;
    annotation1.subtitle = @"你要来吗？";
    //    annotation.coordinate = coordinate;
    [_mapView selectAnnotation:annotation1 animated:YES];
    [_mapView addAnnotation:annotation1];
    
}
- (void)addAnnotation{
    
    //    CLLocationCoordinate2D location1=CLLocationCoordinate2DMake(30.190768, 120.176582);
    //    KCAnnotation *annotation1=[[KCAnnotation alloc]init];
    //    annotation1.title=@"CMJ Studio";
    //    annotation1.subtitle=@"Kenshin Cui's Studios";
    //    annotation1.coordinate=location1;
    //    [_mapView addAnnotation:annotation1];
    //
    //    CLLocationCoordinate2D location2=CLLocationCoordinate2DMake(30.192616, 120.195953);
    //    KCAnnotation *annotation2=[[KCAnnotation alloc]init];
    //    annotation2.title=@"Kenshin&Kaoru";
    //    annotation2.subtitle=@"Kenshin Cui's Home";
    //    annotation2.coordinate=location2;
    //    [_mapView addAnnotation:annotation2];
    
    CLLocationCoordinate2D location1=CLLocationCoordinate2DMake(30.190768, 120.176582);
    KCAnnotation *annotation1=[[KCAnnotation alloc]init];
    annotation1.title=@"CMJ Studio";
    annotation1.subtitle=@"Kenshin Cui's Studios";
    annotation1.coordinate=location1;
    annotation1.image=[UIImage imageNamed:@"icon_pin_floating.png"];
    annotation1.icon=[UIImage imageNamed:@"icon_mark1.png"];
    annotation1.detail=@"CMJ Studio...";
    annotation1.rate=[UIImage imageNamed:@"icon_Movie_Star_rating.png"];
    [_mapView addAnnotation:annotation1];
    
    CLLocationCoordinate2D location2=CLLocationCoordinate2DMake(30.192616, 120.195953);
    KCAnnotation *annotation2=[[KCAnnotation alloc]init];
    annotation2.title=@"Kenshin&Kaoru";
    annotation2.subtitle=@"Kenshin Cui's Home";
    annotation2.coordinate=location2;
    annotation2.image=[UIImage imageNamed:@"icon_paopao_waterdrop_streetscape.png"];
    annotation2.icon=[UIImage imageNamed:@"icon_mark2.png"];
    annotation2.detail=@"Kenshin Cui...";
    annotation2.rate=[UIImage imageNamed:@"icon_Movie_Star_rating.png"];
    [_mapView addAnnotation:annotation2];
    
}
#pragma mark - 地图控件代理方法
#pragma mark 显示大头针时调用，注意方法中的annotation参数是即将显示的大头针对象
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    //由于当前位置的标注也是一个大头针，所以此时需要判断，此代理方法返回nil使用默认大头针视图
    if ([annotation isKindOfClass:[KCAnnotation class]]) {
        static NSString *key1=@"AnnotationKey1";
        MKAnnotationView *annotationView=[_mapView dequeueReusableAnnotationViewWithIdentifier:key1];
        //如果缓存池中不存在则新建
        if (!annotationView) {
            annotationView=[[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:key1];
            annotationView.canShowCallout=true;//允许交互点击
            annotationView.calloutOffset=CGPointMake(0, 1);//定义详情视图偏移量
            annotationView.leftCalloutAccessoryView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_classify_cafe.png"]];//定义详情左侧视图
        }
        
        //修改大头针视图
        //重新设置此类大头针视图的大头针模型(因为有可能是从缓存池中取出来的，位置是放到缓存池时的位置)
        annotationView.annotation=annotation;
        annotationView.image=((KCAnnotation *)annotation).image;//设置大头针视图的图片
        
        return annotationView;
    }else {
        return nil;
    }
}

//- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
//
//{
//
//    NSArray * array = [NSArray arrayWithArray:_mapView.annotations];
//
//    for (int i=0; i<array.count; i++)
//
//    {
//
//        if (view.annotation.coordinate.latitude ==((MKPointAnnotation*)array[i]).coordinate.latitude)
//
//        {
//
//            //获取到当前的大头针  你可以执行一些操作
//
//        }
//
//        else
//
//        {
//
//            //对其余的大头针进行操作  我是删除
//
//            [_mapView removeAnnotation:array[i]];
//
//        }
//
//    }
//
//}
/*地图渲染每一帧画面过程中，以及每次需要重绘地图时（例如添加覆盖物）都会调用此接口
 *@param mapview 地图View
 *@param status 此时地图的状态
 */
//- (void)mapView:(MKMapView *)mapView onDrawMapFrame:(MKMapStatus*)status{
//
//}
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view didChangeDragState:(MKAnnotationViewDragState)newState fromOldState:(MKAnnotationViewDragState)oldState{
    
}
/**
 *地图区域即将改变时会调用此接口
 *@param mapview 地图View
 *@param animated 是否动画
 */
- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated{
    
}

/**
 *地图区域改变完成后会调用此接口
 *@param mapview 地图View
 *@param animated 是否动画
 */
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    CLLocationCoordinate2D localP = [mapView convertPoint:CGPointMake(self.view.frame.size.width/2.0, CGRectGetMaxY(_centerView.frame)) toCoordinateFromView:self.view];
    
    [self getAddressByLatitude:localP.latitude longitude:localP.longitude];
}
//根据坐标获取地名
-(void)getAddressByLatitude :(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude{
    
    CLLocation *location = [[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    [_geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *placemark = [placemarks firstObject];
        _locationStartStr = placemark.name;
        if (_locationStartStr) {
            _topView.startLocationView.text = _locationStartStr;
        }
        
        NSString *str  = [NSString stringWithFormat:@"详细信息:  %@",placemark.addressDictionary[@"Name"]];
        NSLog(@"%@",str);
    }];
    
}

//根据地名确定地理坐标
- (void)getcoordinateByAddress:(NSString *)address{
    //地理编码
    [_geocoder geocodeAddressString:address completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *placemark = [placemarks firstObject];
        CLLocation *location = placemark.location; //位置
        CLRegion *region = placemark.region; //区域
        NSDictionary *addressDict = placemark.addressDictionary;
        _locationStr = placemark.name;
        [self showInMapWithCoordinate:CLLocationCoordinate2DMake(placemark.location.coordinate.latitude, placemark.location.coordinate.longitude)];
        
        NSString *coordinateStr = [NSString stringWithFormat:@"经度：%f,纬度：%f,海拔：%f,航向：%f,行走速度：%f",location.coordinate.longitude,location.coordinate.latitude,location.altitude,location.course,location.speed];
        NSLog(@"经纬度   ：：   %@",coordinateStr);
        [_coordinateArray addObject:placemark.location];
        
    }];
    
    //      [self addAnnotation:placemark.location.coordinate];
    
}
#pragma mark 导航
-(void)turnByTurn:(NSString *)startLocation endLocation:(NSString *)endLocation{
    //根据“北京市”地理编码
    [_geocoder geocodeAddressString:startLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *clPlacemark1=[placemarks firstObject];//获取第一个地标
        MKPlacemark *mkPlacemark1=[[MKPlacemark alloc]initWithPlacemark:clPlacemark1];
        //注意地理编码一次只能定位到一个位置，不能同时定位，所在放到第一个位置定位完成回调函数中再次定位
        [_geocoder geocodeAddressString:endLocation completionHandler:^(NSArray *placemarks, NSError *error) {
            CLPlacemark *clPlacemark2=[placemarks firstObject];//获取第一个地标
            MKPlacemark *mkPlacemark2=[[MKPlacemark alloc]initWithPlacemark:clPlacemark2];
            NSDictionary *options=@{MKLaunchOptionsMapTypeKey:@(MKMapTypeStandard),MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving};
            //MKMapItem *mapItem1=[MKMapItem mapItemForCurrentLocation];//当前位置
            MKMapItem *mapItem1=[[MKMapItem alloc]initWithPlacemark:mkPlacemark1];
            MKMapItem *mapItem2=[[MKMapItem alloc]initWithPlacemark:mkPlacemark2];
            [MKMapItem openMapsWithItems:@[mapItem1,mapItem2] launchOptions:options];
            
        }];
        
    }];
}
#pragma mark -- topView
- (HsTopView *)topView {
    if (_topView == nil) {
        _topView = [[HsTopView alloc] initWithFrame:CGRectMake(20, 20, self.view.frame.size.width-40, 80)];
        _topView.backgroundColor = [UIColor clearColor];
        
    }
    return _topView;
}
- (UIButton *)locationBtn{
    _locationBtn  =[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 35,[[UIScreen mainScreen]bounds].size.height-224, 25, 25)];
    _locationBtn.backgroundColor = [UIColor purpleColor];
    [_locationBtn setImage:[UIImage imageNamed:@"selfLocation"] forState:UIControlStateNormal];
    [_locationBtn addTarget:self action:@selector(selfLocation) forControlEvents:UIControlEventTouchUpInside];
    return _locationBtn;
}
#pragma mark -- 自己的位置
- (void)selfLocation{
    _mapView.userTrackingMode = MKUserTrackingModeFollow;
}
#pragma mark -- centerView
- (HsCenterView *)centerView {
    if (_centerView == nil) {
        CGFloat height = 40;
        _centerView = [[HsCenterView alloc] initWithFrame:CGRectMake(0, 0, 100, height)];
        _centerView.center = self.view.center;
        _centerView.delegate = self;
        
        
    }
    return _centerView;
}
- (void)centerViewClick{
    
    NSLog(@"你点击了它 ~~~~~");
    _coordinateArray = [NSMutableArray array];
    [self getcoordinateByAddress:@"中国浙江省杭州市滨江区长河街道立业路42号"];
    [self getcoordinateByAddress:@"中国浙江省杭州市滨江区长河街道时代大道"];
    [self addAnnotation:_coordinateArray];
    
}
#pragma mark -- 点击底部按钮响应事件
-(void)filterValueChanged:(SEFilterControl *)sender
{
    NSLog(@"当前滑块位置%d",sender.SelectedIndex);
    switch (sender.SelectedIndex) {
        case 0:
            //            _showLabel.text = @"当前选中：人民轿车";
            break;
        case 1:
            //            _showLabel.text = @"当前选中：高级轿车";
            break;
        case 2:
            //            _showLabel.text = @"当前选中：豪华轿车";
            break;
        case 3:
            //            _showLabel.text = @"当前选中：优步专车";
            break;
        default:
            break;
    }
}
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
