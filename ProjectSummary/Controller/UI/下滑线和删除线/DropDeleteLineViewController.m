//
//  DropDeleteLineViewController.m
//  AllCodeDataNew
//
//  Created by 宋江 on 16/6/7.
//  Copyright © 2016年 宋江. All rights reserved.
//
// NSUnderlineStyleNone   不设置删除线
// NSUnderlineStyleSingle 设置删除线为细单实线
// NSUnderlineStyleThick  设置删除线为粗单实线
// NSUnderlineStyleDouble 设置删除线为细双实线
#import "DropDeleteLineViewController.h"

@interface DropDeleteLineViewController ()

@end

@implementation DropDeleteLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *oldPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 30)];
    NSString *oldPrice = @"¥ 1234566666666";
    NSUInteger length = [oldPrice length];
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid |  NSUnderlineStyleSingle) range:NSMakeRange(2, length-2)];
    [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor redColor] range:NSMakeRange(2, length-2)];
    [oldPriceLabel setAttributedText:attri];
    [self.view addSubview:oldPriceLabel];
    
    
    UIButton *awardDisplayBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 100,self.view.bounds.size.width, 30)];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"查看所有中奖记录"];
    NSRange strRange = {0,[str length]};
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
    [awardDisplayBtn setAttributedTitle:str forState:UIControlStateNormal];
    [self.view addSubview:awardDisplayBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
