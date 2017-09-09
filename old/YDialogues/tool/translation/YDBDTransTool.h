//
//  YDBDTransTool.h
//  YDialogues
//
//  Created by yxf on 2017/8/24.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, YDBDLangType) {
    YDBDLangAuto,///<自动识别
    YDBDLangZh,///<中文
    YDBDLangEn,///<英语
    YDBDLangYue,///<粤语
    YDBDLangWyw,///<文言文
    YDBDLangJp,///<日语
    YDBDLangKor,///<韩语
    YDBDLangFra,///<法语
    YDBDLangSpa,///<西班牙语
    YDBDLangTh,///<泰语
    YDBDLangAra,///<阿拉伯语
    YDBDLangRu,///<俄语
    YDBDLangPt,///<葡萄牙语
    YDBDLangDe,///<德语
    YDBDLangIt,///<意大利语
    YDBDLangEl,///<希腊语
    YDBDLangNl,///<荷兰语
    YDBDLangPl,///<波兰语
    YDBDLangBul,///<保加利亚语
    YDBDLangEst,///<艾沙里亚语
    YDBDLangDan,///<丹麦语
    YDBDLangFin,///<芬兰语
    YDBDLangCs,///<捷克语
    YDBDLangRom,///<罗马尼亚语
    YDBDLangSlo,///<斯洛文尼亚语
    YDBDLangSwe,///<瑞典语
    YDBDLanghu,///<匈牙利语
    YDBDLangCht,///<繁体中文
    YDBDLangVie///<越南语
};

@interface YDBDTransTool : NSObject

+(void)transText:(NSString *)text
            from:(YDBDLangType)fromLang
              to:(YDBDLangType)toLang
      completion:(YDTransCompletion)completion;

@end
