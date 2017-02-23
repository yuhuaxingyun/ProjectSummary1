//
//  AnimatedTransitioning.m
//  AllCodeDataNew
//
//  Created by 宋江 on 16/7/5.
//  Copyright © 2016年 宋江. All rights reserved.
//

#import "SJNavTransition.h"
#import "AnimatedViewController.h"
#import "ToAnimatedViewController.h"

@interface SJNavTransition ()
/**
 *  动画过渡代理管理的是push还是pop
 */
@property (nonatomic, assign)SJNavTransitionType type;

@end
@implementation SJNavTransition
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5f;
}
+ (instancetype)transitionWithType:(SJNavTransitionType)type{
    return [[self alloc] initWithTransitionType:type];
}
- (instancetype)initWithTransitionType:(SJNavTransitionType)type{
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    switch (_type) {
        case SJNavTransitionTypePush:
            [self PushAnimation:transitionContext];
            break;
            
        case SJNavTransitionTypePop:
            [self PopAnimation:transitionContext];
            break;
    }
    
}
- (void)PushAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    AnimatedViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    ToAnimatedViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *contrainer = [transitionContext containerView];
    
    UIView *snapShotView = [fromVC.selectedCell.imageView snapshotViewAfterScreenUpdates:NO];
    snapShotView.frame = [contrainer convertRect:fromVC.selectedCell.imageView.frame fromView:fromVC.selectedCell.imageView];
    fromVC.selectedCell.imageView.hidden = YES;
    
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.alpha = 0;
    
    [contrainer addSubview:toVC.view];
    [contrainer addSubview:snapShotView];
    
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0f usingSpringWithDamping:0.8f  initialSpringVelocity:0.0f  options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [contrainer layoutIfNeeded];
                         toVC.view.alpha = 1.0;
                         snapShotView.frame = toVC.imageView.frame;
                         
                     } completion:^(BOOL finished) {
                         fromVC.selectedCell.imageView.hidden = NO;
                         toVC.imageView.image = toVC.image;
                         [snapShotView removeFromSuperview];
                         [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
                     }];


}
- (void)PopAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{

    ToAnimatedViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    AnimatedViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *contrainer = [transitionContext containerView];
    UIView *snapShotView = [fromVC.imageView snapshotViewAfterScreenUpdates:NO];
    snapShotView.frame  = [contrainer convertRect:fromVC.imageView.frame fromView:fromVC.view];
    fromVC.imageView.hidden = YES;
    
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    
    toVC.selectedCell.imageView.hidden = YES;
    
    [contrainer insertSubview:toVC.view belowSubview:fromVC.view];
    [contrainer addSubview:snapShotView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0f usingSpringWithDamping:0.8f  initialSpringVelocity:0.0f  options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         fromVC.view.alpha = 0.0;
                         snapShotView.frame = [contrainer convertRect:toVC.selectedCell.imageView.frame fromView:toVC.selectedCell];
                         
                     } completion:^(BOOL finished) {
                         fromVC.imageView.hidden = NO;
                         toVC.selectedCell.imageView.hidden = NO;
                         [snapShotView removeFromSuperview];
                         [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
                     }];

    
    
    
}
@end
