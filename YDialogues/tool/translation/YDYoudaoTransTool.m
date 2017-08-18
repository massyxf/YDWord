//
//  YDYoudaoTransTool.m
//  YDialogues
//
//  Created by yxf on 2017/8/18.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import "YDYoudaoTransTool.h"
#import "YDNetServerManager.h"
#import "NSString+Hashes.h"
#import "YDYoudaoModel.h"

//id 22abdb49f3ec3b29
//key I1to04WGsAZizsKBVLgKURa6tkigbVvb

#define YDYoudaoUrl @"https://openapi.youdao.com/api"
#define YDYoudaoId @"22abdb49f3ec3b29"
#define YDYoudaoKey @"I1to04WGsAZizsKBVLgKURa6tkigbVvb"

@interface YDYoudaoTransTool ()

@end

@implementation YDYoudaoTransTool

+(instancetype)shareInstance{
    static YDYoudaoTransTool *tool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    });
    return tool;
}

+(void)transText:(NSString *)text from:(YDYoudaoTransLangType)fromLang to:(YDYoudaoTransLangType)toLang complete:(YDTransCompletion)complete{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSString *q = [text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    dict[@"q"] = q;
    dict[@"from"] = [self langFromId:fromLang];
    dict[@"to"] = [self langFromId:toLang];
    dict[@"appKey"] = YDYoudaoId;
    NSNumber *salt = @((NSInteger)[[NSDate date] timeIntervalSince1970]);
    dict[@"salt"] = salt;
    dict[@"sign"] = [NSString stringWithFormat:@"%@%@%@%@",YDYoudaoId,text,salt,YDYoudaoKey].md5.lowercaseString;
    
    [YDNetServerManager transTextWithUrl:YDYoudaoUrl
                                  params:dict
                              completion:^(id result, NSError *error) {
                                  if (error) {
                                      complete(nil,error);
                                      return ;
                                  }
                                  YDYoudaoModel *model = [[YDYoudaoModel alloc] initWithDictionary:result error:&error];
                                  complete(model,error);
                              }];
}


+(NSString *)langFromId:(YDYoudaoTransLangType)langId{
    NSString *langStr = @"auto";
    switch (langId) {
        case YDYoudaoTransLangTypeZh:
            langStr = @"zh-CHS";
            break;
        case YDYoudaoTransLangTypeEn:
            langStr = @"EN";
            break;
        case YDYoudaoTransLangTypeJa:
            langStr = @"ja";
            break;
        case YDYoudaoTransLangTypeKorea:
            langStr = @"ko";
            break;
        case YDYoudaoTransLangTypeFrance:
            langStr = @"fr";
            break;
        case YDYoudaoTransLangTypeRussia:
            langStr = @"ru";
            break;
        case YDYoudaoTransLangTypePotrial:
            langStr = @"pt";
            break;
        case YDYoudaoTransLangTypeSpanish:
            langStr = @"es";
            break;
        default:
            break;
    }
    return langStr;
}

@end
