//
//  MyCards.h
//  MyDraggingCards
//
//  Created by liqunfei on 16/2/24.
//  Copyright © 2016年 chuchengpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCards : UIView
@property (nonatomic,strong) NSArray *cards;
- (void)drawCards;
@end
