//
//  ToolMothod.m
//  ZhiZhu
//
//  Created by wt-vrs on 15/11/12.
//  Copyright © 2015年 wt-vrs. All rights reserved.
//

#import "ToolMothod.h"
#import "AppDelegate.h"
#import "Reachability.h"
#import <objc/runtime.h>
#import "TOTPGenerator.h"
#import "OTPAuthURL.h"
@interface ToolMothod()<UIAlertViewDelegate>

@end

@implementation ToolMothod

//绘制线
+ (UIView *)createLineWithWidth:(CGFloat)width andHeight:(CGFloat)height andColor:(UIColor *)color{

    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    line.backgroundColor = color;
    
    return line;
}

//创建Button
+ (UIButton *)createRaiseQuestionsBtn{
    
    UIButton *raiseQueBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    raiseQueBtn.layer.cornerRadius = 30;
//    raiseQueBtn.backgroundColor = MCColor(25, 88, 176, 1.0);
    [raiseQueBtn setImage:[UIImage imageNamed:@"btn_ask_n"] forState:UIControlStateNormal];
    
    return raiseQueBtn; 

}

/**
 *  时间戳转换为日期
 *
 *  @param dateStr 时间戳字符串
 *
 */
+(NSString *)changeDateWithString:(NSString *)dateStr
{
    if (dateStr) {
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[dateStr doubleValue]*0.001];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        return [dateFormat stringFromDate:date];
    }else
        return @"";
}

+(NSString *)changeDateTimeWithString:(NSString *)dateTimeStr
{
    if (dateTimeStr) {
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[dateTimeStr doubleValue]*0.001];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        return [dateFormat stringFromDate:date];
    }else
        return @"";
}

+(NSString *)getDateTimeString
{
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // 设置日期格式
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        return [formatter stringFromDate:[NSDate date]];
}

/**
 *  获取行间距
 */
+(NSMutableAttributedString *)getLineSpacing:(CGFloat)spacing text:(NSString *)str
{
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:spacing];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [str length])];
    
    return attributedString;
}

/**
 *  字符串转Url
 *
 */
+(NSURL *)urlWithStr:(NSString *)urlStr
{
    if (urlStr) {
        NSString *urlString = [testUrlString stringByAppendingString:urlStr];
        NSURL *url = [NSURL URLWithString:urlString];
        return url;
    }
 
    return nil;
}
/**
 *  弹窗
 *
 *  @param message 提示信息
 */
-(void)pleaseLogin:(id)VC title:(NSString *)title{

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0 
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        // 创建按钮
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
            
            [self.delegate pleaseLogin];
        }];
        // 创建按钮
        // 注意取消按钮只能添加一个
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction *action) {
            // 点击按钮后的方法直接在这里面写
            NSLog(@"取消");
        }];
        
        [alert addAction:okAction];
        [alert addAction:cancelAction];
        [VC presentViewController:alert animated:YES completion:nil];
#elif
    
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title message:nil delegate:VC cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
         alertView.tag = 6000;
         alertView.delegate = VC;
        [alertView show];
#endif
}

/**
 *  消息弹窗
 *
 *  @param message 提示信息
 */
-(void)newsAlertView:(id)VC title:(NSString *)title{
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];

        // 创建按钮
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"查看" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
    
            [self.delegate goNewsVC];
        }];
        // 创建按钮
        // 注意取消按钮只能添加一个
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"忽略" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction *action) {
            // 点击按钮后的方法直接在这里面写
            NSLog(@"忽略");
        }];
        
        [alert addAction:okAction];
        [alert addAction:cancelAction];
        [VC presentViewController:alert animated:YES completion:nil];
#elif
    
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title message:nil delegate:VC cancelButtonTitle:@"忽略" otherButtonTitles:@"查看", nil];
        alertView.tag = 6001;
        alertView.delegate =VC;
        [alertView show];
        
#endif
}
/**
 *  弹窗
 *
 *  @param message 提示信息
 */
+(void)alertView:(id)VC title:(NSString *)title{
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        // 创建按钮
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction *action) {
            
        }];
        
        [alert addAction:okAction];
        [VC presentViewController:alert animated:YES completion:nil];
#elif
    
        UIAlertView *alertView1 = [[UIAlertView alloc]initWithTitle:title message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];

        [alertView1 show];
#endif
}

/**
 *  保存修改过的资料
 *
 *  @param message 提示信息
 */
-(void)saveDataAlertView:(id)VC{
    NSLog(@"%d--%d",__IPHONE_OS_VERSION_MAX_ALLOWED,__IPHONE_8_2);
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_2
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否保存修改" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    // 创建按钮
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"保存" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
        
        [self.delegate  isSaveData];
    }];
    // 创建按钮
    // 注意取消按钮只能添加一个
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"不保存" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction *action) {
        // 点击按钮后的方法直接在这里面写
       [self.delegate  notSaveData];
    }];
    
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    [VC presentViewController:alert animated:YES completion:nil];
#elif
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"是否保存修改" message:nil delegate:VC cancelButtonTitle:@"不保存" otherButtonTitles:@"保存", nil];
    alertView.tag = 6002;
    alertView.delegate = VC;
    [alertView show];
    
