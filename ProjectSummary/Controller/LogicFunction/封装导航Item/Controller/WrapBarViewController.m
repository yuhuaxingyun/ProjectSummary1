//
//  WrapBarViewController.m
//  AllCodeDataNew
//
//  Created by 宋江 on 16/4/18.
//  Copyright © 2016年 宋江. All rights reserved.
//
/**
 *
 *   status bar height: 20pts
 *   navigation bar height: 44pts
 *   nav bar icons: 20 x 20 pts
 *   tab bar icons: 30 x 30 pts
 *   tab bar height: 49pts
 *   封装的bar 总高 39.5
 *   封装的view高度 : 屏幕的高度 - 64 - 49 - label的高度
 *   scrollView中View的高度: 屏幕的高度 - 64 - 49 - 39.5(封装的bar的高度)
 *
 **/
#import "WrapBarViewController.h"
#import "WrapBarView.h"
@interface WrapBarViewController ()
{
    WrapBarView *_wrapBarView;
}
@property (nonatomic,assign)int index;
@end

@implementation WrapBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *nameBarArray = [[NSArray alloc]initWithObjects:@"我下载的",@"我上传的",@"正在下载的",@"哈哈", nil];
    _wrapBarView = [[WrapBarView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height -99) name:nameBarArray];
    [self.view addSubview:_wrapBarView];
    
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 138.5)];
    view1.backgroundColor = [UIColor orangeColor];
    [_wrapBarView.scrollView addSubview:view1];
    
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height- 138.5)];
    view2.backgroundColor = [UIColor purpleColor];
    [_wrapBarView.scrollView addSubview:view2];
    
    UIView *view3 = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width *2, 0, self.view.frame.size.width, self.view.frame.size.height- 138.5)];
    view3.backgroundColor = [UIColor greenColor];
    [_wrapBarView.scrollView addSubview:view3];
    NSLog(@"%lf",CGRectGetMaxY(_wrapBarView.frame));
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_wrapBarView.frame), self.view.frame.size.width, 50)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor grayColor];
    label.layer.borderColor = [UIColor purpleColor].CGColor;
    label.layer.borderWidth = 1;
    label.text = @"此控件是加载在self.view上";
    [self.view addSubview:label];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
