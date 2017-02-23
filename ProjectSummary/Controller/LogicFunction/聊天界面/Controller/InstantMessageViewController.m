//
//  InstantMessageViewController.m
//  ProjectSummary
//
//  Created by baolicheng on 2017/2/21.
//  Copyright © 2017年 RenRenFenQi. All rights reserved.
//

#import "InstantMessageViewController.h"
#import "ChatCell.h"
#import "ChatFrameModel.h"
#import "NSObject+MJKeyValue.h"
@interface InstantMessageViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIScrollViewDelegate>
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, weak) UITableView *tableView;


@property (nonatomic, strong)UIView *toolView;
@property (nonatomic, strong)UITextField *inputField;
@end

@implementation InstantMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavBar];
    [self barbtnItem];
    [self createTableView];
    
    [self createBottomView];
}
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        NSArray *data = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"messages" ofType:@"plist"]];
        NSMutableArray *tempArray = [NSMutableArray array];
        
        ChatModel *lastModel;
        for (NSDictionary *dic in data) {
            ChatFrameModel *chatFrameModel = [[ChatFrameModel alloc] init];
            ChatModel *chatModel = [ChatModel objectWithKeyValues:dic];
            chatModel.wifiOrBlue = @"Head-WIFI";

            //先赋值chatModel用于判断上一个model与这个model的时间是否一样 直接调用frame模型的set方法就晚了 没法hiddenTime设置成NO
            if ([chatModel.time isEqualToString:lastModel.time]) {
                chatModel.hiddenTime = YES;
            }else {
                chatModel.hiddenTime = NO;
            }
            chatFrameModel.chatModel = chatModel;
            
            [tempArray addObject:chatFrameModel];
            
            lastModel = chatFrameModel.chatModel;
        }
        //一句话可将字典数组转换成模型数组
        //        _dataArray = [ChatModel objectArrayWithKeyValuesArray:data];//tempArray;
        _dataArray = tempArray;
    }
    return _dataArray;
}

- (void)createTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 50- 64)
                                                          style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    [tableView registerClass:[ChatCell class] forCellReuseIdentifier:@"ChatCell"];
    tableView.backgroundColor = SJColor(240, 240, 240,1.0);
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //监听键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)createBottomView {
    //初始化toolView
    
    _toolView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 50 -64, SCREEN_WIDTH, 50)];
    _toolView.backgroundColor = SJColor(246, 246, 246, 1.0);
    [self.view addSubview:_toolView];
    
    
    _inputField = [[UITextField alloc] initWithFrame:CGRectMake(5, 5, SCREEN_WIDTH - 65, 40)];
    _inputField.delegate = self;
    _inputField.returnKeyType = UIReturnKeyDone;
    _inputField.backgroundColor = [UIColor whiteColor];
    _inputField.borderStyle = UITextBorderStyleRoundedRect;
    //    _inputField.enablesReturnKeyAutomatically = YES;
    _inputField.keyboardType = UIKeyboardTypeASCIICapable;//(根据个人喜好设置键盘)
    _inputField.placeholder = @"请输入十六进制数据";
    [_inputField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    
    [_toolView addSubview:_inputField];
    
    UIButton *sendBtn = [[UIButton alloc]initWithFrame:CGRectMake(_toolView.bounds.size.width - 55 , 5, 50,  _toolView.bounds.size.height - 10)];
    [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    [sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendBtn setTitleColor:SJColor(157, 157, 157, 1.0) forState:UIControlStateNormal];
    sendBtn.layer.cornerRadius = 5;
    sendBtn.titleLabel.font = SJFont(15);
    [sendBtn addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchUpInside];
    [_toolView addSubview:sendBtn];
    
}

#pragma mark - UITableViewDelegate & DataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.dataArray[indexPath.row] cellHeight];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChatCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChatCell" forIndexPath:indexPath];
    cell.frameModel = self.dataArray[indexPath.row];
    if (indexPath.row %3==1) {
        cell.backgroundColor = [UIColor brownColor];
    }
    
    return cell;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if ([ToolMothod Hexadecimal:string] ||[string isEqualToString:@""]) {
        return YES;
    }
    return NO;
}
- (void)textFieldChanged:(UITextField *)textField {
    
    NSString *toBeString = textField.text;
    
    if (toBeString.length>0) {
        textField.text = toBeString;
    }
}
- (void)sendMessage{
    
    if (_inputField.text.length>0) {
        [self sendText:_inputField.text type:[NSNumber numberWithBool:NO] bytes:_inputField.text.length/2];
    }
    
    NSLog(@"message : %@",_inputField.text);
    _inputField.text = nil;
    
}

