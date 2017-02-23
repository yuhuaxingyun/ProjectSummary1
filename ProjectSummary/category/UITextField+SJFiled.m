//
//  UITextField+SJFiled.m
//  MapKitScoket
//
//  Created by 宋江 on 16/7/29.
//  Copyright © 2016年 宋江. All rights reserved.
//

#import "UITextField+SJFiled.h"

@implementation UITextField (SJFiled)
/**
 *  创建一个textField
 *
 *  @param imageName   图片名
 *  @param placeHolder 占位字符串
 */
-(void)createTextFieldWithImage:(NSString *)imageName placeHolder:(NSString *)placeHolder
{
    self.backgroundColor = [UIColor whiteColor];
    UIImageView *leftImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    [self leftViewRectForBounds:CGRectMake(0, 0, 60, 60)];
    [self drawPlaceholderInRect:CGRectMake(100, 0, self.frame.size.width-60, self.frame.size.height)];
    self.leftView = leftImageView;
    self.clearButtonMode =  YES;
    self.leftViewMode = UITextFieldViewModeAlways;
    self.placeholder = placeHolder;
    self.layer.borderWidth = 1;
    self.layer.borderColor =[UIColor lightGrayColor].CGColor;
    self.layer.cornerRadius = 2;
    self.returnKeyType = UIReturnKeyDone;
    self.textAlignment = NSTextAlignmentCenter;
    self.font = [UIFont systemFontOfSize:12];
}
@end
