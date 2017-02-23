//
//  SJInteractiveTransition.h
//  AllCodeDataNew
//
//  Created by 宋江 on 16/7/6.
//  Copyright © 2016年 宋江. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^GestureConfig)();
typedef NS_ENUM(NSUInteger,SJInteractiveTransitionGestureDirection) {
    SJInteractiveTransitionGestureDirectionLeft = 0,
    SJInteractiveTransitionGestureDirectionRight,
    SJInteractiveTransitionGestureDirectionUp,
    SJInteractiveTransitionGestureDirectionDown
};
typedef NS_ENUM(NSUInteger,SJInteractiveTransitionType) {
    SJInteractiveTransitionTypePresent = 0,
    SJInteractiveTransitionTypeDismiss,
    SJInteractiveTransitionTypePush,
    SJInteractiveTransitionTypePop,
};
@interface SJInteractiveTransition : UIPercentDrivenInteractiveTransition

/**记录是否开始手势，判断pop操作是手势触发还是返回键触发*/
@property (nonatomic, assign) BOOL interation;
/**促发手势present的时候的config，config中初始化并present需要弹出的控制器*/
@property (nonatomic, copy) GestureConfig presentConifg;
/**促发手势push的时候的config，config中初始化并push需要弹出的控制器*/
@property (nonatomic, copy) GestureConfig pushConifg;

//初始化方法

+ (instancetype)interactiveTransitionWithTransitionType:(SJInteractiveTransitionType)type GestureDirection:(SJInteractiveTransitionGestureDirection)direction;
- (instancetype)initWithTransitionType:(SJInteractiveTransitionType)type GestureDirection:(SJInteractiveTransitionGestureDirection)direction;

- (void)addPanGestureForViewController:(UIViewController *)viewController;
@end
