//
//  GestureViewController.m
//  AllCodeDataNew
//
//  Created by 宋江 on 16/5/12.
//  Copyright © 2016年 宋江. All rights reserved.
//

#import "GestureViewController.h"

@interface GestureViewController ()

@end

@implementation GestureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //单击
    UITapGestureRecognizer *gesture1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];
    [self.view addGestureRecognizer:gesture1];
    
    //双击
    UITapGestureRecognizer *gesture2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(twoClick:)];
    gesture2.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:gesture2];
    
    //区分单击、双击手势
    [gesture1 requireGestureRecognizerToFail:gesture2];
    
    //清扫手势  /*默认向右*/
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
    swipeGesture.direction = UISwipeGestureRecognizerDirectionUp; //有上下左右四个方向
    [self.view addGestureRecognizer:swipeGesture];
    
    //平移手势
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:panGesture];
    
    //长按手势
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    longPressGesture.minimumPressDuration = 2.0;  //2秒
    [self.view addGestureRecognizer:longPressGesture];
    
    //旋转手势
    UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotation:)];
    [self.view addGestureRecognizer:rotationGesture];
    
}
//单击
- (void)click:(UITapGestureRecognizer *)tapGesture{
    NSLog(@"单击");
}
//双击
- (void)twoClick:(UITapGestureRecognizer *)tapGesture{
    NSLog(@"双击");
}
//清扫手势
- (void)swipe:(UISwipeGestureRecognizer *)swipeGesture{
    NSLog(@"清扫");
}
//平移手势
- (void)pan:(UIPanGestureRecognizer *)panGesture{
    CGPoint p = [panGesture locationInView:self.view];
    NSLog(@"%@",NSStringFromCGPoint(p));
}
//长按
- (void)longPress:(UILongPressGestureRecognizer *)longPressGesture{
    //判断如果长按结束不打印
    if (longPressGesture.state == UIGestureRecognizerStateEnded) {
        return;
    }
    NSLog(@"长按");
}
//旋转
- (void)rotation:(UIRotationGestureRecognizer *)rotationGesture{
    //弧度转角度
    float degree =  rotationGesture.rotation*(180/M_PI);
    NSLog(@"%f",degree);
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
