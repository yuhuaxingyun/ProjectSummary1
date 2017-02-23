//
//  AnimatedTransitioning.h
//  AllCodeDataNew
//
//  Created by 宋江 on 16/7/5.
//  Copyright © 2016年 宋江. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  动画过渡代理管理的是push还是pop
 */
typedef NS_ENUM(NSUInteger, SJNavTransitionType) {
    SJNavTransitionTypePush = 0,
    SJNavTransitionTypePop
};
@interface SJNavTransition : NSObject<UIViewControllerAnimatedTransitioning>

+ (instancetype)transitionWithType:(SJNavTransitionType)type;
- (instancetype)initWithTransitionType:(SJNavTransitionType)type;
@end
