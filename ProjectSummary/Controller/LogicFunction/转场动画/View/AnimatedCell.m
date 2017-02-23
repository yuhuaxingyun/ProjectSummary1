//
//  VCAnimatedCell.m
//  AllCodeDataNew
//
//  Created by 宋江 on 16/7/5.
//  Copyright © 2016年 宋江. All rights reserved.
//

#import "AnimatedCell.h"

@implementation AnimatedCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
- (void)createUI{
    
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,self.bounds.size.width,self.bounds.size.height)];
    [self.contentView addSubview:_imageView];
}
@end
