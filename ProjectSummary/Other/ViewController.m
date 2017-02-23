//
//  ViewController.m
//  ProjectSummary
//
//  Created by baolicheng on 2017/2/17.
//  Copyright © 2017年 RenRenFenQi. All rights reserved.
//

#import "ViewController.h"
#import "SJHeadFile.h"
@interface ViewController ()
@property(nonatomic,strong)NSArray *dataArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"首页";
    self.dataArray = [[NSArray alloc]initWithObjects:@"字体样式",@"CollectionView",@"DatePicker",@"AlertView",@"MapKit",@"Music",@"文件管理",@"transform动画",@"语音1",@"录制播放语音",@"自定义分享",@"封装导航Item",@"折线图库",@"二维码",@"coreBlue",@"Alipay支付",@"转场动画",@"视频",@"Search",@"散开Btn",@"即时通信",@"卡片拖拽",@"下滑和删除线",@"粒子发射器",@"文字转图片",@"碰撞特性",@"多种手势",@"",@"",@"",@"", @"",@"",@"",@"",@"",@"",@"",@"" ,@"",@"", @"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"" ,@"",@"", @"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"", nil];
    [self createBarItem];
    [self createUI];
}
- (void)createBarItem{
    UIBarButtonItem *backBtnItem = [UIBarButtonItem itemWithImageName:@"" target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = backBtnItem;
}

- (void)createUI{
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    scrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 1000);
    [self.view addSubview:scrollView];
    
    CGFloat itemX;
    CGFloat itemY;
    for (int i = 0; i<self.dataArray.count; i++) {
        itemX= 30 +i%6*(SCREEN_WIDTH-60)/6 ;
        itemY = (SCREEN_WIDTH-60)/6 + i/6*80;

        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(itemX, itemY, (SCREEN_WIDTH-60)/6, (SCREEN_WIDTH-60)/6)];
        [btn setTitle:_dataArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor whiteColor];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        btn.layer.cornerRadius =30;
        btn.tag = i;
        [btn addTarget:self action:@selector(Other:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:btn];
    }
}
- (void)Other:(UIButton *)btn{
    if (btn.tag == 0) {
        LogicFunctionController *logicFunctionVC = [[LogicFunctionController alloc]init];
        [self.navigationController pushViewController:logicFunctionVC animated:YES];
        
    }else if (btn.tag == 1){
        CollectionViewController *collectionVC = [[CollectionViewController alloc]init];
        [self.navigationController pushViewController:collectionVC animated:YES];
    }else if (btn.tag == 2){
        DatePickViewController *datePickVC = [[DatePickViewController alloc]init];
        [self.navigationController pushViewController:datePickVC animated:YES];
    }else if (btn.tag == 3){
        if (IOS_8) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提醒" message:@"火烧屁股了～～·" preferredStyle:UIAlertControllerStyleAlert];
            
            // 创建按钮
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
                
                NSLog(@"YES");
            }];
            // 创建按钮
            // 注意取消按钮只能添加一个
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction *action) {
                // 点击按钮后的方法直接在这里面写
                NSLog(@"NO");
            }];
            
            //创建警告按钮
//            UIAlertAction *structlAction = [UIAlertAction actionWithTitle:@"警告" style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction *action) {
//                NSLog(@"注意学习");
//            }];
            
            [alert addAction:okAction];
            [alert addAction:cancelAction];
