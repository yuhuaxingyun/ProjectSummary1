//
//  CollectionViewCell.m
//  AllCodeDataNew
//
//  Created by 宋江 on 16/4/7.
//  Copyright © 2016年 宋江. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //添加内部控件
        //imageview
        CGFloat totalWidth = self.frame.size.width;
        CGFloat totalHeight = self.frame.size.height;

        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, totalWidth, totalHeight-33)];
        [self addSubview:_imageView];
        
        //lable
        _lable = [[UILabel alloc] init];
        _lable.font = [UIFont systemFontOfSize:14];
        _lable.frame = CGRectMake(0, CGRectGetMaxY(_imageView.frame), totalWidth, 33);
        _lable.layer.borderColor = [[UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1] CGColor];
        _lable.layer.borderWidth = 0.5f;
        _lable.tintColor = [UIColor redColor];
        _lable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_lable];
        
        //btn
        _btnDelete = [UIButton buttonWithType:UIButtonTypeSystem];
        _btnDelete.frame = CGRectMake(totalWidth-30, 0, 30, 30);
        _btnDelete.backgroundColor = [UIColor brownColor];
        [_btnDelete setTitle:@"X" forState:UIControlStateNormal];
        [self addSubview:_btnDelete];
    }
    return self;
}

@end
