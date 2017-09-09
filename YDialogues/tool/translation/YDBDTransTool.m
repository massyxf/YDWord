//
//  YDBDTransTool.m
//  YDialogues
//
//  Created by yxf on 2017/8/24.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import "YDBDTransTool.h"
#import "YDNetServerManager.h"
#import "NSString+Hashes.h"

#define YDBDID @"20170823000076045"
#define YDBDKEY @"tIZI9fI8ayou4CdlOBwb"
#define YDBDHOST @"http://api.fanyi.baidu.com/api/trans/vip/translate"

@implementation YDBDTransTool

+(void)transText:(NSString *)text from:(YDBDLangType)fromLang to:(YDBDLangType)toLang completion:(YDTransCompletion)completion{
    NSString *utf8_text = text;
    NSMutableDictionary *params = [self normalParams:utf8_text];
    params[@"q"] = utf8_text;
    params[@"from"] = [self langStrWithType:fromLang];
    params[@"to"] = [self langStrWithType:toLang];
    [YDNetServerManager transTextWithUrl:YDBDHOST
                                  params:params
                              completion:^(NSDictionary *result, NSError *error) {
                                  NSString *dst = [result[@"trans_result"] firstObject][@"dst"];
                                  NSString *src = [result[@"trans_result"] firstObject][@"src"];
                                  NSString *ut8_dst = [dst stringByRemovingPercentEncoding];
                                  NSString *ut8_src = [src stringByRemovingPercentEncoding];
                                  NSLog(@"src:%@,dst:%@,error:%@",ut8_src,ut8_dst,error);
                              }];
}


+(NSMutableDictionary *)normalParams:(NSString *)text{
    NSNumber *salt = @((NSInteger)[[NSDate date] timeIntervalSince1970]);
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"appid"] = YDBDID;
    dict[@"salt"] = salt;
    dict[@"sign"] = [NSString stringWithFormat:@"%@%@%@%@",YDBDID,text,salt,YDBDKEY].md5.lowercaseString;
    return dict;
}

+(NSString *)langStrWithType:(YDBDLangType)langType{
    NSString *langStr = nil;
    switch (langType) {
        case YDBDLangAuto:
            langStr = @"auto";
            break;
        case YDBDLangZh:
            langStr = @"zh";
            break;
        case YDBDLangEn:
            langStr = @"en";
            break;
        case YDBDLangYue:
            langStr = @"yue";
            break;
        case YDBDLangWyw:
            langStr = @"wyw";
            break;
        case YDBDLangJp:
            langStr = @"jp";
            break;
        case YDBDLangKor:
            langStr = @"kor";
            break;
        case YDBDLangFra:
            langStr = @"fra";
            break;
        case YDBDLangSpa:
            langStr = @"spa";
            break;
        case YDBDLangTh:
            langStr = @"th";
            break;
        case YDBDLangAra:
            langStr = @"ara";
            break;
        case YDBDLangRu:
            langStr = @"ru";
            break;
        case YDBDLangPt:
            langStr = @"pt";
            break;
        case YDBDLangDe:
            langStr = @"de";
            break;
        case YDBDLangIt:
            langStr = @"it";
            break;
        case YDBDLangEl:
            langStr = @"el";
            break;
        case YDBDLangNl:
            langStr = @"nl";
            break;
        case YDBDLangPl:
            langStr = @"pl";
            break;
        case YDBDLangBul:
            langStr = @"bul";
            break;
        case YDBDLangEst:
            langStr = @"est";
            break;
        case YDBDLangDan:
            langStr = @"dan";
            break;
        case YDBDLangFin:
            langStr = @"fin";
            break;
        case YDBDLangCs:
            langStr = @"cs";
            break;
        case YDBDLangRom:
            langStr = @"rom";
            break;
        case YDBDLangSlo:
            langStr = @"slo";
            break;
        case YDBDLangSwe:
            langStr = @"swe";
            break;
        case YDBDLanghu:
            langStr = @"hu";
            break;
        case YDBDLangCht:
            langStr = @"cht";
            break;
        case YDBDLangVie:
            langStr = @"vie";
            break;
        default:
            break;
    }
    return langStr;
}

@end
