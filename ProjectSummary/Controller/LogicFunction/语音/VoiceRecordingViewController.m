//
//  VoiceRecordingViewController.m
//  AllCodeDataNew
//
//  Created by 宋江 on 16/7/13.
//  Copyright © 2016年 宋江. All rights reserved.
//

#import "VoiceRecordingViewController.h"
#import "TTSViewController.h"
#import "VoiceRecordViewController.h"
@interface VoiceRecordingViewController ()
@property (strong, nonatomic)NSArray *dataArr;
@end

@implementation VoiceRecordingViewController
//- (void)viewWillAppear:(BOOL)animated{
//    self.navigationController.navigationBar.translucent = NO;
//}
//- (void)viewWillDisappear:(BOOL)animated{
//    self.navigationController.navigationBar.translucent = YES;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"多媒体应用";

    self.automaticallyAdjustsScrollViewInsets =NO;
    _dataArr=@[@"语音朗读",@"语音记录"];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==0) {
        TTSViewController *tTSVC = [[TTSViewController alloc]init];
        [self.navigationController pushViewController:tTSVC animated:YES];
    }
    
    if (indexPath.row ==1) {
        VoiceRecordViewController *VoiceRecordVC =[[VoiceRecordViewController alloc]init];
        [self.navigationController pushViewController:VoiceRecordVC animated:YES];
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *str=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
    
    if (cell == nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    cell.textLabel.text = _dataArr[indexPath.row];
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
