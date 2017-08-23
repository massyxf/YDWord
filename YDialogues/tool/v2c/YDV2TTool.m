//
//  YDV2TTool.m
//  YDialogues
//
//  Created by 燕雪峰 on 2017/8/23.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import "YDV2TTool.h"
#import <Speech/Speech.h>

@interface YDV2TTool ()<SFSpeechRecognizerDelegate>

/*rec*/
@property (nonatomic,strong)SFSpeechRecognizer *sfRec;

/*request*/
@property (nonatomic,strong)SFSpeechAudioBufferRecognitionRequest *request;

/*task*/
@property (nonatomic,strong)SFSpeechRecognitionTask *task;

/*engine*/
@property (nonatomic,strong)AVAudioEngine *engine;

/*bool*/
@property (nonatomic,assign)BOOL authorized;

@end

@implementation YDV2TTool

+(instancetype)shareInstance{
    static dispatch_once_t onceToken;
    static YDV2TTool *tool = nil;
    dispatch_once(&onceToken, ^{
        //请求授权
        [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status) {
            if (status == SFSpeechRecognizerAuthorizationStatusAuthorized) {
                tool = [[self alloc] init];
                tool.authorized = YES;
            }else if (status == SFSpeechRecognizerAuthorizationStatusDenied){
                NSLog(@"拒绝之后将不能使用语音转文字功能");
            }
        }];
        //获取权限
        //NSMicrophoneUsageDescription 获取麦克风语音输入授权
        //NSSpeechRecognitionUsageDescription 语音识别授权的自定义信息
    });
    return tool;
}

#pragma mark - getter
-(SFSpeechRecognizer *)sfRec{
    if (!_sfRec) {
        NSLocale *locale = [NSLocale localeWithLocaleIdentifier:@"en-US"];
        _sfRec = [[SFSpeechRecognizer alloc] initWithLocale:locale];
        _sfRec.delegate = self;
    }
    return _sfRec;
}

-(SFSpeechAudioBufferRecognitionRequest *)request{
    if (!_request) {
        _request = [[SFSpeechAudioBufferRecognitionRequest alloc] init];
        _request.shouldReportPartialResults = YES;
    }
    return _request;
}

-(AVAudioEngine *)engine{
    if (!_engine) {
        _engine = [[AVAudioEngine alloc] init];
    }
    return _engine;
}

#pragma mark - public func
-(void)start{
    [self.task cancel];
    
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryRecord mode:AVAudioSessionModeMeasurement options:kNilOptions error:nil];
    AVAudioInputNode *inputNode = self.engine.inputNode;
    if (!inputNode) {
        NSLog(@"inputnode error");
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    _task = [self.sfRec recognitionTaskWithRequest:self.request
                             resultHandler:^(SFSpeechRecognitionResult * _Nullable result, NSError * _Nullable error) {
                                 if (result) {
                                     NSLog(@"%@",result.bestTranscription.formattedString);
                                 }
                                 if (error) {
                                     NSLog(@"%@",error);
                                     [weakSelf.engine stop];
                                     [weakSelf.engine.inputNode removeTapOnBus:0];
                                     weakSelf.request = nil;
                                     weakSelf.task = nil;
                                 }
                             }];
    AVAudioFormat *recordFormat = [inputNode outputFormatForBus:0];
    [inputNode installTapOnBus:0 bufferSize:1024 format:recordFormat block:^(AVAudioPCMBuffer * _Nonnull buffer, AVAudioTime * _Nonnull when) {
        [weakSelf.request appendAudioPCMBuffer:buffer];
    }];
    
    [self.engine prepare];
    if ([self.engine startAndReturnError:nil]) {
        NSLog(@"engine start error");
    }
}

-(void)cancel{

}

-(void)end{

}

@end
