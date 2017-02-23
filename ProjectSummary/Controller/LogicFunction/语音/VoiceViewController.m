//
//  VoiceViewController.m
//  总结
//
//  Created by 宋江 on 16/3/25.
//  Copyright © 2016年 宋江. All rights reserved.
//

#import "VoiceViewController.h"
#import <AVFoundation/AVFoundation.h>

#define kAudioFileName @"test.caf"
@interface VoiceViewController ()<AVAudioRecorderDelegate>
{
    UIButton *_soundRecordBtn;
    AVAudioSession *_avSession;
    AVAudioRecorder *_avRecorder;
    AVAudioPlayer *_audioPlayer;
}
@end

@implementation VoiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createBarItem];
    UIButton *voiceBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 70, VIEW_WEDTH, 25)];
    [voiceBtn setTitle:@"文字转语音" forState:UIControlStateNormal];
    [voiceBtn setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    voiceBtn.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [voiceBtn addTarget:self action:@selector(textToVoice) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:voiceBtn];
    
    _soundRecordBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 100, VIEW_WEDTH, 25)];
    [_soundRecordBtn setTitle:@"开始录音" forState:UIControlStateNormal];
    [_soundRecordBtn setTitle:@"结束录音" forState:UIControlStateSelected];
    [_soundRecordBtn setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    _soundRecordBtn.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [_soundRecordBtn addTarget:self action:@selector(soundRecord) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_soundRecordBtn];
    
    UIButton *playbackBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 130, VIEW_WEDTH, 25)];
    [playbackBtn setTitle:@"回放" forState:UIControlStateNormal];
    [playbackBtn setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    playbackBtn.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [playbackBtn addTarget:self action:@selector(playback) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playbackBtn];
    
    
    

}
- (void)createBarItem{
    UIBarButtonItem *backBtnItem = [UIBarButtonItem itemWithImageName:@"Back" target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = backBtnItem;
}
//文字转语音
- (void)textToVoice{
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:
                                    //                                    @"hello,Little pig let me in! I ' m your brother"
                                    //                                    @"你好，周陆洲！"
                                    @" Daddy finger, Daddy finger, where are you? Here I am. Here I am?Mammy finger, Mammy finger, where are you?  Here I am. Here I am? Brother finger, Brother finger, where are you?  Here I am. Here I am. How do you do? Sister finger, Sister finger, where are you?  Here I am. Here I am. How do you do? Baby finger, Baby finger, where are you?  Here I am. Here I am?"
                                    ];
    //英式发音
    //    AVSpeechSynthesisVoice *voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-GB"];
    //中式发音
    AVSpeechSynthesisVoice *voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh_CN"];
    //    AVSpeechSynthesisVoice *voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en_US"];
    //    AVSpeechSynthesisVoice *voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"fr_FR"];
    
    utterance.voice = voice;
    NSLog(@"%@",[AVSpeechSynthesisVoice speechVoices]);
    AVSpeechSynthesizer *synth = [[AVSpeechSynthesizer alloc]init];
    [synth speakUtterance:utterance];

}
//录音
- (void)soundRecord{
    if (_soundRecordBtn.isSelected) {
        _soundRecordBtn.selected = NO;
        [_avRecorder stop];
    }else{
        _soundRecordBtn.selected = YES;
        _avSession = [AVAudioSession sharedInstance];
        [_avSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
        [_avSession setActive:YES error:nil];
        NSDictionary *settings = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:44100.0], AVSampleRateKey,[NSNumber numberWithInt:kAudioFormatMPEG4AAC], AVFormatIDKey,[NSNumber numberWithInt:1], AVNumberOfChannelsKey,nil];
        AVAudioRecorder *avRecorder = [[AVAudioRecorder alloc] initWithURL:[self getSavePath] settings:settings error:nil];
        NSLog(@"%@",[self getSavePath]);
        [avRecorder prepareToRecord];
        [avRecorder peakPowerForChannel:0];
        [avRecorder record];
    }


}
#pragma mark AVAudioRecorderDelegate
- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag{
    [_avSession setActive: NO error: nil];
}
//回放
- (void)playback{
    
    NSError *error;
    _audioPlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:[self getSavePath] error:&error];
    NSString *str = [NSString stringWithFormat:@"%@", [self getSavePath]] ;
    NSLog(@"%@",str);
    _audioPlayer.volume=1;
    if (error) {
        NSLog(@"error:%@",[error description]);
        return;
    }
    //准备播放
    [_audioPlayer prepareToPlay];
    //播放
    [_audioPlayer play];
}
/**
 *  录音存储路径
 *
 *  @return 返回存储路径
 */
- (NSURL *)getSavePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *url = [paths objectAtIndex:0];
    url = [url stringByAppendingPathComponent: kAudioFileName];
    NSLog(@"%@",url);
    return [NSURL URLWithString:url];
}
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
