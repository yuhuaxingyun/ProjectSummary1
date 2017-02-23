//
//  FSLineChartViewController.m
//  AllCodeDataNew
//
//  Created by 宋江 on 16/5/23.
//  Copyright © 2016年 宋江. All rights reserved.
//

#import "FSLineChartViewController.h"
#import "FSLineChart.h"
#import "UIColor+FSPalette.h"
@interface FSLineChartViewController ()
@property (nonatomic, strong) FSLineChart *chart;
@property (nonatomic, strong) FSLineChart *chartWithDates;
@end

@implementation FSLineChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _chart = [[FSLineChart alloc]initWithFrame:CGRectMake(25, 100, VIEW_WEDTH - 50, 160)];
    [self.view addSubview:_chart];
    
    _chartWithDates = [[FSLineChart alloc]initWithFrame:CGRectMake(25, 300, VIEW_WEDTH - 50, 160)];
    [self.view addSubview:_chartWithDates];
    
    
    [self loadSimpleChart];
    [self loadChartWithDates];
    

}
#pragma mark - Setting up the charts

- (void)loadSimpleChart {
    NSMutableArray* chartData = [NSMutableArray arrayWithCapacity:10];
    
    for(int i=0;i<10;i++) {
        int r = (rand() + rand()) % 1000;
        chartData[i] = [NSNumber numberWithInt:r + 200];
    }
    
    // Setting up the line chart
    self.chart.verticalGridStep = 5;
    self.chart.horizontalGridStep = 9;
    self.chart.valueLabelPosition = ValueLabelLeft;
    
    self.chart.labelForIndex = ^(NSUInteger item) {
        return [NSString stringWithFormat:@"%lu",(unsigned long)item];
    };
    
    self.chart.labelForValue = ^(CGFloat value) {
        return [NSString stringWithFormat:@"%.f", value];
    };
    
    [self.chart setChartData:chartData];
}

- (void)loadChartWithDates {
    // Generating some dummy data
    NSMutableArray* chartData = [NSMutableArray arrayWithCapacity:7];
    for(int i=0;i<7;i++) {
        chartData[i] = [NSNumber numberWithFloat: (float)i / 30.0f + (float)(rand() % 100) / 500.0f];
    }
    
    NSArray* months = @[@"January", @"February", @"March", @"April", @"May", @"June", @"July"];
    
    // Setting up the line chart
    _chartWithDates.verticalGridStep = 6;
    _chartWithDates.horizontalGridStep = 3;
    _chartWithDates.fillColor = nil;
    _chartWithDates.displayDataPoint = YES;
    _chartWithDates.dataPointColor = [UIColor fsOrange];
    _chartWithDates.dataPointBackgroundColor = [UIColor fsOrange];
    _chartWithDates.dataPointRadius = 2;
    _chartWithDates.color = [_chartWithDates.dataPointColor colorWithAlphaComponent:0.3];
    _chartWithDates.valueLabelPosition = ValueLabelLeftMirrored;
    
    _chartWithDates.labelForIndex = ^(NSUInteger item) {
        return months[item];
    };
    
    _chartWithDates.labelForValue = ^(CGFloat value) {
        return [NSString stringWithFormat:@"%.02f €", value];
    };
    
    [_chartWithDates setChartData:chartData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
