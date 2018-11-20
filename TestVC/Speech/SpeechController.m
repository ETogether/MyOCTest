//
//  SpeechController.m
//  MyOCTest
//
//  Created by Sougu on 2018/10/31.
//  Copyright © 2018年 netvox. All rights reserved.
//



#import "SpeechController.h"

#import "TitleView.h"

#import <Speech/Speech.h>

#import <AVFoundation/AVFoundation.h>

@interface SpeechController ()<SFSpeechRecognizerDelegate>
{
    
}
///录音按钮
@property (nonatomic,strong) UIButton *recordBtn;

///<#code#>
@property (nonatomic,strong) SFSpeechAudioBufferRecognitionRequest *recognReq;

///<#code#>
@property (nonatomic,strong) AVAudioEngine *audioEngine;

///<#code#>
@property (nonatomic,strong) SFSpeechRecognizer *speechRecognizer;

///<#code#>
@property (nonatomic,weak) SFSpeechRecognitionTask *recognTask;

///内容
@property (nonatomic,strong) UILabel * speechLbl;

/// 内容
@property (nonatomic,strong) UITextView *speechTV;

///adioSession
@property (nonatomic,strong) AVAudioSession *audio;

///录音
@property (nonatomic,strong) AVAudioRecorder *recorder;

///文件路径
@property (nonatomic,copy) NSString *filePath;

///url文件路径
@property (nonatomic,strong) NSURL *filePathURL;

///计时器
@property (nonatomic,weak) NSTimer *timer;

///计数
@property (nonatomic,assign) int countDown;

///player
@property (nonatomic,strong) AVAudioPlayer *player;

@end

@implementation SpeechController

-(NSTimer *)timer{
    if (!_timer) {
        NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
            _countDown --;
            CQLog(@"倒计时：%ds",_countDown);
            if (_countDown == 0) {
                CQLog(@"录音时间已到！");
                [self endRecordingAndRecognized];
            }
        }];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        _timer = timer;
    }
    return _timer;
}

- (SFSpeechRecognizer *)speechRecognizer{
    if (!_speechRecognizer) {
        //为语音识别对象设置语言，这里设置的是中文
        NSLocale *local =[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];

        _speechRecognizer =[[SFSpeechRecognizer alloc] initWithLocale:local];
        _speechRecognizer.delegate = self;
    }
    return _speechRecognizer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _countDown = 60;
    [self settingView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    CQWEAK(self)
    [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            switch (status) {
                case SFSpeechRecognizerAuthorizationStatusDenied:
                    CQLog(@"用户未授权语音识别");
                    [_recordBtn setTitle:@"用户未授权语音识别" forState:UIControlStateNormal];
                    break;
                case SFSpeechRecognizerAuthorizationStatusRestricted:
                    CQLog(@"语音识别在这台设备上受到限制");
                    [_recordBtn setTitle:@"语音识别在这台设备上受到限制" forState:UIControlStateNormal];
                    break;
                case SFSpeechRecognizerAuthorizationStatusAuthorized:
                    CQLog(@"开始录音");
                    [_recordBtn setTitle:@"开始录音" forState:UIControlStateNormal];
                    break;
                case SFSpeechRecognizerAuthorizationStatusNotDetermined:
                    CQLog(@"语音识别未授权");
                    selfWeak.recordBtn.enabled = YES;
                    [_recordBtn setTitle:@"语音识别未授权" forState:UIControlStateNormal];
                    break;
                default:
                    break;
            }
        });
    }];
}

///页面设置
-(void)settingView{
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavBarView];
    [self addContentView];
}

