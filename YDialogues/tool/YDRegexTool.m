//
//  YDRegexTool.m
//  YDialogues
//
//  Created by yxf on 2017/6/9.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import "YDRegexTool.h"

@implementation YDRegexTool

+(BOOL)isCnWord:(NSString *)word
{
    NSString *regex = @"^[\u4e00-\u9fa5]+$";
    return [self evaluateObj:word WithRegex:regex];
}

+(BOOL)evaluateObj:(NSString *)text WithRegex:(NSString *)regex
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:text];
}


@end
