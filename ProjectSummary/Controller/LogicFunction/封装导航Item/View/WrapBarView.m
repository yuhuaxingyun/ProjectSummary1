//
//  WrapBarView.m
//  AllCodeDataNew
//
//  Created by 宋江 on 16/4/18.
//  Copyright © 2016年 宋江. All rights reserved.
//

#import "WrapBarView.h"
#define UPDOWN_LINE_COLOR [UIColor colorWithRed:125/255.0 green:125/255.0 blue:125/255.0 alpha:1.0]
#define SELECT_NAME_COLOR [UIColor colorWithRed:10/255.0 green:29/255.0 blue:30/255.0 alpha:1.0]
#define NOSELECT_NAME_COLOR [UIColor purpleColor]
#define ROLL_LINE_COLOR [UIColor colorWithRed:0 green:58/255.0 blue:166/255.0 alpha:1.0]

@interface WrapBarView ()<UIScrollViewDelegate>

@property (nonatomic,strong)UIView *line;
@property (nonatomic,assign)int index;
@end
@implementation WrapBarView

- (instancetype)initWithFrame:(CGRect)frame name:(NSArray *)nameArray{
    self = [super initWithFrame:frame];
    if (self) {
        _controlArray = [NSMutableArray array];
        [self createUI :nameArray Hight:frame.size.height];
    }
    return self;
}
- (void)createUI:(NSArray *)nameArray Hight:(CGFloat)hight{
    
    //上划线
    UIView *topLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0,self.bounds.size.width ,1)];
    topLine.backgroundColor = UPDOWN_LINE_COLOR;
    [self addSubview:topLine];
    
    CGFloat ControlBarWidth = self.bounds.size.width/nameArray.count;
    CGFloat ControlBarheight = 37.5;
    CGSize barSize = CGSizeMake(ControlBarWidth, ControlBarheight);
    for (int i = 0; i<nameArray.count; i++) {
        
        _controlBar = [[ControlBar alloc]initWithName:nameArray[i] size:barSize];
        [_controlBar addTarget:self action:@selector(changeView:notSelected:) forControlEvents:UIControlEventTouchUpInside];
        _controlBar.tag = i;
        _controlBar.nameLabel.textColor = [UIColor purpleColor];
        [_controlBar setFrame:CGRectMake(i*ControlBarWidth, CGRectGetMaxY(topLine.frame), ControlBarWidth, ControlBarheight)];
        [_controlArray addObject:_controlBar];
        [self addSubview:_controlBar];
        
        if (i == 0) {
            _controlBar.nameLabel.textColor = SELECT_NAME_COLOR;
        }
    }
    //下划线
    UIView *bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_controlBar.frame),self.bounds.size.width ,1)];
    bottomLine.backgroundColor = UPDOWN_LINE_COLOR;
    [self addSubview:bottomLine];
    
    CGFloat tableScrollX = 0;
    CGFloat tableScrollY = CGRectGetMaxY(bottomLine.frame);
    CGFloat tableScrollWidth = self.bounds.size.width;
    CGFloat tableScrollHeight = self.bounds.size.height - 39.5;
    //tableViewView左右滑动
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(tableScrollX,tableScrollY, tableScrollWidth, tableScrollHeight)];
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(nameArray.count*self.bounds.size.width, 0);
    //设置分页
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    [self addSubview:_scrollView];
    
    [self RedLine:0];
    
}
- (void)changeView:(ControlBar *)bar notSelected:(BOOL)selected{
    NSInteger index = [_controlArray indexOfObject:bar];
    
    [self moveLine:index];
    for (int i = 0; i<_controlArray.count; i++) {
        ControlBar * _bar =_controlArray[i];
        if (bar.tag == i) {
            _bar.nameLabel.textColor = SELECT_NAME_COLOR;
            if (selected == NO) {
                _scrollView.contentOffset = CGPointMake(index *self.bounds.size.width, 0);
            }
        }else{
            _bar.nameLabel.textColor = NOSELECT_NAME_COLOR;
        }
        
    }
}
- (void)RedLine:(NSInteger)indexs{
    
    _line= [[UIView alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_controlBar.frame)- 1, self.bounds.size.width/_controlArray.count-40, 2)];
    _line.backgroundColor = ROLL_LINE_COLOR;
    [self addSubview:_line];
    
}
-(void)moveLine:(NSInteger)indexs
{
    [UIView animateWithDuration:0.2 animations:^{
        
        _line.frame = CGRectMake(indexs*self.bounds.size.width/_controlArray.count+20, CGRectGetMaxY(_controlBar.frame) -1, self.bounds.size.width/_controlArray.count-40, 2);
    }];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    _index = _scrollView.bounds.origin.x/_scrollView.bounds.size.width;
    [self moveLine:_index ];
    [self changeView:[_controlArray objectAtIndex:_index] notSelected:YES];
}
@end

