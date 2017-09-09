//
//  NSString+YDCountryLang.m
//  YDialogues
//
//  Created by yxf on 2017/9/9.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import "NSString+YDCountryLang.h"

@implementation NSString (YDCountryLang)

+(NSString *)languageWithId:(NSInteger)langId{
    return @"lang";
}

+(NSString *)countryWithId:(NSInteger)countryId{
    return @"country";
}

+(NSString *)countryImgWithId:(NSInteger)countryId{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"flag_1.png" ofType:nil];
    return path;
}

@end