///设置导航栏视图
-(void)setNavBarView{
    __weak typeof(self) weakSelf = self;
    TitleView *navBar = [[TitleView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, NAVBARHEIGHT)];
    navBar.lbTitle.text = @"语音识别";
    [navBar.btnRight setTitle:@"右" forState:0];
    navBar.backBlock = ^(int tag){
        switch (tag) {
            case 0:
                [weakSelf.navigationController popViewControllerAnimated:YES];
                break;

            default:
                break;
        }
    };

    [self.view addSubview:navBar];

}
///添加内容视图
-(void)addContentView{

    _recordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _recordBtn.frame = CGRectMake(120, NAVBARHEIGHT + 40, SCREENWIDTH - 240, 60);
//    _recordBtn.enabled = NO;
    [_recordBtn setTitleColor:HEXCOLOR(0x9812ed) forState:UIControlStateNormal];
//    [<#btn#> setImage:[[UIImage imageNamed:<#@""#>] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    _recordBtn.tag = 100;
    [_recordBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_recordBtn];

    _audioEngine = [[AVAudioEngine alloc] init];


    _speechLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, _recordBtn.cqYH + 40, SCREENWIDTH - 40, 40)];
    _speechLbl.textAlignment = NSTextAlignmentCenter;
    _speechLbl.textColor = HEXCOLOR(0x3a8109);
    _speechLbl.numberOfLines = 0;
    [self.view addSubview:_speechLbl];
    _speechLbl.layer.borderColor = HEXCOLOR(0x343434).CGColor;
    _speechLbl.layer.borderWidth = 0.5;
    
    _speechTV = [[UITextView alloc] initWithFrame:CGRectMake(20, _speechLbl.cqYH + 20, SCREENWIDTH - 40, 120) textContainer:nil];
    _speechTV.textColor = HEXCOLOR(0x3b02e2);
    _speechTV.backgroundColor = HEXCOLOR(0xeeeeee);
    [self.view addSubview:_speechTV];

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(30, SCREENHEIGHT - 190, SCREENWIDTH - 60, 30);
    [btn setTitle:@"停止录音" forState:UIControlStateNormal];
    [btn setTitleColor:HEXCOLOR(0x80ef1e) forState:UIControlStateNormal];
    btn.tag = 101;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    playBtn.frame = CGRectMake(30, SCREENHEIGHT - 60, SCREENWIDTH - 60, 30);
    [playBtn setTitle:@"播放录音" forState:UIControlStateNormal];
    [playBtn setTitleColor:HEXCOLOR(0x80ef1e) forState:UIControlStateNormal];
    playBtn.tag = 1000;
    [playBtn addTarget:self action:@selector(playRecording) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playBtn];

}

#pragma mark - 按钮事件
-(void)btnClick:(UIButton *)btn{
    CQLog(@"Title=%@,tag=%ld",btn.currentTitle,(long)btn.tag);
    
    NSInteger tag = btn.tag - 100;
    switch (tag) {
        case 0:{
            
            [self startRecordingWithRecognized];
        }break;
        case 1:{
            //取消
            [self endRecordingAndRecognized];
        }break;
//        case <#2#>:{
//            //<#hnit#>
//            <#code#>
//        }break;
        default:
            break;
    }
}
///开始录音并及语音识别
-(void)startRecordingWithRecognized{
    CQWEAK(self)
    
    _countDown = 60;
    [self timer];
    
    [_recordBtn setTitle:@"录音中..." forState:UIControlStateNormal];
    if (_recognTask) {
        [_recognTask cancel];
    }
    //开始录音
    AVAudioSession *audio = [AVAudioSession sharedInstance];
//    NSArray *inputs = [audio availableInputs];
//    AVAudioSessionPortDescription *port = inputs.firstObject;
//    NSError *portError;
//    //设置首选输入端口
//    [audio setPreferredInput:port error:&portError];
//    NSParameterAssert(!portError);
    NSError *error;
    [audio setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
    NSParameterAssert(!error);
    [audio setMode:AVAudioSessionModeMeasurement error:&error];
    NSParameterAssert(!error);
    [audio setActive:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:&error];
    NSParameterAssert(!error);
    
    _recognReq = [[SFSpeechAudioBufferRecognitionRequest alloc] init];
    AVAudioInputNode *inputNode = self.audioEngine.inputNode;
    NSAssert(inputNode, @"录入设备没有准备好");
    NSAssert(_recognReq, @"请求初始化失败");
    _recognReq.shouldReportPartialResults = YES;
    
    SFSpeechRecognitionTask *task = [self.speechRecognizer recognitionTaskWithRequest:_recognReq resultHandler:^(SFSpeechRecognitionResult * _Nullable result, NSError * _Nullable error) {
        
        BOOL isFinal = NO;
        if (result) {
            selfWeak.speechTV.text = result.bestTranscription.formattedString;
            isFinal = result.isFinal;//内部设置为60秒
            if ([result.bestTranscription.formattedString containsString:@"停止录音"]) {
                isFinal = false;
                [selfWeak endRecordingAndRecognized];
                for (SFTranscription *scrip in result.transcriptions) {
                    CQLog(@"%@",scrip.formattedString);
                    
                }
                
            }
            
        }
        if (error || isFinal) {
            [selfWeak.audioEngine stop];
            [inputNode removeTapOnBus:0];
            [selfWeak.recognTask cancel] ;
            selfWeak.recognReq = nil;
            selfWeak.recordBtn.enabled = YES;
            [selfWeak.recordBtn setTitle:@"开始录音" forState:UIControlStateNormal];
        }
    }];
    _recognTask = task;//识别任务会为持有，所以定义了weak
    
    AVAudioFormat *format = [inputNode outputFormatForBus:0];
    [inputNode removeTapOnBus:0];
    [inputNode installTapOnBus:0 bufferSize:1024 format:format block:^(AVAudioPCMBuffer * _Nonnull buffer, AVAudioTime * _Nonnull when) {
        CQLog(@"buffer:%@\nwhem:%@", buffer, when);
        if (selfWeak.recognReq) {
            [selfWeak.recognReq appendAudioPCMBuffer:buffer];
        }
    }];
    [self.audioEngine prepare];
    [self.audioEngine startAndReturnError:&error];
    NSParameterAssert(!error);
    _speechLbl.text = @"正在录音...";
    
    
    ///本地存储
    //路径
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    _filePath = [path stringByAppendingString:@"/RecordSpeech.wav"];
    _filePathURL = [NSURL fileURLWithPath:_filePath];
    //设置音频文件参数
    NSDictionary *recordSetting = [[NSDictionary alloc] initWithObjectsAndKeys:
                                   //采样率  8000/11025/22050/44100/96000（影响音频的质量）
                                   [NSNumber numberWithFloat: 8000.0],AVSampleRateKey,
                                   // 音频格式
                                   [NSNumber numberWithInt: kAudioFormatLinearPCM],AVFormatIDKey,
                                   //采样位数  8、16、24、32 默认为16
                                   [NSNumber numberWithInt:16],AVLinearPCMBitDepthKey,
                                   // 音频通道数 1 或 2
                                   [NSNumber numberWithInt: 1], AVNumberOfChannelsKey,
                                   //录音质量
                                   [NSNumber numberWithInt:AVAudioQualityHigh],AVEncoderAudioQualityKey,
                                   nil];
    NSError *recorderError;
    AVAudioRecorder *recorder = [[AVAudioRecorder alloc] initWithURL:self.filePathURL settings:recordSetting error:&recorderError];
    _recorder = recorder;
    if (recorderError) {
        CQLog(@"录音错误：%@",recorderError);
    } else {
        _recorder.meteringEnabled = YES;
        [_recorder prepareToRecord];
        [_recorder record];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(60 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [selfWeak endRecordingAndRecognized];
        });
    }
}
///结束录音功能 及主意识别
-(void)endRecordingAndRecognized{
    //关闭计时器
    if (_timer) {
        [_timer invalidate];
    }
    
    //关闭音频引擎
    [self.audioEngine stop];
    
    //结束音频识别请求
    if (_recognReq) {
        [_recognReq endAudio];
    }
    //取消识别任务
    if (_recognTask) {
        [_recognTask cancel];
        
    }
    
    //取消录音
    if ([self.recorder isRecording]) {
        [self.recorder stop];
        self.recorder = nil;
    }
    
    
    if ([_speechLbl.text isEqualToString:@"正在录音..."]) {
        _speechLbl.text = @"结束了录音功能 ";
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:self.filePath]) {
        _speechLbl.text = [NSString stringWithFormat:@"%@录了 %ld 秒,文件大小为 %.2fKb", _speechLbl.text,60 - (long)_countDown,[[fileManager attributesOfItemAtPath:_filePath error:nil] fileSize]/1024.0];
    }else{
        _speechLbl.text = [NSString stringWithFormat:@"%@ 最多60秒",_speechLbl.text];
    }
    
    
}

