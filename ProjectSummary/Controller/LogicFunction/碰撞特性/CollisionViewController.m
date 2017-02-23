//
//  CollisionViewController.m
//  AllCodeDataNew
//
//  Created by 宋江 on 16/4/11.
//  Copyright © 2016年 宋江. All rights reserved.
//

#import "CollisionViewController.h"

@interface CollisionViewController ()<UICollisionBehaviorDelegate>
{
    UIDynamicAnimator * _animator;
    UIGravityBehavior * _gravity;
    UICollisionBehavior * _ground;
}

@end

@implementation CollisionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView * apple = [[UIView alloc] initWithFrame:CGRectMake(40,40, 40, 40)];
    apple.backgroundColor = [UIColor redColor];
    [self.view addSubview:apple];
    
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    _gravity = [[UIGravityBehavior alloc] initWithItems:@[apple]];
    [_animator addBehavior:_gravity];
    
    _ground = [[UICollisionBehavior alloc] initWithItems:@[apple]];
    _ground.translatesReferenceBoundsIntoBoundary = YES;
    [_animator addBehavior:_ground];
    //new
    _ground.collisionDelegate = self;
    _ground.action = ^{
        NSLog(@"%@, %@",NSStringFromCGAffineTransform(apple.transform), NSStringFromCGPoint(apple.center));
    };
    
}

- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p{
   
    NSLog(@"好疼，我撞在%f,%f,%@",p.x,p.y,identifier);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
