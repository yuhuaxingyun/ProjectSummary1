//
//  CardFlipDragViewController.m
//  AllCodeDataNew
//
//  Created by 宋江 on 16/3/18.
//  Copyright © 2016年 宋江. All rights reserved.
//

#import "CardFlipDragViewController.h"

@interface CardFlipDragViewController ()

@end

@implementation CardFlipDragViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    MyCards *cards = [[MyCards alloc]initWithFrame:self.view.bounds];
    cards.cards = @[@"0",@"1",@"2",@"3"];
    [cards drawCards];
    [self.view addSubview:cards];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
