//
//  ToAnimatedViewController.m
//  AllCodeDataNew
//
//  Created by 宋江 on 16/7/5.
//  Copyright © 2016年 宋江. All rights reserved.
//

#import "ToAnimatedViewController.h"
#import "SJNavTransition.h"
#import "SJInteractiveTransition.h"
@interface ToAnimatedViewController ()

@property (nonatomic,strong)SJInteractiveTransition *interactiveTransition;

@end

@implementation ToAnimatedViewController
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, VIEW_WEDTH, 300)];
    self.imageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.imageView];
    
    self.interactiveTransition = [SJInteractiveTransition interactiveTransitionWithTransitionType:SJInteractiveTransitionTypePop GestureDirection:SJInteractiveTransitionGestureDirectionRight];
    [self.interactiveTransition addPanGestureForViewController:self];
    
}
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    //分pop和push两种情况分别返回动画过渡代理相应不同的动画操作
    SJNavTransition *transition = [SJNavTransition transitionWithType:operation == UINavigationControllerOperationPush ? SJNavTransitionTypePush : SJNavTransitionTypePop];
    return transition;
}
-(id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    return self.interactiveTransition.interation ? self.interactiveTransition :nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
