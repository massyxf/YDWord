//
//  YDV2TTool.m
//  YDialogues
//
//  Created by 燕雪峰 on 2017/8/23.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import "YDV2TTool.h"
#import <Speech/Speech.h>
#import "NSString+FilePath.h"

@interface YDV2TTool ()<SFSpeechRecognizerDelegate,AVAudioRecorderDelegate>

/*rec*/
@property (nonatomic,strong)SFSpeechRecognizer *sfRec;

/*task*/
@property (nonatomic,strong)SFSpeechRecognitionTask *task;

/** recorder*/
@property(nonatomic,strong)AVAudioRecorder *recorder;

/** fm*/
@property(nonatomic,strong)NSFileManager *fm;

/** filePath*/
@property(nonatomic,copy)NSString *filePath;

/** cancel*/
@property(nonatomic,assign)BOOL canceled;

@end

@implementation YDV2TTool

+(void)initial:(void (^)(BOOL))getAuth{
    //请求授权
    //NSMicrophoneUsageDescription 获取麦克风语音输入授权
    [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
        if (granted) {
            //NSSpeechRecognitionUsageDescription 语音识别授权的自定义信息
            [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status) {
                BOOL auth = status == SFSpeechRecognizerAuthorizationStatusAuthorized;
                getAuth(auth);
            }];
        }else{
            getAuth(NO);
        }
    }];
}

+(instancetype)shareInstance{
    static dispatch_once_t onceToken;
    static YDV2TTool *tool = nil;
    dispatch_once(&onceToken, ^{
        tool = [[self alloc] init];
    });
    return tool;
}

+(void)emptyV2TTool{
    YDV2TTool *tool = [self shareInstance];
    tool.task = nil;
    tool.sfRec = nil;
    tool.recorder.delegate = nil;
    tool.recorder = nil;
    tool.filePath = nil;
}

#pragma mark - getter
-(SFSpeechRecognizer *)sfRec{
    if (!_sfRec) {
        NSLocale *locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
        _sfRec = [[SFSpeechRecognizer alloc] initWithLocale:locale];
        _sfRec.delegate = self;
    }
    return _sfRec;
}

-(NSFileManager *)fm{
    if (!_fm) {
        _fm = [NSFileManager defaultManager];
    }
    return _fm;
}

#pragma mark - public func
-(void)start{
    if (_recorder) {
        NSLog(@"end");
        [self end];
    }else{
        NSLog(@"start");
        self.filePath = [self recorderFilePath];
        AVAudioFormat *format = [[AVAudioFormat alloc] initWithSettings:[self recorderSettingDict]];
        _recorder = [[AVAudioRecorder alloc] initWithURL:[NSURL fileURLWithPath:self.filePath]
                                                  format:format
                                                   error:nil];
        _recorder.delegate = self;
        [_recorder record];
    }
}

-(void)cancel{
    self.canceled = YES;
    [_recorder stop];
}

-(void)end{
    self.canceled = NO;
    [_recorder stop];
}

#pragma mark - custom func
-(NSMutableDictionary *)recorderSettingDict
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    //设置录音格式
    [dict setObject:@(kAudioFormatAppleIMA4)
             forKey:AVFormatIDKey];
    //设置录音采样率，8000是电话采样率，对于一般录音已经够了
    [dict setObject:@(8000)
             forKey:AVSampleRateKey];
    //设置通道,这里采用单声道
    [dict setObject:@(1)
             forKey:AVNumberOfChannelsKey];
    //每个采样点位数,分为8、16、24、32
    [dict setObject:@(8)
             forKey:AVLinearPCMBitDepthKey];
    //是否使用浮点数采样
    [dict setObject:@(YES)
             forKey:AVLinearPCMIsFloatKey];
    //设置录音质量
    [dict setObject:@(AVAudioQualityMax) forKey:AVEncoderAudioQualityKey];
    return dict;
}

-(NSString *)recorderFilePath{
    NSInteger timeamps = [[NSDate date] timeIntervalSince1970];
    NSString *cachePath = [NSString cachePath:@"v2c_v"];
    if ([self.fm createDirectoryAtPath:cachePath
      withIntermediateDirectories:YES attributes:nil error:nil]) {//创建文件夹
        NSString *filename = [NSString stringWithFormat:@"%zd.caf",timeamps];
        return [cachePath stringByAppendingPathComponent:filename];
    }
    return nil;
}

#pragma mark - delegate
#pragma mark - AVAudioRecorderDelegate
/* audioRecorderDidFinishRecording:successfully: is called when a recording has been finished or stopped. This method is NOT called if the recorder is stopped due to an interruption. */
- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag{
    if (flag && !self.canceled) {
        [self.task cancel];
        
        SFSpeechURLRecognitionRequest *request = [[SFSpeechURLRecognitionRequest alloc] initWithURL:[NSURL fileURLWithPath:self.filePath]];
        request.shouldReportPartialResults = NO;
        
        _task = [self.sfRec recognitionTaskWithRequest:request
                                         resultHandler:^(SFSpeechRecognitionResult * _Nullable result, NSError * _Nullable error) {
                                             if (result) {
                                                 NSLog(@"%@",result.bestTranscription.formattedString);
                                             }
                                             if (error) {//识别错误
                                                 NSLog(@"%@",error);
                                             }
                                         }];
    }
    _recorder.delegate = nil;
    _recorder = nil;
}

/* if an error occurs while encoding it will be reported to the delegate. */
- (void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError * __nullable)error{
    _recorder.delegate = nil;
    _recorder = nil;
}

#pragma mark - SFSpeechRecognizerDelegate
- (void)speechRecognizer:(SFSpeechRecognizer *)speechRecognizer availabilityDidChange:(BOOL)available{//语音识别的是否可用

}

#pragma mark - note
#pragma mark - 音频被打断的通知
-(void)speechPlayerReceiveInterruptedNote:(NSNotification *)note
{
    NSDictionary *noteInfoDict = note.userInfo;
    AVAudioSessionInterruptionType type = [noteInfoDict[AVAudioSessionInterruptionTypeKey] unsignedIntegerValue];
    if (type == AVAudioSessionInterruptionTypeBegan)
    {
        [self cancel];
    }
}

-(void)applicationWillResignActiveNotification:(NSNotification *)note
{
    [self cancel];
}

-(void)applicationWillTerminateNotification:(NSNotification *)note
{

}



-(void)addNote
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(speechPlayerReceiveInterruptedNote:) name:AVAudioSessionInterruptionNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActiveNotification:) name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillTerminateNotification:) name:UIApplicationWillTerminateNotification object:nil];
}

-(void)removeNote
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVAudioSessionInterruptionNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillTerminateNotification object:nil];
}

@end
