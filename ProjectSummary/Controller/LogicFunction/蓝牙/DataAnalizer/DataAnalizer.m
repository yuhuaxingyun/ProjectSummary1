//
//  DataAnalizer.m
//  IntelligentMask
//
//  Created by baolicheng on 16/1/19.
//  Copyright © 2016年 RenRenFenQi. All rights reserved.
//

#import "DataAnalizer.h"
#import "BluetoothMacManager.h"
@implementation DataAnalizer
-(id)init
{
    self = [super init];
    if (self) {
        cacheData = [[NSMutableData alloc] init];
    }
    return self;
}

//校验返回数据是否正确
-(void)inputData:(NSData *)data
{
    NSLog(@"收到数据:%@",data);
    if (!data || data.length == 0) {
        return;
    }


    [cacheData appendData:data];
    [self performSelectorInBackground:@selector(doWithData) withObject:nil];
}

-(void)doWithData
{
    NSLog(@"准备执行一次循环");
    @synchronized (self) {
        NSLog(@"开始执行一次循环");
        while (cacheData.length > 0) {
            NSLog(@"剩余数据:%@",cacheData);
            Byte *byte = (Byte *)[cacheData bytes];
            CommandType command = byte[0];
            switch (command) {
                case MacAddress:{}
                    break;
                case OpenDeviceTime:{}
                    break;
                case CloseDeviceTime:{}
                    break;
                case WakeUpDevice:{}
                    break;
                case SleepDevice:{}
                    break;
                case BottleInfo:{}
                    break;
                case EmitSmell:{}
                    break;
                case EmitCustomSmell:{}
                    break;
                case EmitRelativeTimeSmell:{}
                    break;
                case EmitAbsoluteDateTimeSmell:{}
                    break;
                case EmitAbsoluteWeekTimeSmell:{}
                    break;
                case BottleInfoCompletely:{}
                    break;
                default:
                {
                    //如果数据错乱或程序执行错乱，清空数据
                    [cacheData  replaceBytesInRange:NSMakeRange(0, cacheData.length) withBytes:NULL length:0];
                    
//                    [AppUtils showInfo:@"数据错乱啦，请重新刷新数据"];
                }
                    break;
            }
            
        }
    }
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
@end
