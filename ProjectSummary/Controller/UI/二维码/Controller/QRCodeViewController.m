//
//  QRCodeViewController.m
//  ProjectSummary
//
//  Created by baolicheng on 2017/2/20.
//  Copyright © 2017年 RenRenFenQi. All rights reserved.
//

#import "QRCodeViewController.h"
#import "SGGenerateQRCodeVC.h"
#import "SGScanningQRCodeVC.h"
#import <AVFoundation/AVFoundation.h>
#import "SGAlertView.h"
@interface QRCodeViewController ()

@end

@implementation QRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *generateBtn = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-100)/2, 100, 100, 40)];
    [generateBtn setTitle:@"生成二维码" forState:UIControlStateNormal];
    [generateBtn setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    generateBtn.backgroundColor = [UIColor darkGrayColor];
    [generateBtn addTarget:self action:@selector(generateQRCode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:generateBtn];
    
    UIButton *scanningBtn = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-100)/2, 200, 100, 40)];
    [scanningBtn setTitle:@"扫描二维码" forState:UIControlStateNormal];
    [scanningBtn setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    scanningBtn.backgroundColor = [UIColor darkGrayColor];
    [scanningBtn addTarget:self action:@selector(scanningQRCode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:scanningBtn];
}
/** 生成二维码方法 */
- (void)generateQRCode{
    
    SGGenerateQRCodeVC *VC = [[SGGenerateQRCodeVC alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

/** 扫描二维码方法 */
- (void)scanningQRCode{
    
    // 1、 获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status == AVAuthorizationStatusNotDetermined) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        SGScanningQRCodeVC *scanningQRCodeVC = [[SGScanningQRCodeVC alloc] init];
                        [self.navigationController pushViewController:scanningQRCodeVC animated:YES];
                        NSLog(@"主线程 - - %@", [NSThread currentThread]);
                    });
                    NSLog(@"当前线程 - - %@", [NSThread currentThread]);
                    
                    // 用户第一次同意了访问相机权限
                    NSLog(@"用户第一次同意了访问相机权限");
                    
                } else {
                    
                    // 用户第一次拒绝了访问相机权限
                    NSLog(@"用户第一次拒绝了访问相机权限");
                }
            }];
        } else if (status == AVAuthorizationStatusAuthorized) { // 用户允许当前应用访问相机
            SGScanningQRCodeVC *scanningQRCodeVC = [[SGScanningQRCodeVC alloc] init];
            [self.navigationController pushViewController:scanningQRCodeVC animated:YES];
        } else if (status == AVAuthorizationStatusDenied) { // 用户拒绝当前应用访问相机
            SGAlertView *alertView = [SGAlertView alertViewWithTitle:@"⚠️ 警告" delegate:nil contentTitle:@"请去-> [设置 - 隐私 - 相机 - SGQRCodeExample] 打开访问开关" alertViewBottomViewType:(SGAlertViewBottomViewTypeOne)];
            [alertView show];
        } else if (status == AVAuthorizationStatusRestricted) {
            NSLog(@"因为系统原因, 无法访问相册");
        }
    } else {
        SGAlertView *alertView = [SGAlertView alertViewWithTitle:@"⚠️ 警告" delegate:nil contentTitle:@"未检测到您的摄像头, 请在真机上测试" alertViewBottomViewType:(SGAlertViewBottomViewTypeOne)];
        [alertView show];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
