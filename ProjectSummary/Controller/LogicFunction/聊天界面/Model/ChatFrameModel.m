//
//  ChatFrameModel.m
//  chat
//
//  Created by T_Yang on 15/9/2.
//  Copyright © 2015年 杨 天. All rights reserved.
//

#import "ChatFrameModel.h"

@implementation ChatFrameModel

- (void)setChatModel:(ChatModel *)chatModel {
    _chatModel = chatModel;
    
    //设置标题label的高度 如果相同 高度为0 即不显示
    CGFloat titleLabelHeight = chatModel.hiddenTime ? 0 : 30;
    
//    _titleLabelFrame = CGRectMake(0, 0, SCREEN_WIDTH, titleLabelHeight);

#define kContentBtnWidth (contentBtnSize.width + 40)
#define kContentBtnHeight (contentBtnSize.height + 35)
    
    //间距
    CGFloat margin = 15;
    //头像大小
    CGFloat iconWH = 45;
    //文字大小
    CGSize contentBtnSize = [self sizeWithText:_chatModel.text];
    //头像大小 50 * 50
    if ([_chatModel.type isEqualToNumber:@0]) {
        
        _iconImageViewFrame = CGRectMake(SCREEN_WIDTH - iconWH - margin, 24, iconWH, iconWH);
        
        _contentBtnFrame = CGRectMake(SCREEN_WIDTH - kContentBtnWidth - iconWH - margin - margin,
                                      24,
                                      kContentBtnWidth,
                                      kContentBtnHeight);
        
        _titleLabelFrame = CGRectMake(CGRectGetMaxX(_contentBtnFrame) -120 , CGRectGetMaxY(_contentBtnFrame), 110, titleLabelHeight);
        _bytesLabelFrame = CGRectMake(CGRectGetMinX(_titleLabelFrame)- 50,CGRectGetMaxY(_contentBtnFrame), 50, titleLabelHeight);

    }else {
        
        _iconImageViewFrame = CGRectMake(margin, 24, iconWH, iconWH);
        
        _contentBtnFrame = CGRectMake(margin + iconWH + margin,
                                      24,
                                      kContentBtnWidth,
                                      kContentBtnHeight);
//        _titleLabelFrame = CGRectMake(0, CGRectGetMaxY(_contentBtnFrame), SCREEN_WIDTH, titleLabelHeight);
        _titleLabelFrame = CGRectMake(CGRectGetMinX(_contentBtnFrame) +10 , CGRectGetMaxY(_contentBtnFrame), 110, titleLabelHeight);
        _bytesLabelFrame = CGRectMake(CGRectGetMaxX(_titleLabelFrame),CGRectGetMaxY(_contentBtnFrame), 50, titleLabelHeight);
    }
    _cellHeight = MAX(CGRectGetMaxY(_contentBtnFrame), CGRectGetMaxY(_titleLabelFrame)) + margin;
}

- (CGSize)sizeWithText:(NSString *)text {
    return [text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 180, MAXFLOAT)
                              options:NSStringDrawingUsesLineFragmentOrigin
                           attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]}
                              context:nil].size;
}

@end