//实现成为第一响应者方法
-(BOOL)canBecomeFirstResponder{
    return YES;
}
-(NSData*) hexToBytes:(NSString *)str {
    NSMutableData* data = [NSMutableData data];
    int idx;
    for (idx = 0; idx+2 <= str.length; idx+=2) {
        NSRange range = NSMakeRange(idx, 2);
        NSString* hexStr = [str substringWithRange:range];
        NSScanner* scanner = [NSScanner scannerWithString:hexStr];
        unsigned int intValue;
        [scanner scanHexInt:&intValue];
        [data appendBytes:&intValue length:1];
    }
    return data;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

/**
 *  模拟发送信息
 *
 *  @param text 要发送的消息
 */
- (void)sendText:(NSString *)text type:(NSNumber *)type bytes:(NSInteger)bytes{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    //模拟聊天
    ChatModel *chatModel = [[ChatModel alloc] init];
    chatModel.text = text;
    chatModel.time = [formatter stringFromDate:date];;
    chatModel.type = type;
    //    chatModel.bytes = [NSString stringWithFormat:@"%ld",(long)bytes] ;
    chatModel.bytes = [NSString stringWithFormat:@"Tx: %ld",(long)bytes] ;
    
    ChatModel *lastModel = [[self.dataArray lastObject] chatModel];
    if ([chatModel.text isEqualToString:lastModel.text]) {
        chatModel.hiddenTime = YES;
    }else {
        chatModel.hiddenTime = NO;
    }
    
    ChatFrameModel *frameModel = [[ChatFrameModel alloc] init];
    frameModel.chatModel = chatModel;
    
    [self.dataArray addObject:frameModel];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.dataArray.count - 1 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath]
                          withRowAnimation:UITableViewRowAnimationBottom];
    [self.tableView scrollToRowAtIndexPath:indexPath
                          atScrollPosition:UITableViewScrollPositionBottom
                                  animated:YES];
}
/**
 *  模拟接收信息
 *
 *  @param text 要接受的消息
 */
- (void)receiveText:(NSString *)text type:(NSNumber *)type bytes:(NSInteger)bytes{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    //模拟聊天
    ChatModel *chatModel = [[ChatModel alloc] init];
    chatModel.text = text;
    chatModel.wifiOrBlue = @"Head-WIFI";

    
    chatModel.time = [formatter stringFromDate:date];;
    chatModel.type = type;
    //    chatModel.bytes = [NSString stringWithFormat:@"%ld",(long)bytes] ;
    chatModel.bytes = [NSString stringWithFormat:@"Rx: %ld",(long)bytes] ;
    
    ChatModel *lastModel = [[self.dataArray lastObject] chatModel];
    if ([chatModel.text isEqualToString:lastModel.text]) {
        chatModel.hiddenTime = YES;
    }else {
        chatModel.hiddenTime = NO;
    }
    
    ChatFrameModel *frameModel = [[ChatFrameModel alloc] init];
    frameModel.chatModel = chatModel;
    
    [self.dataArray addObject:frameModel];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.dataArray.count - 1 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath]
                          withRowAnimation:UITableViewRowAnimationBottom];
    [self.tableView scrollToRowAtIndexPath:indexPath
                          atScrollPosition:UITableViewScrollPositionBottom
                                  animated:YES];
}
/**
 *  模拟QQ上划一定程度后直接进入聊天状态
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([self.inputView isEditing] || scrollView.contentOffset.y - (scrollView.contentSize.height - SCREEN_HEIGHT) <= 200) return;
    //    NSLog(@"%lf---%lf", scrollView.contentOffset.y, scrollView.contentSize.height - kHeight);
    [self.inputView becomeFirstResponder];
}
- (void)initNavBar
{
    self.navigationItem.title = @"即时通信";
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)barbtnItem{
    UIBarButtonItem *backItem = [UIBarButtonItem itemWithImageName:@"Back" target:self action:@selector(back)];
    
    self.navigationItem.leftBarButtonItem = backItem;
    
}
- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -
#pragma mark close Keyboard
- (void) textFieldDoneEditing:(id)sender{
    [sender resignFirstResponder];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

/**
 *  当键盘改变了frame(位置和尺寸)的时候调用
 */
- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    // 设置窗口的颜色
    self.view.window.backgroundColor = _tableView.backgroundColor;
    
    // 0.取出键盘动画的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 1.取得键盘最后的frame
    CGRect keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 2.计算控制器的view需要平移的距离
    CGFloat transformY = keyboardFrame.origin.y - self.view.frame.size.height;
    
    // 3.执行动画
    
    [UIView animateWithDuration:duration animations:^{
        self.view.origin = CGPointMake(0, transformY);
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
