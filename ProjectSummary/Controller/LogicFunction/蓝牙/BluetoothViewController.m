//
//  BluetoothViewController.m
//  ProjectSummary
//
//  Created by baolicheng on 2017/2/20.
//  Copyright © 2017年 RenRenFenQi. All rights reserved.
//

#import "BluetoothViewController.h"
#import "BluetoothMacManager.h"
#import "BluetoothProcessManager.h"
@interface BluetoothViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataSourceAray;
@property (nonatomic,strong)NSMutableArray *titleArray;
@end

@implementation BluetoothViewController
//- (void)viewWillAppear:(BOOL)animated{
//    self.navigationController.navigationBar.translucent = NO;
//}
//- (void)viewWillDisappear:(BOOL)animated{
//    self.navigationController.navigationBar.translucent = YES;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSourceAray = [NSMutableArray array];
    self.titleArray = [NSMutableArray array];
    
    [self registerNotication];
    [[BluetoothProcessManager defatultManager] registerNotify];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         [self reloadBlueList];
    });
   
}
- (void)registerNotication{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deliveryData:) name:BluetoothDeliveryDataNotify object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onStartScanBluetooth:) name:OnStartScanBluetooth object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onCallbackBluetoothPowerOff:) name:OnCallbackBluetoothPowerOff object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onCallbackScanBluetoothTimeout:) name:OnCallbackScanBluetoothTimeout object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onCallbackBluetoothDisconnected:) name:OnCallbackBluetoothDisconnected object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onStartConnectToBluetooth:) name:OnStartConnectToBluetooth object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onCallbackConnectToBluetoothSuccessfully:) name:OnCallbackConnectToBluetoothSuccessfully object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onCallbackConnectToBluetoothTimeout:) name:OnCallbackConnectToBluetoothTimeout object:nil];

}
- (void)createTableView{
    self.tableView = [[UITableView alloc]initWithFrame:[[UIScreen mainScreen]bounds] style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArray.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *BlueList = @"BlueList";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:BlueList];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BlueList];
        cell.textLabel.text = [self.titleArray objectAtIndex:indexPath.row];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    id peripheral = [self.dataSourceAray objectAtIndex:indexPath.row];
    NSString *title = [self.titleArray objectAtIndex:indexPath.row];
    if (![[BluetoothMacManager defaultManager] isPoweredOn]) {
        return;
    }
    [self connectToBluetoothWithPeripheral:peripheral WithName:title];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
#pragma -mark Notification
-(void)onStartScanBluetooth:(NSNotification *)notify
{
//    [self setIsScanning:YES];
//    [self performSelectorInBackground:@selector(syncComboxMenuData) withObject:nil];
//    if (testTimer) {
//        if ([testTimer isValid]) {
//            [testTimer invalidate];
//            testTimer = nil;
//        }
//    }
//    [self setSelectDeviceBtnTitle:@"正在搜索嗅觉设备" IsEnable:YES];
//    [_collectionView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
}

-(void)onCallbackBluetoothPowerOff:(NSNotification *)notify
{
//    [self setIsScanning:NO];
//    [self reloadComboxMenu];
//    if (testTimer) {
//        if ([testTimer isValid]) {
//            [testTimer invalidate];
//            testTimer = nil;
//        }
//    }
//    [self setSelectDeviceBtnTitle:@"蓝牙未打开" IsEnable:YES];
}

-(void)onCallbackScanBluetoothTimeout:(NSNotification *)notify
{
//    [self setIsScanning:NO];
//    [self setSelectDeviceBtnTitle:@"请选择嗅觉设备" IsEnable:YES];
}

-(void)onCallbackBluetoothDisconnected:(NSNotification *)notify
{
//    [self setIsScanning:NO];
//    [self reloadComboxMenu];
//    [self setSelectDeviceBtnTitle:@"设备未连接" IsEnable:YES];
}

-(void)onStartConnectToBluetooth:(NSNotification *)notify
{
//    [self setIsScanning:NO];
//    [self setSelectDeviceBtnTitle:@"连接中..." IsEnable:YES];
//    if (testTimer) {
//        if ([testTimer isValid]) {
//            [testTimer invalidate];
//            testTimer = nil;
//        }
//    }
}

-(void)onCallbackConnectToBluetoothSuccessfully:(NSNotification *)notify
{
//    [self setIsScanning:NO];
//    [self reloadComboxMenu];
//    [self setSelectDeviceBtnTitle:@"设备已连接" IsEnable:YES];
//    [self.viewModel clearData];
//    [self initlizedData];
//    
//    //心跳包
//    testTimer = [NSTimer scheduledTimerWithTimeInterval:8 target:self selector:@selector(test) userInfo:nil repeats:YES];
//    [testTimer fire];
}

-(void)onCallbackConnectToBluetoothTimeout:(NSNotification *)notify
{
//    [self setIsScanning:NO];
//    [self setSelectDeviceBtnTitle:@"设备未连接" IsEnable:YES];
//    
//    if (testTimer) {
//        if (![testTimer isValid]) {
//            //心跳包
//            testTimer = [NSTimer scheduledTimerWithTimeInterval:8 target:self selector:@selector(test) userInfo:nil repeats:YES];
//            [testTimer fire];
//        }
//    }
}
//刷新ComboxMenu的蓝牙数据列表
-(void)reloadBlueList{

    NSArray *peripheralArray = [[BluetoothMacManager defaultManager] returnAllScanPeripherals];

    NSArray *peripheralNameArray = [[BluetoothMacManager defaultManager] returnAllScanPeripheralNames];
    NSUInteger defaultSelectedIndex = -1;
    if ([[BluetoothMacManager defaultManager] isConnected]) {
        id connectedPeripheral = [[BluetoothMacManager defaultManager] returnConnectedPeripheral];
        if ([peripheralArray containsObject:connectedPeripheral]) {
            defaultSelectedIndex = [peripheralArray indexOfObject:connectedPeripheral];
        }
    }
    [self.titleArray addObjectsFromArray:peripheralNameArray];
    [self.dataSourceAray addObjectsFromArray:peripheralArray];
    [self createTableView];

}
#pragma -mark ScanBluetoothDeviceViewProtocol
-(void)connectToBluetoothWithPeripheral:(id)peripheral WithName:(NSString *)name;
{
    if ([[BluetoothMacManager defaultManager] isConnected]) {
        if (![[BluetoothMacManager defaultManager] isMatchConnectedPeripheral:peripheral]) {
            //因为有两组特征值 所以需要手动断开
            [[BluetoothMacManager defaultManager] stopBluetoothDevice];
            [[BluetoothProcessManager defatultManager] connectToBluetooth:name WithPeripheral:peripheral];
        }else{
            [self refreshBluetoothData];
        }
    }else{
        [[BluetoothProcessManager defatultManager] connectToBluetooth:name WithPeripheral:peripheral];
    }
}
/**
 *  @author RenRenFenQi, 16-08-01 11:08:03
 *
 *  刷新蓝牙设备数据
 */
-(void)refreshBluetoothData
{
    if ([[BluetoothMacManager defaultManager] isConnected]) {

        [[BluetoothMacManager defaultManager] writeCharacteristicWithCommand:CommandMacAddress];
        [[BluetoothMacManager defaultManager] writeCharacteristicWithCommand:CommandBottleInfo];
    }else{
        [[BluetoothProcessManager defatultManager] startScanBluetooth];
    }
}

-(void)deliveryData:(NSNotification *)notify{
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
