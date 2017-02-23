//
//  MyCards.m
//  MyDraggingCards
//
//  Created by liqunfei on 16/2/24.
//  Copyright © 2016年 chuchengpeng. All rights reserved.
//

#import "MyCards.h"
#define MAIN_BOUNDS_SIZE [UIScreen mainScreen].bounds.size
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
@implementation MyCards
{
    NSInteger currentIndex;
    CGPoint originPoint;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



- (NSArray *)cards {
    if (!_cards) {
        _cards = [NSArray array];
    }
    return _cards;
}

- (void)drawCards {
    for (int i = ((int)self.cards.count-1); i >= 0; i--) {
        UIImageView *cardImg = [[UIImageView alloc] initWithFrame:CGRectMake(30, 60, MAIN_BOUNDS_SIZE.width - 60, MAIN_BOUNDS_SIZE.height - 150)];
        cardImg.tag = 100 + i;
        cardImg.layer.cornerRadius = 5.0f;
        cardImg.layer.masksToBounds = YES;
        cardImg.transform = CGAffineTransformMakeScale(1-(i > 2?2:i)*0.05, 1-(i > 2?2:i)*0.05);
        cardImg.transform = CGAffineTransformTranslate(cardImg.transform, 0, (i > 2?2:i)*30);
        cardImg.image = [UIImage imageNamed:self.cards[i]];
        originPoint = cardImg.center;
        UILabel *label = [[UILabel alloc] initWithFrame:cardImg.bounds];
        label.center = cardImg.center;
        label.text = [NSString stringWithFormat:@"picture%d",i+1];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:16.0f weight:3.0f];
        [cardImg addSubview:label];
        [self addSubview:cardImg];
    }
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveCards:)];
    [self addGestureRecognizer:pan];
    currentIndex = 0;
}

- (void)moveCards:(UIPanGestureRecognizer *)pan {
    if (pan.state == UIGestureRecognizerStateBegan) {
        if (currentIndex == self.cards.count) {
           [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(resetCard:) userInfo:nil repeats:YES];
        }
    }
    else if (pan.state == UIGestureRecognizerStateChanged) {
        CGPoint offset = [pan translationInView:self];
        UIView *dragView = [self viewWithTag:100+currentIndex];
        dragView.center = CGPointMake(dragView.center.x + offset.x, dragView.center.y+offset.y);
        dragView.transform = CGAffineTransformRotate(dragView.transform, offset.x/MAIN_BOUNDS_SIZE.width*2*M_PI_4);
        [pan setTranslation:CGPointMake(0, 0) inView:self];
    }
    else if (pan.state == UIGestureRecognizerStateEnded) {
        CGPoint endPoint = [pan velocityInView:self];
        UIView *dragView = [self viewWithTag:100+currentIndex];
        if (endPoint.x > 1200 || endPoint.x < -1200) {
            currentIndex++;
            currentIndex = currentIndex>4?4:currentIndex;
            [UIView animateWithDuration:0.3 animations:^{
                dragView.center =CGPointMake(endPoint.x, originPoint.y);
                [self changeFirstCard];
            } completion:^(BOOL finished) {
               
            }];
        }
        else {
            [UIView animateWithDuration:0.4f delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                dragView.center = originPoint;
                dragView.transform = CGAffineTransformIdentity;
            } completion:nil];
        }
    }
}

- (void)resetCards {
    for (int i = ((int)self.cards.count-1); i >= 0; i--) {
        UIImageView *cardImg = [[UIImageView alloc] initWithFrame:CGRectMake(30, 500, MAIN_BOUNDS_SIZE.width - 60, MAIN_BOUNDS_SIZE.height - 150)];
        cardImg.tag = 100 + i;
        cardImg.layer.cornerRadius = 5.0f;
        cardImg.layer.masksToBounds = YES;
        cardImg.transform = CGAffineTransformMakeScale(1-(i > 2?2:i)*0.05, 1-(i > 2?2:i)*0.05);
        cardImg.transform = CGAffineTransformTranslate(cardImg.transform, 0, (i > 2?2:i)*30);
        cardImg.image = [UIImage imageNamed:self.cards[i]];
        originPoint = cardImg.center;
        UILabel *label = [[UILabel alloc] initWithFrame:cardImg.bounds];
        label.center = cardImg.center;
        label.text = [NSString stringWithFormat:@"picture%d",i+1];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:16.0f weight:3.0f];
        [cardImg addSubview:label];
        [self addSubview:cardImg];
    }
}

- (void)changeFirstCard {
    if (currentIndex == self.cards.count) {
       // [self removeFromSuperview];
        
        //自己加的功能，全部结束的时候调用
        UILabel *label = [[UILabel alloc]init];
        label.text = @"Good bay";
        label.frame = CGRectMake(0, self.center.y, SCREEN_WIDTH, 40);
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = SJColor(74, 19, 167, 1.0);
        label.font = [UIFont fontWithName:@"Zapfino" size:14];
        [self addSubview:label];
        
    }
    else {
        for (int i = 0; i < 3; i++) {
            UIView *card = [self viewWithTag:100+currentIndex+i];
            if (card) {
                [UIView animateWithDuration:0.3 animations:^{
                    card.transform = CGAffineTransformMakeScale(1-0.05*i, 1-0.05*i);
                    card.transform = CGAffineTransformTranslate(card.transform, 0, i*30);
                }];
            }
        }
    }
}

- (void)resetCard:(NSTimer *)timer {
    if (currentIndex-- > 0) {
        int scale = (int)MIN(currentIndex, 2);
        UIView *cardView = [self viewWithTag:100+currentIndex];
        cardView.transform = CGAffineTransformMakeScale(1-0.05*scale, 1-0.05*scale);
        cardView.transform = CGAffineTransformTranslate(cardView.transform, 0, scale*30);
        cardView.center = originPoint;
    }
    else {
        [timer invalidate];
    }
    
}
@end
