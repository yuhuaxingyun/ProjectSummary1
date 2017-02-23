//
//  HsCenterView.h
//  HsUber
//
//  Created by 王金东 on 16/1/19.
//  Copyright © 2016年 王金东. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CenterViewDelegate<NSObject>
- (void)centerViewClick;
@end
@interface HsCenterView : UIView

@property (nonatomic,strong)id<CenterViewDelegate>delegate;


- (void)startLoading;

- (void)showFail:(NSString *)title;

@end
