//
//  PushButtonViewController.m
//  AllCodeDataNew
//
//  Created by 宋江 on 16/3/18.
//  Copyright © 2016年 宋江. All rights reserved.
//

#import "PushButtonViewController.h"
#import "DisperseBtn.h"

@interface PushButtonViewController ()
@property(nonatomic ,weak) UILabel *lab;
@property (weak, nonatomic) DisperseBtn *disView;
@end

@implementation PushButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UISlider *slider = [[UISlider alloc]initWithFrame:CGRectMake(20, self.view.center.y, VIEW_WEDTH - 40, 30)];
    [slider addTarget:self action:@selector(sliderTagget:) forControlEvents:UIControlEventValueChanged];
    slider.maximumValue = 9;
    slider.minimumValue = 3;
    [self.view addSubview:slider];
    
    //散开的view
    DisperseBtn *disView = [[DisperseBtn alloc]init];
    disView.frame = CGRectMake(150, 150, 50, 50);
    disView.borderRect = self.view.frame;
    disView.closeImage = [UIImage imageNamed:@"SC"];
    disView.openImage = [UIImage imageNamed:@"SC"];
    
    [self.view addSubview:disView];
    _disView = disView;
    [self setDisViewButtonsNum:3];
    
    //调试使用
    UILabel *lab = [UILabel new];
    lab.bounds = CGRectMake(0, 0, 300, 200);
    lab.font = [UIFont systemFontOfSize:30];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.center = self.view.center;
    _lab = lab;
    [self.view addSubview:lab];
    
}
//调试使用
- (void)sliderTagget:(UISlider *)sender {
    
    int num = sender.value;
    NSLog(@"%d",num);
    [self setDisViewButtonsNum:num];
    
}
- (void)setDisViewButtonsNum:(int)num{
    
    [_disView recoverBotton];
    
    for (UIView *btn in _disView.btns) {
        [btn removeFromSuperview];
    }
    
    NSMutableArray *marr = [NSMutableArray array];
    for (int i = 0; i< num; i++) {
        UIButton *btn = [UIButton new];
        NSString *name = [NSString stringWithFormat:@"SC%d",i];
        [btn setBackgroundImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
        [marr addObject:btn];
        btn.tag = i;
        [btn addTarget:self action:@selector(buttonTagget:) forControlEvents:UIControlEventTouchUpInside];
    }
    _disView.btns = [marr copy];
}

-(void)buttonTagget:(UIButton *)sender{
    self.lab.text = [NSString stringWithFormat:@"点击了第%ld个按钮",sender.tag+1];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.lab.text = @"点击屏幕";
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