#endif
}


//+ (void)secretKeyAlert:(id)VC{
//
//
//}
+(BOOL)isLogin
{
    //判断用户状态
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDefaults stringForKey:@"token"];
    if (token && ![token isEqualToString:@""]) {
        return YES;
    }else{
        return NO;
    }
}


+ (void)bottomMoveTop:(UIViewController *)selfVC To:(UIViewController *)VC{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    transition.fillMode = kCAFillModeForwards;
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromTop;
    transition.delegate = self;
    [selfVC.view.window.layer addAnimation:transition forKey:nil];
    [selfVC.navigationController pushViewController:VC animated:NO];
}
+ (void)topMoveBottom:(UIViewController *)VC{
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3f;
    transition.timingFunction = UIViewAnimationCurveEaseInOut;
    transition.fillMode = kCAFillModeForwards;
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromBottom;
    transition.delegate = self;
    [VC.view.window.layer addAnimation:transition forKey:nil];
}
+ (void)Gradient:(UIViewController *)VC{
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3f;
    transition.timingFunction = UIViewAnimationCurveEaseInOut;
    transition.fillMode = kCAFillModeForwards;
    transition.type = @"charminUltra";
    transition.delegate = self;
    [VC.view.window.layer addAnimation:transition forKey:nil];
    
}
#pragma mark data 转 16 进制字符串
+ (NSString *)convertDataToHexStr:(NSData *)data {
    if (!data || [data length] == 0) {
        return @"";
    }
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];
    
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    
    return string;
}
#pragma mark 16 进制字符串 转 data
+(NSData*) hexToBytes:(NSString *)str {
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
/**
 *  对象转换为字典
 *
 *  @param obj 需要转化的对象
 *
 *  @return 转换后的字典
 */
+ (NSDictionary*)getObjectData:(id)obj {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int propsCount;
    //注意：要加 #import <objc/runtime.h>
    objc_property_t *props = class_copyPropertyList([obj class], &propsCount);
    
    for(int i = 0;i < propsCount; i++) {
        
        objc_property_t prop = props[i];
        NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];
        id value = [obj valueForKey:propName];
        if(value == nil) {
            
            value = [NSNull null];
        } else {
            value = [self getObjectInternal:value];
        }
        [dic setObject:value forKey:propName];
    }
    
    return dic;
}

+ (id)getObjectInternal:(id)obj {
    
    if([obj isKindOfClass:[NSString class]]
       ||
       [obj isKindOfClass:[NSNumber class]]
       ||
       [obj isKindOfClass:[NSNull class]]) {
        
        return obj;
        
    }
    if([obj isKindOfClass:[NSArray class]]) {
        
        NSArray *objarr = obj;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:objarr.count];
        
        for(int i = 0; i < objarr.count; i++) {
            
            [arr setObject:[self getObjectInternal:[objarr objectAtIndex:i]] atIndexedSubscript:i];
        }
        return arr;
    }
    if([obj isKindOfClass:[NSDictionary class]]) {
        
        NSDictionary *objdic = obj;
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:[objdic count]];
        
        for(NSString *key in objdic.allKeys) {
            
            [dic setObject:[self getObjectInternal:[objdic objectForKey:key]] forKey:key];
        }
        return dic;
    }
    return [self getObjectData:obj];
    
}

+ (NetworkStatusType)checkNetworkState
{
    // 1.检测wifi状态
    Reachability *wifi = [Reachability reachabilityForLocalWiFi];
    
    // 2.检测手机是否能上网络(WIFI\3G\2.5G)
    Reachability *conn = [Reachability reachabilityForInternetConnection];
    
    // 3.判断网络状态
    if ([wifi currentReachabilityStatus] != NotReachable) { // 有wifi
        NSLog(@"有wifi");
        return NetworkStatusWiFi;
        
    } else if ([conn currentReachabilityStatus] != NotReachable) { // 没有使用wifi, 使用手机自带网络进行上网
        NSLog(@"使用手机自带网络进行上网");
        return NetworkStatusWWAN;
        
    } else { // 没有
        NSLog(@"没有网络");
        return NetworkStatusNONet;
    }
}
+ (NSString *)totpPassword:(NSString *)Str{
    
    NSString *secret = [OTPAuthURL encodeBase32:[Str dataUsingEncoding:NSUTF8StringEncoding]];
    NSData *secretData = [OTPAuthURL base32Decode:secret];
    TOTPAuthURL *authUrl = [[TOTPAuthURL alloc]initWithSecret:secretData name:@"test"];
    NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:30 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@"%@",authUrl.checkCode);
        
    }];
    [timer fire];
    return authUrl.checkCode;
}


+ (BOOL)Hexadecimal:(NSString *)text
{
    BOOL isHexadecimal = NO;
    NSString * regex = @"^[A-Fa-f0-9]";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    for (int i = 0;i<text.length; i++) {

        BOOL isbool = [pred evaluateWithObject:[text substringWithRange:NSMakeRange(i, 1)]];

        if (isbool == NO) {
            isHexadecimal = NO;
            break;
            
        }else{
            isHexadecimal = YES;
        }
    }
    return isHexadecimal;
  }
@end
