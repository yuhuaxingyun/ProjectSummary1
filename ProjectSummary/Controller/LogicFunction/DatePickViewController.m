//
//  DatePickViewController.m
//  ProjectSummary
//
//  Created by baolicheng on 2017/2/17.
//  Copyright © 2017年 RenRenFenQi. All rights reserved.
//

#import "DatePickViewController.h"

@interface DatePickViewController ()
@property(nonatomic,strong) NSDate *date;
@property(nonatomic,strong)UILabel *label;
@end

@implementation DatePickViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createBarItem];
    UIBarButtonItem *certain = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(Certain)];
    self.navigationItem.rightBarButtonItem = certain;
    UIDatePicker *birthday = [[UIDatePicker alloc]initWithFrame:CGRectMake(10, 100, VIEW_WEDTH - 20, 150)];
    birthday.datePickerMode = UIDatePickerModeDate;
    [birthday addTarget:self action:@selector(Show:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:birthday];
    
    _label = [[UILabel alloc]initWithFrame:CGRectMake(0, 300, VIEW_WEDTH, 30)];
    _label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_label];
    
    NSDate *dateTime = [NSDate date];
    NSDateFormatter *date1 = [[NSDateFormatter alloc]init];
    [date1 setDateFormat:@"yyyy年MM月dd日 HH时mm分ss秒"];
    _date  = [date1 dateFromString:[date1 stringFromDate:dateTime]];
    NSString *SelfBirthday = [NSString stringWithFormat:@"%@",_date];
    _label.text = [SelfBirthday stringByReplacingCharactersInRange:NSMakeRange(10, 15) withString:@""];
    
}
- (void)Show:(UIDatePicker *)sender{
    UIDatePicker *control =(UIDatePicker *)sender;
    control.datePickerMode = UIDatePickerModeDate;
    _date = control.date;
    NSString *SelfBirthday = [NSString stringWithFormat:@"%@",_date];
    _label.text = [SelfBirthday stringByReplacingCharactersInRange:NSMakeRange(10, 15) withString:@""];

}
- (void)Cancel{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)Certain{
    NSLog(@"%@",_label.text);
}
- (void)createBarItem{
    UIBarButtonItem *backBtnItem = [UIBarButtonItem itemWithImageName:@"Back" target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = backBtnItem;
}
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
