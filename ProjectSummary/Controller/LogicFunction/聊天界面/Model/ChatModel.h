//
//  ChatModel.h
//  chat
//
//  Created by T_Yang on 15/9/2.
//  Copyright © 2015年 杨 天. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatModel : NSObject

@property (nonatomic, copy) NSString *bytes;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, strong) NSNumber *type;
@property (nonatomic,strong)NSString *wifiOrBlue;

@property (nonatomic, assign, getter = isHiddenTime) BOOL hiddenTime;

@end