//            [alert addAction:structlAction];
            [self presentViewController:alert animated:YES completion:nil];
        }else{
            
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提醒" message:@"火烧眉毛了～～·" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alertView show];
        }
    }else if (btn.tag == 4){
        MapKitViewController *mapKitVC = [[MapKitViewController alloc]init];
        [self.navigationController pushViewController:mapKitVC animated:YES];
        
    }else if (btn.tag == 5){
        MusicViewController *musicVC = [[MusicViewController alloc]init];
        [self.navigationController pushViewController:musicVC animated:YES];
        
    }else if (btn.tag == 6){
        FileManagementViewController *fileManagementVC = [[FileManagementViewController alloc]init];
        [self.navigationController pushViewController:fileManagementVC animated:YES];
    }else if (btn.tag == 7){
        TransformViewController *transformVC = [[TransformViewController alloc]init];
        [self.navigationController pushViewController:transformVC animated:YES];
    }else if (btn.tag == 8){
        VoiceViewController *voiceVC = [[VoiceViewController alloc]init];
        [self.navigationController pushViewController:voiceVC animated:YES];
    }else if (btn.tag == 9){
        VoiceRecordingViewController *voiceRecordingVC = [[VoiceRecordingViewController alloc]init];
        [self.navigationController pushViewController:voiceRecordingVC animated:YES];
        
    }else if (btn.tag == 10){
        UMSRootViewController *UMSRootVC = [[UMSRootViewController alloc]init];
        [self.navigationController pushViewController:UMSRootVC animated:YES];
        
    }else if (btn.tag == 11){
        WrapBarViewController *wrapBarVC = [[WrapBarViewController alloc]init];
        [self.navigationController pushViewController:wrapBarVC animated:YES];
        
    }else if (btn.tag == 12){
        FSLineChartViewController *FSLineChartVC = [[FSLineChartViewController alloc]init];
        [self.navigationController pushViewController:FSLineChartVC animated:YES];
        
    }else if (btn.tag == 13){
        QRCodeViewController *QRCodeVC = [[QRCodeViewController alloc]init];
        [self.navigationController pushViewController:QRCodeVC animated:YES];
        
    }else if (btn.tag == 14){
        BluetoothViewController *bluetoothVC = [[BluetoothViewController alloc]init];
        [self.navigationController pushViewController:bluetoothVC animated:YES];
        
    }else if (btn.tag == 15){
        APViewController *APVC = [[APViewController  alloc]init];
        [self.navigationController pushViewController:APVC animated:YES];
        
    }else if (btn.tag == 16){
        AnimatedViewController *animatedVC = [[AnimatedViewController alloc]init];
        [self.navigationController pushViewController:animatedVC animated:YES];
        
    }else if (btn.tag == 17){
        SJAVPlayerController *SJAVPlayerVC = [[SJAVPlayerController alloc]init];
        [self.navigationController pushViewController:SJAVPlayerVC animated:YES];
        
    }else if (btn.tag == 18){
        SearchViewController *searchVC = [[SearchViewController alloc]init];
        [self.navigationController pushViewController:searchVC animated:YES];
        
    }else if (btn.tag == 19){
        PushButtonViewController *pushButtonVC = [[PushButtonViewController alloc]init];
        [self.navigationController pushViewController:pushButtonVC animated:YES];
        
    }else if (btn.tag == 20){
//        LoginViewController*loginVC = [[LoginViewController alloc]init];
//        [self.navigationController pushViewController:loginVC animated:YES];
        InstantMessageViewController *instantMessageVC = [[InstantMessageViewController alloc]init];
        [self.navigationController pushViewController:instantMessageVC animated:YES];
        
    }else if (btn.tag == 21){
        CardFlipDragViewController *cardFlipDragVC = [[CardFlipDragViewController alloc]init];
        [self.navigationController pushViewController:cardFlipDragVC animated:YES];
        
    }else if (btn.tag == 22){
        DropDeleteLineViewController *dropDeleteLineVC = [[DropDeleteLineViewController alloc]init];
        [self.navigationController pushViewController:dropDeleteLineVC animated:YES];
        
    }else if (btn.tag == 23){
        EmitterViewController *emitterVC = [[EmitterViewController alloc]init];
        [self.navigationController pushViewController:emitterVC animated:YES];
        
    }else if (btn.tag == 24){
        TextToPictureViewController *textToPictureVC = [[TextToPictureViewController alloc]init];
        [self.navigationController pushViewController:textToPictureVC animated:YES];
        
    }else if (btn.tag == 25){
        CollisionViewController *collisionVC = [[CollisionViewController alloc]init];
        [self.navigationController pushViewController:collisionVC animated:YES];
        
    }else if (btn.tag == 26){
        GestureViewController *gestureVC = [[GestureViewController alloc]init];
        [self.navigationController pushViewController:gestureVC animated:YES];
        
    }else if (btn.tag == 27){

        
    }else if (btn.tag == 28){

        
    }else if (btn.tag == 29){

        
    }else if (btn.tag == 30){

        
    }else if (btn.tag == 31){

        
    }else if (btn.tag == 32){

        
    }else if (btn.tag == 33){

        
    }else if (btn.tag == 34){

        
    }else if (btn.tag == 35){

        
    }else if (btn.tag == 36){

        
    }else if (btn.tag == 37){

        
    }else if (btn.tag == 38){

        
    }else if (btn.tag == 39){

        
    }else if (btn.tag == 40){

        
    }else if (btn.tag == 41){

        
    }else if (btn.tag == 42){

        
    }else if (btn.tag == 43){

        
    }else if (btn.tag == 44){

        
    }else if (btn.tag == 45){

        
    }else if (btn.tag == 46){

        
    }else if (btn.tag == 47){

        
    }else if (btn.tag == 48){

        
    }else if (btn.tag == 49){

        
    }else if (btn.tag == 50){

        
    }else if (btn.tag == 51){

        
    }else if (btn.tag == 52){

        
    }else if (btn.tag == 53){

        
    }else if (btn.tag == 54){

        
    }else if (btn.tag == 55){

        
    }else if (btn.tag == 56){

        
    }else if (btn.tag == 57){

    }else if (btn.tag == 58){

    }else if (btn.tag == 59){

    }else if (btn.tag == 60){
    }
    

}
- (void)back{

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
