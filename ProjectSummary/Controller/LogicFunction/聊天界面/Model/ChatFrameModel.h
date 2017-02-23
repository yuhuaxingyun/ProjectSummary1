//
//  ChatFrameModel.h
//  chat
//
//  Created by T_Yang on 15/9/2.
//  Copyright © 2015年 杨 天. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatModel.h"

@interface ChatFrameModel : NSObject

@property (nonatomic, assign, readonly) CGRect bytesLabelFrame;
@property (nonatomic, assign, readonly) CGRect titleLabelFrame;
@property (nonatomic, assign, readonly) CGRect contentBtnFrame;
@property (nonatomic, assign, readonly) CGRect iconImageViewFrame;
/**
 *  行高
 */
@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, strong) ChatModel *chatModel;

@end