-(void)playRecording{
    _speechTV.text = @" 播放录音中...";
    [self endRecordingAndRecognized];
    
    if (!self.filePathURL) {
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        _filePath = [path stringByAppendingString:@"/RecordSpeech.wav"];
        self.filePathURL = [NSURL fileURLWithPath:path];
    }
    NSError *playerError;
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:self.filePathURL error:&playerError];
    CQLog(@"数据量大小：%li",player.data.length / 1024);
    if (playerError) {
        CQLog(@"录音错误：%@",playerError);
    } else {
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];//AVAudioSessionCategoryPlayback
        [player play];
    }
    _player = player;//需要保持player存在 否则无法播放
    
    //本地语音识别
    SFSpeechRecognizer *rg = [[SFSpeechRecognizer alloc] init];
//    _speechRecognizer = rg;
//    NSURL *url = [[NSBundle mainBundle] URLForResource:@"RecordSpeech.wav" withExtension:nil];
//    NSURL *url = [NSURL fileURLWithPath:self.filePath];
    SFSpeechRecognitionRequest *rgReq = [[SFSpeechURLRecognitionRequest alloc] initWithURL:self.filePathURL];
    SFSpeechRecognitionTask *task = [rg recognitionTaskWithRequest:rgReq resultHandler:^(SFSpeechRecognitionResult * _Nullable result, NSError * _Nullable error) {
        
        if (result) {//如果语音中是中英文混合  把系统改为中文即可
            _speechTV.text = [NSString stringWithFormat:@"%@",result.bestTranscription.formattedString];
            if (result.isFinal) {
                CQLog(@"完成本地 识别！");
                [task cancel];
            }
            
        }else{
            CQLog(@"无法识别！");
            [task cancel];
        }
        
    }];
    
}

#pragma mark - SFSpeech代理方法
-(void)speechRecognizer:(SFSpeechRecognizer *)speechRecognizer availabilityDidChange:(BOOL)available{
    if (available) {
        _speechLbl.textColor = HEXCOLOR(0x32f319);
    }else{
        _speechLbl.text = @"语音识别不可用";
    }

}

@end



