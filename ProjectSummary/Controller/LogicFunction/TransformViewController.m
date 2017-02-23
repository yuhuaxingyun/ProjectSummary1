//
//  TransformViewController.m
//  AllCodeDataNew
//
//  Created by 宋江 on 16/4/12.
//  Copyright © 2016年 宋江. All rights reserved.
//

#import "TransformViewController.h"

@interface TransformViewController ()
{
    NSArray *_dataArray;
    float itemY;
    UIImageView *_iamgeView;
    
}
@property(nonatomic,strong)UIView *myView;
@end

@implementation TransformViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createBarItem];
    _dataArray = [[NSArray alloc]initWithObjects:@"单次平移",@"多次平移",@"单次旋转",@"多次旋转",@"缩放",@"绕Y轴旋转",@"透视投影",@"立方体效果",@"弹簧效果",@"彩虹变化",@"清空设置",nil];
    
    _myView = [[UIView alloc]initWithFrame:CGRectMake(20, 300, 60, 60)];
    [self.view addSubview:_myView];
    
    _iamgeView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 100, 120, 120)];
    _iamgeView.image = [UIImage imageNamed:@"0"];
    [self.view addSubview:_iamgeView];
    for (int i = 0; i< _dataArray.count; i++) {
        itemY = 140+i*40;
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(VIEW_WEDTH - 80,itemY, 60,40)];
        btn.tag = i;
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn setTitle:_dataArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}
- (void)createBarItem{
    UIBarButtonItem *backBtnItem = [UIBarButtonItem itemWithImageName:@"Back" target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = backBtnItem;
}
- (void)click:(UIButton *)sender{
    [UIView animateWithDuration:0.4 animations:^{
        if (sender.tag == 0) {
            _iamgeView.transform = CGAffineTransformMakeTranslation(0,140);
        }else if (sender.tag == 1){
            _iamgeView.transform = CGAffineTransformTranslate(_iamgeView.transform, 0, 30);
        }else if (sender.tag == 2){
            _iamgeView.transform = CGAffineTransformMakeRotation(M_PI_2);
        }else if (sender.tag == 3){
            _iamgeView.transform = CGAffineTransformRotate(_iamgeView.transform, M_PI_4);
        }else if (sender.tag == 4){
            _iamgeView.transform = CGAffineTransformScale(_iamgeView.transform,2.0,2.0);
            
//            CGAffineTransform viewTransform = CGAffineTransformConcat(CGAffineTransformMakeScale(.25, .25), CGAffineTransformMakeTranslation(0, 200));
//           _iamgeView.transform= viewTransform;
            
//            _iamgeView.transform = CGAffineTransformMakeScale(.25, .25);
//            _iamgeView.transform = CGAffineTransformTranslate(_iamgeView.transform, 0, 600);
        }else if (sender.tag == 5){
            _iamgeView.layer.transform = CATransform3DMakeRotation(M_PI/6, 0, 1, 0);// 绕Y轴旋转30度后的效果:
     
        }else if (sender.tag ==6){
            CATransform3D rotate = CATransform3DMakeRotation(M_PI/6, 0, 1, 0);
            _iamgeView.layer.transform = CATransform3DPerspect(rotate, CGPointMake(0, 0), 200);
        }else if (sender.tag == 7){
        
            CATransform3D move = CATransform3DMakeTranslation(0, 0, 160);
            CATransform3D back = CATransform3DMakeTranslation(0, 0, -160);
            
            CATransform3D rotate0 = CATransform3DMakeRotation(-10, 0, 1, 0);

            
            CATransform3D mat0 = CATransform3DConcat(CATransform3DConcat(move, rotate0), back);
            
            _iamgeView.layer.transform = CATransform3DPerspect(mat0, CGPointZero, 500);

        }else{
           _iamgeView.transform = CGAffineTransformIdentity;
        }

    }];
//[UIView animateWithDuration:0.2 delay:0 options:0 animations:^{
//
//} completion:^(BOOL finished) {
//    
//}];
    
    /*动画过滤效果
     
    UIViewKeyframeAnimationOptionCalculationModeLinear     = 0 << 10, // default
    UIViewKeyframeAnimationOptionCalculationModeDiscrete   = 1 << 10,
    UIViewKeyframeAnimationOptionCalculationModePaced      = 2 << 10,
    UIViewKeyframeAnimationOptionCalculationModeCubic      = 3 << 10,
    UIViewKeyframeAnimationOptionCalculationModeCubicPaced = 4 << 10
     */
    if (sender.tag == 8) {
        [UIView animateWithDuration:0.5 //动画时长
                              delay:0   //动画延时
             usingSpringWithDamping:0.4   //类似弹簧效果0~1f，数值越小「弹簧」的振动效果越明显
              initialSpringVelocity:0.1   //初始速度
                            options:0   //动画过滤效果
                         animations:^{
            _iamgeView.transform = CGAffineTransformMakeTranslation(0,340);
        } completion:^(BOOL finished) {
            
        }];
    }else if (sender.tag == 9){
        [UIView animateKeyframesWithDuration:4.0
                                       delay:0.0
                                     options:UIViewKeyframeAnimationOptionCalculationModeCubic | UIViewAnimationOptionCurveLinear
                                  animations:^{
                                      [self runAnimateKeyframes];
                                  }completion:^(BOOL finished) {
                                      // 动画完成后执行
                                      // code...
                                  }];

    }
}
CATransform3D CATransform3DMakePerspective(CGPoint center, float disZ){
    CATransform3D transToCenter = CATransform3DMakeTranslation(-center.x, -center.y, 0);
    CATransform3D transBack = CATransform3DMakeTranslation(center.x, center.y, 0);
    CATransform3D scale = CATransform3DIdentity;
    scale.m34 = -1.0f/disZ;
    return CATransform3DConcat(CATransform3DConcat(transToCenter, scale), transBack);
}

CATransform3D CATransform3DPerspect(CATransform3D t, CGPoint center, float disZ){
    return CATransform3DConcat(t, CATransform3DMakePerspective(center, disZ));
}
- (void)runAnimateKeyframes{
        // 创建颜色数组
        NSArray *arrayColors = @[[UIColor orangeColor],
                                 [UIColor yellowColor],
                                 [UIColor greenColor],
                                 [UIColor blueColor],
                                 [UIColor purpleColor],
                                 [UIColor redColor]];
        NSUInteger colorCount = [arrayColors count];
        // 循环添加关键帧
        for (NSUInteger i = 0; i < colorCount; i++) {
            [UIView addKeyframeWithRelativeStartTime:i / (CGFloat)colorCount
                                    relativeDuration:1 / (CGFloat)colorCount
                                          animations:^{
                                              [_myView setBackgroundColor:arrayColors[i]];
                                          }];
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
