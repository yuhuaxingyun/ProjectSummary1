//
//  ChatCell.m
//  chat
//
//  Created by T_Yang on 15/9/2.
//  Copyright © 2015年 杨 天. All rights reserved.
//

#import "ChatCell.h"
#import "ChatFrameModel.h"

@interface ChatCell ()
@property (nonatomic, weak) UILabel *bytesLabel;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIButton *contentBtn;
@property (nonatomic, weak) UIImageView *iconImageView;
@end

@implementation ChatCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self addGestureRecognizer: [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longTap:)]];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = SJColor(240, 240, 240,1.0);
        
        UILabel *titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:titleLabel];
        self.titleLabel = titleLabel;
        titleLabel.textAlignment = NSTextAlignmentRight;
        titleLabel.font = [UIFont systemFontOfSize:10];
        titleLabel.textColor = SJColor(102, 102, 102, 1.0);
        titleLabel.clipsToBounds = YES;
        
        UILabel *bytesLabel = [[UILabel alloc] init];
        [self.contentView addSubview:bytesLabel];
        self.bytesLabel = bytesLabel;
        bytesLabel.textAlignment = NSTextAlignmentCenter;
        bytesLabel.font = [UIFont systemFontOfSize:10];
        bytesLabel.textColor = SJColor(53, 163, 242, 1.0);
        bytesLabel.clipsToBounds = YES;
        
        UIImageView *iconImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:iconImageView];
        self.iconImageView = iconImageView;
        iconImageView.layer.cornerRadius = 22.5;
        iconImageView.layer.masksToBounds = YES;
        iconImageView.layer.borderWidth = 1.0f;
        
        UIButton *contentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:contentBtn];
        self.contentBtn = contentBtn;
        UIImage *btnBackImage = [UIImage imageNamed:@"chat_send_nor"];
        [contentBtn setBackgroundImage:[btnBackImage stretchableImageWithLeftCapWidth:btnBackImage.size.width / 2
                                                                         topCapHeight:btnBackImage.size.height / 2]
                              forState:UIControlStateNormal];
        [contentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        contentBtn.titleLabel.numberOfLines = 0;
        contentBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        contentBtn.titleEdgeInsets = UIEdgeInsetsMake(20, 20, 20, 20);
    }
    return self;
}

- (void)setFrameModel:(ChatFrameModel *)frameModel {
    _frameModel = frameModel;
    
    [self setSubviewsData];
    
    [self setSubviewsFrame];
}

- (void)setSubviewsData {

    self.titleLabel.text = self.frameModel.chatModel.time;
    [self.contentBtn setTitle:self.frameModel.chatModel.text forState:UIControlStateNormal];
    if ([self.frameModel.chatModel.type isEqualToNumber:@0]) {
        self.bytesLabel.text = self.frameModel.chatModel.bytes;
        self.iconImageView.image = [UIImage imageNamed:@"Head Portrait"];
        UIImage *btnBackImage = [UIImage imageNamed:@"dialogrRight"];
        [self.contentBtn setBackgroundImage:[btnBackImage stretchableImageWithLeftCapWidth:btnBackImage.size.width / 2
                                                                         topCapHeight:btnBackImage.size.height / 2]
                              forState:UIControlStateNormal];
        UIImage *btnBackImageHelight = [UIImage imageNamed:@"dialogrRight"];
        [self.contentBtn setBackgroundImage:[btnBackImageHelight stretchableImageWithLeftCapWidth:btnBackImageHelight.size.width / 2
                                                                              topCapHeight:btnBackImageHelight.size.height / 2]
                                   forState:UIControlStateHighlighted];
    }else {
        self.bytesLabel.text = self.frameModel.chatModel.bytes;
        self.iconImageView.image = [UIImage imageNamed:self.frameModel.chatModel.wifiOrBlue];
        UIImage *btnBackImage = [UIImage imageNamed:@"dialogrLeft"];
        [self.contentBtn setBackgroundImage:[btnBackImage stretchableImageWithLeftCapWidth:btnBackImage.size.width / 2
                                                                              topCapHeight:btnBackImage.size.height / 2]
                                   forState:UIControlStateNormal];
        UIImage *btnBackImageHelight = [UIImage imageNamed:@"dialogrLeft"];
        [self.contentBtn setBackgroundImage:[btnBackImageHelight stretchableImageWithLeftCapWidth:btnBackImageHelight.size.width / 2
                                                                              topCapHeight:btnBackImageHelight.size.height / 2]
                                   forState:UIControlStateHighlighted];
    }
}

- (void)setSubviewsFrame {
    self.bytesLabel.frame = self.frameModel.bytesLabelFrame;
    self.titleLabel.frame = self.frameModel.titleLabelFrame;
    self.contentBtn.frame = self.frameModel.contentBtnFrame;
    self.iconImageView.frame = self.frameModel.iconImageViewFrame;
}
-(void)longTap:(UILongPressGestureRecognizer *)longRecognizer
{
    if (longRecognizer.state==UIGestureRecognizerStateBegan) {
        
        [self becomeFirstResponder];
        
        UIMenuItem *copyItem = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copyItemClicked:)];
        
        UIMenuController *menu=[UIMenuController sharedMenuController];
        
        [menu setMenuItems:[NSArray arrayWithObjects:copyItem,nil]];
        
        [menu setTargetRect:self.contentBtn.bounds inView:self.contentBtn];
        
        [menu setMenuVisible:YES animated:YES];
    }
}

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    
    if(action == @selector(copyItemClicked:)){
        
        return YES;
        
    }
    return [super canPerformAction:action withSender:sender];
}
-(void)copyItemClicked:(UIMenuItem* )sender{
    NSLog(@"复制");
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.contentBtn.titleLabel.text;
}

//实现成为第一响应者方法
-(BOOL)canBecomeFirstResponder{
    return YES;
}

@end
