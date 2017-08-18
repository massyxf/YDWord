//
//  YDYoudaoTransTool.h
//  YDialogues
//
//  Created by yxf on 2017/8/18.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, YDYoudaoTransLangType) {
    YDYoudaoTransLangTypeZh,
    YDYoudaoTransLangTypeEn,
    YDYoudaoTransLangTypeJa,
    YDYoudaoTransLangTypeKorea,
    YDYoudaoTransLangTypeFrance,
    YDYoudaoTransLangTypeRussia,
    YDYoudaoTransLangTypePotrial,
    YDYoudaoTransLangTypeSpanish,
    YDYoudaoTransLangTypeUnknown
};

@interface YDYoudaoTransTool : NSObject

+(void)transText:(NSString *)text
            from:(YDYoudaoTransLangType)fromLang
              to:(YDYoudaoTransLangType)toLang
        complete:(YDTransCompletion)complete;

@end
