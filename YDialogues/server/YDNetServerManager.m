//
//  YDNetServerManager.m
//  YDialogues
//
//  Created by yxf on 2017/6/9.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import "YDNetServerManager.h"
#import <AFNetworking/AFNetworking.h>
#import "YDRegexTool.h"
#import "YDDBTool.h"

@interface YDNetServerManager ()

/** af manager*/
@property(nonatomic,strong)AFHTTPSessionManager *manager;

@end

@implementation YDNetServerManager

+(instancetype)shareInstance
{
    static YDNetServerManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

#pragma mark - getter
-(AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
        AFJSONResponseSerializer *response = [[AFJSONResponseSerializer alloc] init];
        NSSet *set = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html", nil];
        [response setAcceptableContentTypes:set];
        _manager.responseSerializer = response;
    }
    return _manager;
}

#pragma mark - custom func
+(void)postUrl:(NSString *)url
        params:(NSDictionary *)params
      progress:(void (^)(NSProgress * _Nonnull))uploadProgress
       success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
       failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure
{
    [[YDNetServerManager shareInstance].manager
     POST:url
     parameters:params
     progress:uploadProgress
     success:success
     failure:failure];
//
//    [[YDNetServerManager shareInstance].manager
//     GET:url
//     parameters:params
//     progress:uploadProgress
//     success:success
//     failure:failure];
}

#pragma mark - public
+(void)getWords:(NSString *)words success:(YDNetSuccess)success fail:(YDNetFail)fail
{
//    NSString *jinshancibaUrl = @"http://dict-co.iciba.com/api/dictionary.php";
//    NSString *utf8Word = [NSString stringWithCString:words.UTF8String
//                                            encoding:NSUTF8StringEncoding];
////    NSString *utf8Word = [words stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    
//    //是否为中文单词
//    BOOL isCnWord = [YDRegexTool isCnWord:words];
//    
//    NSDictionary *dict = @{@"w":utf8Word,
//                           @"key":@"6BC5B9A2836DEB79B11BF4234E06E840",
//                           @"type":@"json"};
}

+(void)transTextWithUrl:(NSString *)url params:(NSDictionary *)params completion:(YDTransCompletion)completion{
    [self postUrl:url
           params:params
         progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable result) {
              completion(result,nil);
          } failure:^(NSURLSessionDataTask * _Nullabletask, NSError * _Nonnull error) {
              completion(nil,error);
          }];
}


@end
